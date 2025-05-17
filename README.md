# Company-POS Auto-Setup

This project helps automate the first-time setup of a Windows-based Point of Sale (POS) terminal after a fresh install. It takes care of things like setting the IP address, creating POS users, renaming the computer, tweaking the taskbar, and turning off those annoying first sign-in prompts — basically speeding up the boring setup stuff so you can move on to the real work faster.

##  Folder Structure
    ├── setup-part1.bat # Main script for initial system setup
    ├── setup-part2.bat # Continuation script executed after reboot
    ├── info
    │ ├── ip.txt # Static IP to be configured
    │ ├── user.txt # Username used for user creation and renaming PC
    │ └── setupIP.exe # Custom tool for internal network setup
    ├── TaskbarEdit
    │ ├── DisableNewsAndInterests.vbs 
    │ ├── DisableTaskViewButton.vbs
    │ └── HiddenSearch.vbs
    ├── BlockFirstSignIn
    │ ├── Disable_Privacy_settings_experience_on_user_logon.reg
    │ ├── Disable_User_First_Sign-in_Animation.reg

##  Key Features

- Set static IP and DNS configuration
- Disable IPv6 on all network adapters
- Create a local user with:
  - Password never expires
  - Password change disabled
- Rename the computer to match the username
- Customize the Windows Taskbar:
  - Hide search box
  - Disable Task View button
  - Disable News and Interests
- Disable first sign-in animation and privacy setup screen
- Create a `after_reboot.flag` file to signal Part 1 is done
- Automatically register `setup-part2.bat` to run on next login (via `RunOnce`)
- Log all steps into `setup-part1.log` and `setup-part2.log` for debugging and tracking
