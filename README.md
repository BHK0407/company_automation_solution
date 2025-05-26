# Company-POS Auto-Setup

This project helps automate the first-time setup of a Windows-based Point of Sale (POS) terminal after a fresh install. It takes care of things like setting the IP address, creating POS users, renaming the computer, tweaking the taskbar, and turning off those annoying first sign-in prompts — basically speeding up the boring setup stuff so you can move on to the real work faster.

![Setup Image](https://github.com/BHK0407/company_automation_solution/blob/main/images/setup-part1.png)
![Setup Image](https://github.com/BHK0407/company_automation_solution/blob/main/images/setup-part2.png)
![Setup Image](https://github.com/BHK0407/company_automation_solution/blob/main/images/autologin.png)

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

## POS Setup Instructions

---

### **Setup for 1st Login**
This folder contains files used to assign permissions in the Registry Editor.  
> ⚠️ **Note:** Make sure both files are present. In case of issues after running the script, they are required to access the Registry Editor.

---

### **Edit Group Policy**
Used to configure the POS system using the Local Group Policy Editor (`gpedit.msc`).

---

### **Setup Network**
Used to input store information. You only need to provide the store name and the correct POS identifier (e.g., POS01, POS02, etc.).

> ✅ **Troubleshooting errors related to renaming the POS machine:**

| Problem                        | Cause                                         | Solution                              |
|-------------------------------|----------------------------------------------|---------------------------------------| 
| "No input provided" error     | User pressed cancel or left the input empty  | Enter a valid machine name            |
| "Invalid format" error        | Incorrect machine name format                | Use `VNxxxx-POSyy`                    |
| "Out of IP Store Range" error | Store number is too high                     | Double-check the entered store number |
| "No .jpg images found" error  | `imageFolder` is empty or missing            | Add `.jpg` images                     |
| File opening errors           | Missing permissions or files/folders         | Verify folders and permissions        |

---

### **Setup for Form POS Bill**
This folder is used to modify the paper size settings for the receipt printer.

---

### **Audit Settings**
Helps verify file access when scripts run without triggering SmartScreen or Security Warning errors. Also confirms whether the POS billing form is executed successfully.

---

### **Run File**
This script is used to automatically set up the POS system.  
> ✅ To run the setup, execute **`setup-part1.bat`**. If successful, **`setup-part2.bat`** will run automatically after receiving a success flag from part 1. A log file will be generated for troubleshooting.

> ⚠️ **Important:** All setup steps must be executed with **Administrator** privileges.

---

