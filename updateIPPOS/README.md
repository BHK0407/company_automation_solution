# POS Machine IP and Username Setup Script

A VBScript tool to quickly configure IP addresses and usernames for POS/PC machines, complete with a visual confirmation popup.

![alt text]("GS25VN_automation_setup/updateIPPOS/setupIP.exe Properties 4_28_2025 4_37_56 PM.png")

## Table of Contents

### Features

### Table of Contents

- [Folder Structure](#folder-structure)
- [Prerequisites](#prerequisites)
- [Usage](#usage)
- [Example](#example)
- [Notes](#notes)
- [Troubleshooting](#troubleshooting)

### Features

✅ Input validation for POS/PC name (VNxxxx-POSyy or VNxxxx-PCyy)

✅ Automatic IP and gateway calculation

✅ Updates user.txt and ip.txt files

✅ Random background image selection for popup

✅ Custom popup (fullscreen) using .HTA file

✅ Auto-closes popup after 5 seconds

✅ Error handling for missing files or invalid input

### Folder Structure

    C:\setupPOS\
    ├── info\
    │   ├── user.txt        # Auto-updated username
    │   ├── ip.txt          # Auto-updated IP, Subnet, Gateway
    │   ├── imageFolder\    # Store your .jpg images here
    │   └── popup.hta       # Generated popup file

### Prerequisites

- Windows OS
- mshta.exe available (default on Windows)
- VBScript enabled
- Folder C:\setupPOS\info\imageFolder\ must contain at least one .jpg image

### Usage
    1. Clone this repository or download the script.
    2. Ensure the following folder structure exists under C:\setupPOS\info\.
    3. Place your .jpg background images inside C:\setupPOS\info\imageFolder\.
    4. Double-click the .vbs script to run it.
    5. When prompted, input a valid machine name:

    Example: VN0099-POS01

    Example: VN0099-PC01

The script will:

- Calculate and save the IP and username
- Display a fullscreen popup confirmation

### Example

Input:

    VN0101-POS01

Result:

    Username: VN0101-POS01

    IP Address: 10.1.101.8

    Subnet Mask: 255.255.255.0

    Gateway: 10.1.101.2

(Displayed in a popup with a random background image.)

Notes

- Only POS01, POS02, and PC01 are predefined.

- Other POS numbers (POS03–POS255) are accepted but not predefined.

- If no .jpg images are found, an error will be shown.

- The IP calculation assumes a private 10.x.x.x network.

### Troubleshooting

| Problem                    | Cause                                  | Solution                          |
|-----------------------------|---------------------------------------|-----------------------------------|
| "No input provided" error   | User pressed cancel or left input empty | Enter a valid machine name        |
| "Invalid format" error      | Wrong machine name format             | Use `VNxxxx-POSyy` or `VNxxxx-PCyy` |
| "Out of IP Store Range" error | Store number too high                | Check store number entered        |
| "No .jpg images found" error | `imageFolder` is empty or missing     | Add `.jpg` images                 |
| File opening errors         | Missing permissions or missing folders/files | Verify folders and permissions |


### License

This project is licensed for internal/private use only.

