[Setup]
AppName=Decimation Launcher
AppPublisher=Decimation
UninstallDisplayName=Decimation
AppVersion=${project.version}
AppSupportURL=https://zaryte.io/
DefaultDirName={localappdata}\Decimation

; ~30 mb for the repo the launcher downloads
ExtraDiskSpaceRequired=30000000
ArchitecturesAllowed=x64
PrivilegesRequired=lowest

WizardSmallImageFile=${basedir}/app_small.bmp
WizardImageFile=${basedir}/left.bmp
SetupIconFile=${basedir}/app.ico
UninstallDisplayIcon={app}\Decimation.exe

Compression=lzma2
SolidCompression=yes

OutputDir=${basedir}
OutputBaseFilename=DecimationSetup

[Tasks]
Name: DesktopIcon; Description: "Create a &desktop icon";

[Files]
Source: "${basedir}\app.ico"; DestDir: "{app}"
Source: "${basedir}\left.bmp"; DestDir: "{app}"
Source: "${basedir}\app_small.bmp"; DestDir: "{app}"
Source: "${basedir}\build\win-x64\Decimation.exe"; DestDir: "{app}"
Source: "${basedir}\build\win-x64\Decimation.jar"; DestDir: "{app}"
Source: "${basedir}\build\win-x64\launcher_amd64.dll"; DestDir: "{app}"
Source: "${basedir}\build\win-x64\config.json"; DestDir: "{app}"
Source: "${basedir}\build\win-x64\jre\*"; DestDir: "{app}\jre"; Flags: recursesubdirs

[Icons]
; start menu
Name: "{userprograms}\Decimation\Decimation"; Filename: "{app}\Decimation.exe"
Name: "{userprograms}\Decimation\Decimation (configure)"; Filename: "{app}\Decimation.exe"; Parameters: "--configure"
Name: "{userprograms}\Decimation\Decimation (safe mode)"; Filename: "{app}\Decimation.exe"; Parameters: "--safe-mode"
Name: "{userdesktop}\Decimation"; Filename: "{app}\Decimation.exe"; Tasks: DesktopIcon

[Run]
Filename: "{app}\Decimation.exe"; Parameters: "--postinstall"; Flags: nowait
Filename: "{app}\Decimation.exe"; Description: "&Open Decimation"; Flags: postinstall skipifsilent nowait

[InstallDelete]
; Delete the old jvm so it doesn't try to load old stuff with the new vm and crash
Type: filesandordirs; Name: "{app}\jre"
; previous shortcut
Type: files; Name: "{userprograms}\Decimation.lnk"

[UninstallDelete]
Type: filesandordirs; Name: "{%USERPROFILE}\.decimation\repository2"
; includes install_id, settings, etc
Type: filesandordirs; Name: "{app}"

[Code]
#include "upgrade.pas"
#include "usernamecheck.pas"
#include "dircheck.pas"