; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyInstName "Demeter Updater for Windows"
#define MyAppVersion "0.9.13"
#define MyAppPublisher "Bruce Ravel"
#define MyAppURL "http://bruceravel.github.com/demeter"
#define Demeter "Demeter with Strawberry Perl"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
;AppId={{D68911A8-D821-4411-AE5D-DA36327C000E}
AppId=Strawberry_Perl_with_Demeter
AppName={#Demeter} {#MyAppVersion}
AppVersion={#MyAppVersion}
AppVerName={#MyInstName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
AppCopyright=Demeter is copyright (c) 2006-2012 Bruce Ravel; Ifeffit is copyright (c) 2008, Matt Newville; Perl is copyright 1987-2011, Larry Wall
AppComments=XAS Data Processing and Analysis

SourceDir=c:\strawberry
OutputDir=c:\output
OutputBaseFilename={#MyInstName} {#MyAppVersion}
DefaultDirName=\strawberry
SetupIconFile=Demeter.ico
WizardImageFile=Demeter_installer.bmp

DefaultGroupName={#Demeter}
LicenseFile=C:\strawberry\Demeter.license.txt
InfoBeforeFile=C:\strawberry\pre_update.txt
InfoAfterFile=C:\strawberry\post_update.txt
Compression=lzma
SolidCompression=yes

UsePreviousAppDir=yes
UsePreviousGroup=yes
UsePreviousSetupType=yes
UsePreviousUserInfo=yes
UsePreviousTasks=yes
CreateUninstallRegKey=no
UpdateUninstallLogAppName=no

[Languages]
Name: english; MessagesFile: compiler:Default.isl

[Files]
Source: perl\site\lib\Demeter.pm; DestDir: {app}\perl\site\lib; Flags: overwritereadonly ignoreversion replacesameversion;
Source: perl\site\lib\Demeter\*; DestDir: {app}\perl\site\lib\Demeter; Flags: recursesubdirs overwritereadonly ignoreversion replacesameversion; Excludes: *.prj,*.stan,*~; 
Source: perl\site\lib\MooseX\SetGet.pm; DestDir: {app}\perl\site\lib\MooseX; Flags: recursesubdirs overwritereadonly ignoreversion replacesameversion; 
Source: perl\site\lib\MooseX\Quenchable.pm; DestDir: {app}\perl\site\lib\MooseX; Flags: recursesubdirs overwritereadonly ignoreversion replacesameversion; 

