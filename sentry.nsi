;NSIS Modern User Interface version 1.70
;Welcome/Finish Page Example Script
;Written by Joost Verburg

;--------------------------------
;Include Modern UI

  !include "MUI.nsh"

;--------------------------------
;General

BGGradient 0099FF  FFFFFF 000000
InstallColors /windows



;Name and file
Name "Sentry"
Caption "Sentry"
OutFile "Sentry1.exe"


;Default installation folder
  InstallDir "$PROGRAMFILES\sentry"
  InstallDirRegKey HKLM "Software\Sentry" ""

  
SetCompressor lzma
SetCompressorDictsize 32




!ifdef HAVE_UPX
!packhdr tmp.dat "upx -9 tmp.dat"
!endif 


Section Shortcuts

CreateDirectory "$SMPROGRAMS\sentry"
SetOutPath $INSTDIR 
CreateShortCut "$SMPROGRAMS\sentry\sentry.lnk" "$INSTDIR\sentry.exe"
CreateShortCut "$SMPROGRAMS\sentry\uninstall.lnk" "$INSTDIR\uninstall.exe"

SectionEnd



;--------------------------------
;Interface Settings

  !define MUI_ABORTWARNING

;--------------------------------
;Pages

  !insertmacro MUI_PAGE_WELCOME
  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_INSTFILES
  !insertmacro MUI_PAGE_FINISH
  
  !insertmacro MUI_UNPAGE_WELCOME
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES
  !insertmacro MUI_UNPAGE_FINISH

  
;--------------------------------
;Languages
 
  !insertmacro MUI_LANGUAGE "Spanish"

;--------------------------------
;Installer Sections

Section ""

  SetOutPath "$INSTDIR"
  
  ;ADD YOUR OWN FILES HERE...

File /r c:\sentry\*.* 


  
  ;Store installation folder
  WriteRegStr HKCU "Software\Modern UI Test" "" $INSTDIR
  
  ;Create uninstaller
  WriteUninstaller "$INSTDIR\Uninstall.exe"

SectionEnd


;--------------------------------
;Descriptions


  ;Assign language strings to sections
  !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_FUNCTION_DESCRIPTION_END
 
;--------------------------------
;Uninstaller Section

Section "Uninstall"

  ;ADD YOUR OWN FILES HERE...

  Delete "$INSTDIR\*.*"
  Delete "$INSTDIR\Uninstall.exe"
  Delete "$SMPROGRAMS\*.*"
  RMDir /r "$INSTDIR"
  RMDir /r "$SMPROGRAMS\sentry"


 DeleteRegKey /ifempty HKCU "Software\Modern UI Test"

SectionEnd  


