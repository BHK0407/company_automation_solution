!include "MUI2.nsh"



!define MUI_ICON "POSRunning.ico"


Name "POS System Setup"
OutFile "POSInstaller.exe"
BrandingText "CopyRight by GS25VN"

!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP "header.bmp"
!define MUI_WELCOMEFINISHPAGE_BITMAP "wizard.bmp"

!define MUI_WELCOMEPAGE_TEXT "This solution was developed through collaborative brainstorming, team research, and strategic planning. It will be automatically deployed within the department's project to streamline the setup of POS machines and head office operations ultimately enhancing the effectiveness of the operations team. The setup will guide you through the installation process of POS System Setup. Please close all other applications before continuing. Click Next to continue or Cancel to exit the Setup Wizard."

RequestExecutionLevel admin

!define MUI_FINISHPAGE_RUN
!define MUI_FINISHPAGE_RUN_FUNCTION "LaunchPOS"

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "license.txt"
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_LANGUAGE "English"

Section "Install POS System"

    ; Create C:\setupPOS
    DetailPrint "Creating directory C:\setupPOS"
    CreateDirectory "C:\setupPOS"

    ; Run 7-Zip silently to extract setupPOS.zip
    DetailPrint "Starting unzip process..."
    MessageBox MB_OK "Now extracting setupPOS.zip with 7-Zip..."

    ; FULLY QUOTED - paths and parameters
    ExecWait '"$EXEDIR\7za.exe" x "$EXEDIR\setupPOS.zip" -oC:\ -y'

    ; Confirm unzip success
    IfFileExists "C:\setupPOS\POSRunning.bat" +2 0
    DetailPrint "Extraction successful!"
    
    ; Optional: inform user if extraction failed
    IfFileExists "C:\setupPOS\POSRunning.bat" 0 show_error
    Goto skip_run

show_error:
    MessageBox MB_ICONSTOP "Extraction failed. POSRunning.bat not found in C:\setupPOS"
    Goto skip_run

skip_run:

SectionEnd

Function LaunchPOS
    Exec '"C:\setupPOS\POSRunning.bat"'
FunctionEnd