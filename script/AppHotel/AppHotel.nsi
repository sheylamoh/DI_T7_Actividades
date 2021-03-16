;NSIS Modern User Interface
;Welcome/Finish Page Example Script
;Written by Joost Verburg

;--------------------------------
;Include Modern UI
!include "MUI2.nsh"
  

;--------------------------------
;General

  ;Name and file
  Name "AppHotel"
  OutFile "AppHotel.exe"
  Unicode True

  ;Default installation folder
  InstallDir "$PROGRAMFILES\AppHotel"

  ;Get installation folder from registry if available
  ;InstallDirRegKey HKCU "Software\Modern UI Test" ""
  InstallDirRegKey HKCU "Software\AppHotel" "$PROGRAMFILES\AppHotel"

  ;Request application privileges for Windows Vista
  RequestExecutionLevel admin

;--------------------------------
;Variables

  Var StartMenuFolder

;--------------------------------
;Interface Settings

  !define MUI_ABORTWARNING
  !define MUI_HEADERIMAGE 
  !define MUI_HEADERIMAGE_BITMAP "apphotel.bmp" ; optional  

;--------------------------------
;Pages

  !insertmacro MUI_PAGE_WELCOME
  !insertmacro MUI_PAGE_LICENSE "text.txt"
  !insertmacro MUI_PAGE_COMPONENTS
  !insertmacro MUI_PAGE_DIRECTORY

  ;menu inicio
  !define MUI_STARTMENUPAGE_REGISTRY_ROOT "HKCU" 
  !define MUI_STARTMENUPAGE_REGISTRY_KEY "Software\AppHotel" 
  !define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "AppHotel"
  
  !insertmacro MUI_PAGE_STARTMENU Application $StartMenuFolder

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

Section "Componentes" SecDummy

  SetOutPath "$INSTDIR"

  ;ADD YOUR OWN FILES HERE...
  ;Nsis7z::Extract "LanzaAyuda.zip"
  ;File LanzaAyuda.zip
  File "AppHotel.7z"
	Nsis7z::Extract "AppHotel.7z"
	Delete "$OUTDIR\AppHotel.7z"

  ;Store installation folder
  WriteRegStr HKCU "Software\AppHotel" "" $INSTDIR

  ;Create uninstaller
  WriteUninstaller "$INSTDIR\Uninstall.exe"

  !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
    
    ;Create shortcuts
    CreateDirectory "$SMPROGRAMS\AppHotel"
    CreateShortcut "$SMPROGRAMS\AppHotel\AppHotel.lnk" "$INSTDIR\AppHotelv3.jar"
    CreateShortcut "$SMPROGRAMS\AppHotel\AppHotel.lnk" "$INSTDIR\Uninstall.exe"
  
  !insertmacro MUI_STARTMENU_WRITE_END

SectionEnd

;--------------------------------
;Descriptions

  ;Language strings
  LangString DESC_SecDummy ${LANG_SPANISH} "AppHotel"

  ;Assign language strings to sections
  !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
    !insertmacro MUI_DESCRIPTION_TEXT ${SecDummy} $(DESC_SecDummy)
  !insertmacro MUI_FUNCTION_DESCRIPTION_END

;--------------------------------
;Uninstaller Section

Section "Uninstall"

  ;ADD YOUR OWN FILES HERE...

  ;RMDir "$INSTDIR\lib\"

  ;RMDir "$INSTDIR"
  RMDir /r /REBOOTOK $INSTDIR

  DeleteRegKey HKCU "Software\AppHotel"

SectionEnd
