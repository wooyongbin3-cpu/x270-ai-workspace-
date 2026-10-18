/**
 * Copy the static web app into dist/ (Capacitor's webDir).
 * dist/ is a build output — edit the files in the project root, never dist/.
 */
import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

const ROOT = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");
const DIST = path.join(ROOT, "dist");
export const WEB_FILES = ["index.html", "manifest.json", "sw.js", "assets"];

export function build() {
  fs.rmSync(DIST, { recursive: true, force: true });
  fs.mkdirSync(DIST, { recursive: true });
  for (const entry of WEB_FILES) {
    fs.cpSync(path.join(ROOT, entry), path.join(DIST, entry), { recursive: true });
  }
  return DIST;
}

if (process.argv[1] === fileURLToPath(import.meta.url)) {
  console.log(`built ${path.relative(ROOT, build())}/ (${WEB_FILES.join(", ")})`);
}
