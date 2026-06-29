[Setup]
AppName=DamnedX Launcher
AppPublisher=DamnedX
UninstallDisplayName=DamnedX
AppVersion=${project.version}
AppSupportURL=https://relicscape.com
DefaultDirName={localappdata}\DamnedX

; ~30 mb for the repo the launcher downloads
ExtraDiskSpaceRequired=30000000
ArchitecturesAllowed=arm64
PrivilegesRequired=lowest

WizardSmallImageFile=${project.projectDir}/innosetup/runelite_small.bmp
SetupIconFile=${project.projectDir}/innosetup/runelite.ico
UninstallDisplayIcon={app}\DamnedX.exe

Compression=lzma2
SolidCompression=yes

OutputDir=${project.projectDir}
OutputBaseFilename=DamnedXSetupAArch64

[Tasks]
Name: DesktopIcon; Description: "Create a &desktop icon";

[Files]
Source: "${project.projectDir}\build\win-aarch64\DamnedX.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "${project.projectDir}\build\win-aarch64\DamnedX.jar"; DestDir: "{app}"
Source: "${project.projectDir}\build\win-aarch64\launcher_aarch64.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "${project.projectDir}\build\win-aarch64\config.json"; DestDir: "{app}"
Source: "${project.projectDir}\build\win-aarch64\jre\*"; DestDir: "{app}\jre"; Flags: recursesubdirs

[Icons]
; start menu
Name: "{userprograms}\DamnedX\DamnedX"; Filename: "{app}\DamnedX.exe"
Name: "{userprograms}\DamnedX\DamnedX (configure)"; Filename: "{app}\DamnedX.exe"; Parameters: "--configure"
Name: "{userprograms}\DamnedX\DamnedX (safe mode)"; Filename: "{app}\DamnedX.exe"; Parameters: "--safe-mode"
Name: "{userdesktop}\DamnedX"; Filename: "{app}\DamnedX.exe"; Tasks: DesktopIcon

[Run]
Filename: "{app}\DamnedX.exe"; Parameters: "--postinstall"; Flags: nowait
Filename: "{app}\DamnedX.exe"; Description: "&Open DamnedX"; Flags: postinstall skipifsilent nowait

[InstallDelete]
; Delete the old jvm so it doesn't try to load old stuff with the new vm and crash
Type: filesandordirs; Name: "{app}\jre"
; previous shortcut
Type: files; Name: "{userprograms}\DamnedX.lnk"

[UninstallDelete]
Type: filesandordirs; Name: "{%USERPROFILE}\.relicscape\repository2"
; includes install_id, settings, etc
Type: filesandordirs; Name: "{app}"

[Registry]
Root: HKCU; Subkey: "Software\Classes\runelite-jav"; ValueType: string; ValueName: ""; ValueData: "URL:runelite-jav Protocol"; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\Classes\runelite-jav"; ValueType: string; ValueName: "URL Protocol"; ValueData: ""; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\Classes\runelite-jav\shell"; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\Classes\runelite-jav\shell\open"; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\Classes\runelite-jav\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\DamnedX.exe"" ""%1"""; Flags: uninsdeletekey

[Code]
#include "upgrade.pas"
#include "usernamecheck.pas"
#include "dircheck.pas"