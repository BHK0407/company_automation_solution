import subprocess
import os
import sys
import ctypes

def resource_path(relative_path):
    try:
        base_path = sys._MEIPASS  # packed PyInstaller
    except Exception:
        base_path = os.path.abspath(".")

    return os.path.join(base_path, relative_path)

def main():
    ctypes.windll.user32.MessageBoxW(
        0,
        "Starting POS installation...",
        "POS Setup",
        0
    )

    zip_file = resource_path("setupPOS.zip")
    exe_7z = resource_path("7za.exe")

    if not os.path.exists(zip_file) or not os.path.exists(exe_7z):
        ctypes.windll.user32.MessageBoxW(0, "Missing setupPOS.zip or 7za.exe!", "Error", 0)
        return

    subprocess.run([exe_7z, "x", zip_file, "-oC:\\", "-y"], check=True)
    subprocess.run(["C:\\setupPOS\\setup-part1.bat"], check=True)

if __name__ == "__main__":
    main()
