@echo off
title MITOOLS 

echo =======================================================================
echo / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / /
timeout /t 1 /nobreak >nul
cls
echo =======================================================================
echo / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / 
timeout /t 1 /nobreak >nul
cls
echo =======================================================================
echo / / / / / / 
timeout /t 1 /nobreak >nul
cls
echo =======================================================================
echo / 
timeout /t 1 /nobreak >nul
goto main_menu

:main_menu
cls
echo ==============================
echo.
echo 1. Reboot phone to fastboot
echo 2. Checking, if phone unlocked
echo 3. Flash bootlogo
echo 4. Flash root
echo 5. Flash recovery
echo 6. Flash vbmeta 
echo 7. Flash system 
echo 8. Screen broadcast
echo 9. Live boot

echo.
set /p choice=Select number to action: 

if "%choice%"=="1" goto fastbootmode
if "%choice%"=="2" goto ifphoneunlocked
if "%choice%"=="3" goto bootlogo
if "%choice%"=="4" goto root
if "%choice%"=="5" goto recovery
if "%choice%"=="6" goto vbmeta
if "%choice%"=="7" goto system
if "%choice%"=="8" goto broadcast
if "%choice%"=="9" goto liveboot

echo ==============================
echo Error: command dont exist
pause
goto main_menu

:fastbootmode
cls
cd C:\MI TOOLS\pt
cls
echo ============================================
echo Rebooting to fastboot
adb reboot bootloader
cls
echo =============================================
echo Successfully, phone rebooted to fastboot mode
goto main_menu 

rem плакала очень много блять шалавочка))

:ifphoneunlocked
cls
cd C:\MI TOOLS\pt
cls
echo =================================================================================================
echo Unfortunately, to find out the status of the bootloader need to reboot the phone to fastboot mode
echo.
set /p confirm=Do you agree to a reboot? (y/n)

if /i "%confirm%"=="y" (
    cls
    echo ==========================================
    echo Rebooting to fastboot
    adb reboot bootloader
    
    fastboot getvar unlocked

    fastboot reboot
    echo.
    echo Rebooting to system
    echo.
    pause
    goto main_menu
)

) else if /i "%confirm%"=="n" (
    echo Exit to main menu
    goto main_menu
) else (
    goto main_menu
)

:bootlogo
cls
cd C:\MI TOOLS\pt
cls
echo =================================================================
echo In order to flash BOOTLOGO, you need to customize it.
echo Also, you need to reboot the phone into fastboot.
echo Please put the customized logo in the folder *fl.* Customizing it
echo when you put the *logo.bin* file in the *fl* folder,
echo then write Y to start the operation.
echo.
set /p confirm=Do you agree (y/n): 

if /i "%confirm%"=="y" (
    cls
    echo ==========================================
    echo Rebooting to fastboot
    cd /d "C:\MI TOOLS\fl"
    adb reboot bootloader
    fastboot flash logo logo.bin
    
    echo Flashed

    fastboot reboot
    echo.
    cls
    echo ====================================
    echo Rebooting to system 
    echo.
    pause
    goto main_menu
)

) else if /i "%confirm%"=="n" (
    echo Exit to main menu
    goto main_menu
) else (
    goto main_menu
)

:root
cls
cd C:\MI TOOLS\pt
cls
echo =================================================================================
echo To flash ROOT, you need an unlocked bootloader as well as a “patched” stock boot.
echo REDMI TOOLS cannot provide you with a stock boot with root rights, since the boot
echo is available for different phone models. With your permission, install magisk.apk
echo on your device, all you need is boot.img from your stock firmware for your phone. 
echo Once you have extracted boot.img and moved it to the *fl* folder press Y.
echo.
set /p confirm=You ready? (y/n): 

if /i "%confirm%"=="y" (
    cls
    echo ==========================================
    echo Installing magisk.apk
    cd /d "C:\MI TOOLS\apk"
    adb install magisk.apk
    cls
    echo ===================================================
    echo ATTENTION! I repeat, put boot.img in the fl folder.
    echo If you stuck it, wait 20 seconds, after which your 
    echo phone will reboot into fastboot mode and flash the boot.
    timeout /t 20 /nobreak >nul
    adb reboot bootloader
    fastboot flash boot.img
    echo Flashed
    cls

    echo ====================================
    echo The phone will reboot in 10 seconds.
    timeout /t 10 /nobreak >nul
    fastboot reboot
    echo.
    cls
    echo ====================================
    echo Rebooting to system 
    echo.
    pause
    goto main_menu
)

) else if /i "%confirm%"=="n" (
    echo Exit to main menu
    goto main_menu
) else (
    goto main_menu
)

:liveboot
cls
cd C:\MI TOOLS\pt
cls
echo =================================================================================
echo Live Boot is not a custom boot animation with some kind of GIF. Live boot is a 
echo function thanks to which, instead of the standard boot animation, you will have
echo a thousand running lines. 
echo WARNING! In order to install this function, root rights are required. 
echo Write Y if you have them and N if you don’t.
echo.
set /p confirm=You ready? (y/n): 

if /i "%confirm%"=="y" (
    cls
    echo ==========================================
    echo Installing live.apk
    cd /d "C:\MI TOOLS\apk
    adb install liveboot.apk
    
    echo Installed
    echo Exit to main menu
    echo.
    pause
    goto main_menu
)

) else if /i "%confirm%"=="n" (
    echo Exit to main menu
    goto main_menu
) else (
    goto main_menu
)

:recovery
cls
cd C:\MI TOOLS\pt
cls
echo =================================================================
echo Custom recovery is needed for flashing NON-GSI firmware and more.
echo WARNING! Place the recovery itself in the *FL* folder.
echo.
set /p confirm=You ready? (y/n): 

if /i "%confirm%"=="y" (
    cls
    echo ==========================================
    echo Rebooting to fastboot
    cd /d "C:\MI TOOLS\fl
    adb reboot bootloader
    echo Flashing
    fastboot flash boot boot.img
    echo.
    echo Flashed!
    echo.
    pause
    goto main_menu
    
)

) else if /i "%confirm%"=="n" (
    echo Exit to main menu
    goto main_menu
) else (
    goto main_menu
)

:vbmeta
cls
cd C:\MI TOOLS\pt
cls
echo =============================================
echo VBMETA is a function that can throw the error
echo "Your phone has been destroyed." And it needs 
echo to be patched so that the bottle doesn’t have
echo the inscription “DM-Verify corrupt”
echo. 
set /p confirm=You ready? (y/n): 

if /i "%confirm%"=="y" (
    cls
    echo ==========================================
    echo Rebooting to fastboot
    cd /d "C:\MI TOOLS\fl
    adb reboot bootloader
    echo Flashing
    fastboot --disable-verity --disable-verification flash vbmeta vbmeta.img
    echo.

    echo Flashed!
    echo.
    pause
    goto main_menu
    
)

) else if /i "%confirm%"=="n" (
    echo Exit to main menu
    goto main_menu
) else (
    goto main_menu
)

:broadcast
cls
echo =============================================================
echo Scrcpy is a universal program for screen casting. 
echo And we implemented it in RT! Please enable USB 
echo debugging before running this feature. And write Y if enabled.
echo.
set /p confirm=You ready? (y/n): 

if /i "%confirm%"=="y" (
    cls
    echo ==========================================
    echo Launch scrpy
    cd /d C:\MI TOOLS\sc
    scrcpy.exe
    echo Connected!
    echo.
    pause
    goto main_menu
    
)

) else if /i "%confirm%"=="n" (
    echo Exit to main menu
    goto main_menu
) else (
    goto main_menu
)

:system
cls
cd C:\MI TOOLS\pt
cls
echo =============================================================
echo You need to flash the system if the system already lags a lot
echo or you just want to ;)
echo.
set /p confirm=You ready? (y/n): 

if /i "%confirm%"=="y" (
    cls
    echo ==========================================
    echo Rebooting to fastbootd
    cd /d C:\MI TOOLS\fl
    adb reboot fastboot
    fastboot flash system system.img
    echo.
    echo Flashed!
    echo Please, wipe data after flash.
    echo.
    pause
    goto main_menu
    
)


