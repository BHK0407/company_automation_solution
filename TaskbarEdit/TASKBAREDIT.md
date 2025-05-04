# TaskbarEdit

**TaskbarEdit** is a simple tool I built to automatically clean up and customize the Windows Taskbar for all users. It quietly removes extra UI clutter like News and Task View, resets pinned apps, and takes care of everything in the background with no user input needed.

##  Features

-  Disables **News and Interests**
-  Disables **Task View Button**
-  Resets **Pinned Taskbar Programs**
-  Works **silently** in the background
-  Cleans up all used files and **self-deletes** after execution
-  Triggers `gpupdate` and **auto-restarts** the system for changes to apply

##  File Structure
    TaskbarEdit/
    ├── DisableNewsAndInterests.vbs
    ├── DisableTaskViewButton.vbs
    ├── reset_taskbar_pins.exe
    ├── TaskbarEdit.bat
    └── (self-deletes after running)

##  Usage

    1. Drop the TaskbarEdit folder anywhere you like on your system.
    2. Right-click TaskbarEdit.bat and choose Run as Administrator.
    3. Sit back — it’ll quietly do its thing in the background.
    4. Get a quick message once everything’s done.
    5. Then system will restart automatically to apply the changes.
> ⚠️ Make sure to run as administrator to allow registry and policy changes.

##  Requirements

- Windows 10/11
- Administrator privileges
- Optional: [AutoHotkey](https://www.autohotkey.com/) (for modifying the `.ahk` source of `reset_taskbar_pins.exe`)
