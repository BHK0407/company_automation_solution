[Setup]
AppName=POS System Setup
AppVersion=1.0
OutputBaseFilename=POS-Installer
SetupIconFile=POSRunning.ico
AppCopyright=CopyRight by GS25VN
WizardImageFile=wizard.bmp
WizardSmallImageFile=header.bmp
PrivilegesRequired=admin
DisableWelcomePage=no
DisableFinishedPage=no

[Languages]
Name: "en"; MessagesFile: "compiler:Default.isl"

[Files]
; Copy necessary files
 Source: "7za.exe"; DestDir: "{tmp}"; Flags: deleteafterinstall
 Source: "setupPOS.zip"; DestDir: "{tmp}"; Flags: deleteafterinstall
 Source: "license.txt"; DestDir: "{tmp}"; Flags: dontcopy
 
[Dirs]
Name: "C:\setupPOS"

[Run]
; setupPOS.zip unzip to C:\
Filename: "{tmp}\7za.exe"; Parameters: "X {tmp}\setupPOS.zip -oC:\ -y"; Flags: runhidden waituntilterminated
 
; POSRunning.bat
Filename: "C:\setupPOS\POSRunning.bat"; Description: "Launch POS System"; Flags: postinstall runhidden ; Check: FileExistsCheck

[Code]
function FileExistsCheck(): Boolean;
begin
  Result := FileExists('C:\setupPOS\POSRunning.bat');
end;

procedure InitializeWizard;
begin
  MsgBox(
    'This solution was developed through collaborative brainstorming, team research, and strategic planning.'#13#13 +
    'It will be automatically deployed within the department''s project to streamline the setup of POS machines and head office operations, ultimately enhancing the effectiveness of the operations team.'#13#13 +
    'The setup will guide you through the installation process of POS System Setup. Please close all other applications before continuing.'#13 +
    'Click Next to continue or Cancel to exit the Setup Wizard.',
    mbInformation, MB_OK);
end;
