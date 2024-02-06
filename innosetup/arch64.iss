[Setup]
AppName=Cryptic Launcher
AppPublisher=Cryptic
UninstallDisplayName=Cryptic
AppVersion=${project.version}
AppSupportURL=https://zaryte.io/
DefaultDirName={localappdata}\Cryptic

; ~30 mb for the repo the launcher downloads
ExtraDiskSpaceRequired=30000000
ArchitecturesAllowed=arm64
PrivilegesRequired=lowest

WizardSmallImageFile=${basedir}/app_small.bmp
WizardImageFile=${basedir}/left.bmp
SetupIconFile=${basedir}/app.ico
UninstallDisplayIcon={app}\Cryptic.exe

Compression=lzma2
SolidCompression=yes

OutputDir=${basedir}
OutputBaseFilename=CrypticSetupAArch64

[Tasks]
Name: DesktopIcon; Description: "Create a &desktop icon";

[Files]
Source: "${basedir}\build\win-aarch64\Cryptic.exe"; DestDir: "{app}"
Source: "${basedir}\build\win-aarch64\Cryptic.jar"; DestDir: "{app}"
Source: "${basedir}\build\win-aarch64\launcher_aarch64.dll"; DestDir: "{app}"
Source: "${basedir}\build\win-aarch64\config.json"; DestDir: "{app}"
Source: "${basedir}\build\win-aarch64\jre\*"; DestDir: "{app}\jre"; Flags: recursesubdirs
Source: "${basedir}\app.ico"; DestDir: "{app}"
Source: "${basedir}\left.bmp"; DestDir: "{app}"
Source: "${basedir}\app_small.bmp"; DestDir: "{app}"

[Icons]
; start menu
Name: "{userprograms}\Cryptic\Cryptic"; Filename: "{app}\Cryptic.exe"
Name: "{userprograms}\Cryptic\Cryptic (configure)"; Filename: "{app}\Cryptic.exe"; Parameters: "--configure"
Name: "{userprograms}\Cryptic\Cryptic (safe mode)"; Filename: "{app}\Cryptic.exe"; Parameters: "--safe-mode"
Name: "{userdesktop}\Cryptic"; Filename: "{app}\Cryptic.exe"; Tasks: DesktopIcon

[Run]
Filename: "{app}\Cryptic.exe"; Parameters: "--postinstall"; Flags: nowait
Filename: "{app}\Cryptic.exe"; Description: "&Open Cryptic"; Flags: postinstall skipifsilent nowait

[InstallDelete]
; Delete the old jvm so it doesn't try to load old stuff with the new vm and crash
Type: filesandordirs; Name: "{app}\jre"
; previous shortcut
Type: files; Name: "{userprograms}\Cryptic.lnk"

[UninstallDelete]
Type: filesandordirs; Name: "{%USERPROFILE}\.cryptic\repository2"
; includes install_id, settings, etc
Type: filesandordirs; Name: "{app}"

[Code]
#include "upgrade.pas"
#include "usernamecheck.pas"
#include "dircheck.pas"