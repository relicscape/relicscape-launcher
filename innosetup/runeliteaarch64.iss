[Setup]
AppName=Relicscape Launcher
AppPublisher=Relicscape
UninstallDisplayName=Relicscape
AppVersion=${project.version}
AppSupportURL=https://relicscape.com
DefaultDirName={localappdata}\Relicscape

; ~30 mb for the repo the launcher downloads
ExtraDiskSpaceRequired=30000000
ArchitecturesAllowed=arm64
PrivilegesRequired=lowest

WizardSmallImageFile=${project.projectDir}/innosetup/runelite_small.bmp
SetupIconFile=${project.projectDir}/innosetup/runelite.ico
UninstallDisplayIcon={app}\Relicscape.exe

Compression=lzma2
SolidCompression=yes

OutputDir=${project.projectDir}
OutputBaseFilename=RelicscapeSetupAArch64

[Tasks]
Name: DesktopIcon; Description: "Create a &desktop icon";

[Files]
Source: "${project.projectDir}\build\win-aarch64\Relicscape.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "${project.projectDir}\build\win-aarch64\Relicscape.jar"; DestDir: "{app}"
Source: "${project.projectDir}\build\win-aarch64\launcher_aarch64.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "${project.projectDir}\build\win-aarch64\config.json"; DestDir: "{app}"
Source: "${project.projectDir}\build\win-aarch64\jre\*"; DestDir: "{app}\jre"; Flags: recursesubdirs

[Icons]
; start menu
Name: "{userprograms}\Relicscape\Relicscape"; Filename: "{app}\Relicscape.exe"
Name: "{userprograms}\Relicscape\Relicscape (configure)"; Filename: "{app}\Relicscape.exe"; Parameters: "--configure"
Name: "{userprograms}\Relicscape\Relicscape (safe mode)"; Filename: "{app}\Relicscape.exe"; Parameters: "--safe-mode"
Name: "{userdesktop}\Relicscape"; Filename: "{app}\Relicscape.exe"; Tasks: DesktopIcon

[Run]
Filename: "{app}\Relicscape.exe"; Parameters: "--postinstall"; Flags: nowait
Filename: "{app}\Relicscape.exe"; Description: "&Open Relicscape"; Flags: postinstall skipifsilent nowait

[InstallDelete]
; Delete the old jvm so it doesn't try to load old stuff with the new vm and crash
Type: filesandordirs; Name: "{app}\jre"
; previous shortcut
Type: files; Name: "{userprograms}\Relicscape.lnk"

[UninstallDelete]
Type: filesandordirs; Name: "{%USERPROFILE}\.relicscape\repository2"
; includes install_id, settings, etc
Type: filesandordirs; Name: "{app}"

[Registry]
Root: HKCU; Subkey: "Software\Classes\runelite-jav"; ValueType: string; ValueName: ""; ValueData: "URL:runelite-jav Protocol"; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\Classes\runelite-jav"; ValueType: string; ValueName: "URL Protocol"; ValueData: ""; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\Classes\runelite-jav\shell"; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\Classes\runelite-jav\shell\open"; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\Classes\runelite-jav\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\Relicscape.exe"" ""%1"""; Flags: uninsdeletekey

[Code]
#include "upgrade.pas"
#include "usernamecheck.pas"
#include "dircheck.pas"