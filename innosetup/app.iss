[Setup]
AppName=Elyx Launcher
AppPublisher=Elyx
UninstallDisplayName=Elyx
AppVersion=${project.version}
AppSupportURL=https://elyxrsps.com/
DefaultDirName={localappdata}\Elyx

; ~30 mb for the repo the launcher downloads
ExtraDiskSpaceRequired=30000000
ArchitecturesAllowed=x64
PrivilegesRequired=lowest

WizardSmallImageFile=${basedir}/app_small.bmp
WizardImageFile=${basedir}/left.bmp
SetupIconFile=${basedir}/app.ico
UninstallDisplayIcon={app}\Elyx.exe

Compression=lzma2
SolidCompression=yes

OutputDir=${basedir}
OutputBaseFilename=ElyxSetup

[Tasks]
Name: DesktopIcon; Description: "Create a &desktop icon";

[Files]
Source: "${basedir}\app.ico"; DestDir: "{app}"
Source: "${basedir}\left.bmp"; DestDir: "{app}"
Source: "${basedir}\app_small.bmp"; DestDir: "{app}"
Source: "${basedir}\build\win-x64\Elyx.exe"; DestDir: "{app}"
Source: "${basedir}\build\win-x64\Elyx.jar"; DestDir: "{app}"
Source: "${basedir}\build\win-x64\launcher_amd64.dll"; DestDir: "{app}"
Source: "${basedir}\build\win-x64\config.json"; DestDir: "{app}"
Source: "${basedir}\build\win-x64\jre\*"; DestDir: "{app}\jre"; Flags: recursesubdirs

[Icons]
; start menu
Name: "{userprograms}\Elyx\Elyx"; Filename: "{app}\Elyx.exe"
Name: "{userprograms}\Elyx\Elyx (configure)"; Filename: "{app}\Elyx.exe"; Parameters: "--configure"
Name: "{userprograms}\Elyx\Elyx (safe mode)"; Filename: "{app}\Elyx.exe"; Parameters: "--safe-mode"
Name: "{userdesktop}\Elyx"; Filename: "{app}\Elyx.exe"; Tasks: DesktopIcon

[Run]
Filename: "{app}\Elyx.exe"; Parameters: "--postinstall"; Flags: nowait
Filename: "{app}\Elyx.exe"; Description: "&Open Elyx"; Flags: postinstall skipifsilent nowait

[InstallDelete]
; Delete the old jvm so it doesn't try to load old stuff with the new vm and crash
Type: filesandordirs; Name: "{app}\jre"
; previous shortcut
Type: files; Name: "{userprograms}\Elyx.lnk"

[UninstallDelete]
Type: filesandordirs; Name: "{%USERPROFILE}\.Elyx\repository2"
; includes install_id, settings, etc
Type: filesandordirs; Name: "{app}"

[Code]
#include "upgrade.pas"
#include "usernamecheck.pas"
#include "dircheck.pas"