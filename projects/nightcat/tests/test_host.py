from conftest import FakeTree
from nightcat.host import Host


def test_memory_from_meminfo(tree: FakeTree) -> None:
    tree.meminfo(8_000_000, 2_000_000, swap_total_kb=1000, swap_free_kb=250)
    mem = tree.host().memory()
    assert mem is not None
    assert mem.total == 8_000_000 * 1024 and mem.available == 2_000_000 * 1024
    assert mem.swap_total == 1000 * 1024 and mem.swap_free == 250 * 1024


def test_memory_without_memavailable(tree: FakeTree) -> None:
    tree.write(
        "proc/meminfo", "MemTotal: 1000 kB\nMemFree: 100 kB\nBuffers: 50 kB\nCached: 150 kB\n"
    )
    mem = tree.host().memory()
    assert mem is not None and mem.available == 300 * 1024


def test_nothing_available_without_procfs_or_psutil(tree: FakeTree) -> None:
    host = tree.host()
    assert host.memory() is None
    assert host.load() is None
    assert host.uptime() is None
    assert host.power() is None
    assert host.processes() is None
    assert host.temperatures() == []


def test_load_and_cpu_count(tree: FakeTree) -> None:
    tree.write("proc/loadavg", "0.50 1.20 0.90 1/234 5678")
    tree.write(
        "proc/cpuinfo",
        "processor\t: 0\nmodel name: i5\n\nprocessor\t: 1\n\nprocessor\t: 2\n\nprocessor\t: 3\n",
    )
    load = tree.host().load()
    assert load is not None
    assert (load.one, load.five, load.fifteen, load.cpus) == (0.5, 1.2, 0.9, 4)


def test_uptime(tree: FakeTree) -> None:
    tree.write("proc/uptime", "12345.67 40000.00")
    assert tree.host().uptime() == 12345.67


def test_temperatures_from_thermal_and_hwmon(tree: FakeTree) -> None:
    tree.write("sys/class/thermal/thermal_zone0/type", "acpitz")
    tree.write("sys/class/thermal/thermal_zone0/temp", "45000")
    tree.write("sys/class/thermal/thermal_zone1/type", "bogus")
    tree.write("sys/class/thermal/thermal_zone1/temp", "0")
    tree.write("sys/class/hwmon/hwmon2/name", "coretemp")
    tree.write("sys/class/hwmon/hwmon2/temp1_input", "61500")
    tree.write("sys/class/hwmon/hwmon2/temp1_label", "Package id 0")
    tree.write("sys/class/hwmon/hwmon2/temp2_input", "58000")
    sensors = {s.label: s.celsius for s in tree.host().temperatures()}
    assert sensors == {"acpitz": 45.0, "coretemp/Package id 0": 61.5, "coretemp/temp2": 58.0}


def test_power_two_batteries_and_ac(tree: FakeTree) -> None:
    tree.ac(True)
    tree.battery(
        "BAT0",
        status="Not charging",
        capacity=80,
        energy_full_design=24000000,
        energy_full=18000000,
        energy_now=14400000,
        cycle_count=412,
        charge_control_end_threshold=100,
    )
    tree.battery(
        "BAT1",
        status="Full",
        capacity=100,
        charge_full_design=2000,
        charge_full=1900,
        charge_now=1900,
    )
    tree.battery("hidpp_battery_0", scope="Device", capacity=10)  # 無線滑鼠，要忽略
    tree.battery("BAT2", present=0)  # 沒插上的電池
    power = tree.host().power()
    assert power is not None and power.ac_online is True
    names = [b.name for b in power.batteries]
    assert names == ["BAT0", "BAT1"]
    bat0, bat1 = power.batteries
    assert bat0.health == 75.0 and bat0.cycle_count == 412
    assert bat0.threshold == 100
    assert bat0.threshold_path == "/sys/class/power_supply/BAT0/charge_control_end_threshold"
    assert bat1.health == 95.0 and bat1.threshold is None and bat1.energy_now == 1900


def test_processes(tree: FakeTree) -> None:
    tree.write("proc/meminfo", "MemTotal: 1 kB\n")
    (tree.root / "proc/101").mkdir(parents=True)
    (tree.root / "proc/101/cmdline").write_bytes(b"python3\x00bot.py\x00--token\x00")
    tree.write("proc/202/cmdline", "")
    tree.write("proc/202/comm", "kworker")
    tree.write("proc/self/cmdline", "ignored")
    procs = dict(tree.host().processes() or [])
    assert procs == {101: "python3 bot.py --token", 202: "[kworker]"}


def test_mounts_keep_real_filesystems(tree: FakeTree) -> None:
    tree.write(
        "proc/mounts",
        "\n".join(
            [
                "/dev/sda2 / ext4 rw 0 0",
                "proc /proc proc rw 0 0",
                "/dev/sda1 /boot/efi vfat rw 0 0",
                "/dev/sdb1 /mnt/backup\\040disk ext4 rw 0 0",
                "tmpfs /run tmpfs rw 0 0",
                "/dev/loop0 /snap/core/1 squashfs ro 0 0",
                "/dev/sda2 / ext4 rw 0 0",
            ]
        ),
    )
    assert tree.host().mounts() == ["/", "/mnt/backup disk"]


def test_run_captures_output(tree: FakeTree) -> None:
    import sys

    out = Host().run([sys.executable, "-c", "import sys; print('hi'); sys.exit(3)"], timeout=10)
    assert out.returncode == 3 and out.stdout.strip() == "hi"
