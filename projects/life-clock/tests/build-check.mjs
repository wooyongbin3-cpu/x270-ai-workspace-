/**
 * Build/PWA checks (no browser): manifest, service worker
 * precache list, and that the build reproduces the web files in dist/.
 */
import assert from "node:assert/strict";
import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { build, WEB_FILES } from "../scripts/build.mjs";

const ROOT = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");
const read = (f) => fs.readFileSync(path.join(ROOT, f), "utf8");
let failures = 0;

function check(name, fn) {
  try {
    fn();
    console.log(`ok   ${name}`);
  } catch (err) {
    failures++;
    console.error(`FAIL ${name}\n     ${err.message}`);
  }
}

check("manifest.json is valid and complete", () => {
  const m = JSON.parse(read("manifest.json"));
  for (const key of ["name", "short_name", "start_url", "display", "icons"]) {
    assert.ok(m[key], `missing ${key}`);
  }
});

check("service worker precaches files that exist (relative URLs)", () => {
  const list = read("sw.js").match(/PRECACHE\s*=\s*\[([^\]]*)\]/);
  assert.ok(list, "PRECACHE array not found in sw.js");
  const urls = [...list[1].matchAll(/["']([^"']+)["']/g)].map((m) => m[1]);
  assert.ok(urls.length > 0, "PRECACHE is empty");
  for (const url of urls) {
    assert.ok(!url.startsWith("/"), `${url} must be relative so the app works under a sub-path`);
    if (url === "./") continue;
    assert.ok(fs.existsSync(path.join(ROOT, url)), `${url} does not exist`);
  }
});

check("service worker is registered with a relative path", () => {
  assert.match(read("index.html"), /serviceWorker\.register\(["']\.\/sw\.js["']/);
});

check("build copies every web file into dist/", () => {
  const dist = build();
  for (const entry of WEB_FILES) {
    assert.ok(fs.existsSync(path.join(dist, entry)), `dist/${entry} missing`);
  }
  assert.equal(fs.readFileSync(path.join(dist, "index.html"), "utf8"), read("index.html"));
});

if (failures) {
  console.error(`\n${failures} check(s) failed`);
  process.exit(1);
}
