@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION
TITLE High Performance Bulk Delete with File Display

REM === Get the folder path where this script is located ===
SET "TARGET=%~dp0"
SET "SCRIPT_NAME=%~nx0"
SET "SCRIPT_PATH=%~f0"
REM === Remove trailing backslash ===
SET "TARGET=%TARGET:~0,-1%"

ECHO Target folder to delete: %TARGET%
ECHO.
ECHO WARNING: This will permanently delete potentially thousands of files!
ECHO.
SET /P CONFIRM=Are you sure you want to continue? (Y/N): 

IF /I NOT "%CONFIRM%"=="Y" (
    ECHO Operation cancelled.
    PAUSE
    EXIT
)

REM === Record start time ===
SET START_TIME=%TIME%

ECHO.
ECHO ================================
ECHO [High Performance Deletion Mode]
ECHO ================================

REM === Method 1: Direct enumeration and deletion (exclude script) ===
ECHO Deleting files...
PUSHD "%TARGET%"
FOR /R . %%F IN (*.*) DO (
    IF /I NOT "%%~nxF"=="%SCRIPT_NAME%" (
        ECHO Deleting: %%~nxF
        DEL /F /Q "%%F" 2>NUL
    )
)
POPD

REM === Method 2: Directory removal ===
ECHO.
ECHO Removing directories...
FOR /F "tokens=*" %%D IN ('DIR "%TARGET%" /AD /B /S 2^>NUL') DO (
    IF EXIST "%%D" (
        ECHO Removing: %%~nxD
        RD /Q "%%D" 2>NUL
    )
)

REM === Method 3: Final cleanup - Remove all remaining directories ===
ECHO.
ECHO Final directory cleanup...
FOR /F "tokens=*" %%D IN ('DIR "%TARGET%" /AD /B /S 2^>NUL ^| SORT /R') DO (
    IF EXIST "%%D" (
        ECHO Removing: %%~nxD
        RD /S /Q "%%D" 2>NUL
    )
)

REM === Method 4: Final target folder cleanup (preserve script) ===
ECHO.
ECHO Final cleanup (script will remain)...
FOR /F "tokens=*" %%F IN ('DIR "%TARGET%" /B /A-D 2^>NUL') DO (
    IF /I NOT "%%F"=="%SCRIPT_NAME%" (
        IF EXIST "%TARGET%\%%F" DEL /F /Q "%TARGET%\%%F" 2>NUL
    )
)

REM === Remove empty subdirectories only ===
FOR /F "tokens=*" %%D IN ('DIR "%TARGET%" /AD /B 2^>NUL') DO (
    IF EXIST "%TARGET%\%%D" RD /Q "%TARGET%\%%D" 2>NUL
)

REM === Advanced cleanup for stubborn files (preserve script) ===
ECHO.
ECHO Advanced cleanup for remaining items...

REM === Copy script to temp location ===
SET "TEMP_SCRIPT=%TEMP%\%SCRIPT_NAME%"
COPY "%SCRIPT_PATH%" "%TEMP_SCRIPT%" >NUL 2>&1

REM === Remove attributes from remaining files ===
FOR /F "tokens=*" %%F IN ('DIR "%TARGET%" /B /A-D 2^>NUL') DO (
    IF /I NOT "%%F"=="%SCRIPT_NAME%" (
        ATTRIB -R -A -S -H "%TARGET%\%%F" 2>NUL
        DEL /F /Q "%TARGET%\%%F" 2>NUL
    )
)

REM === Force remove remaining subdirectories ===
FOR /F "tokens=*" %%D IN ('DIR "%TARGET%" /AD /B 2^>NUL') DO (
    ATTRIB -R -A -S -H "%TARGET%\%%D\*" /S /D 2>NUL
    RD /S /Q "%TARGET%\%%D" 2>NUL
)

REM === Restore script if needed ===
IF NOT EXIST "%SCRIPT_PATH%" (
    COPY "%TEMP_SCRIPT%" "%SCRIPT_PATH%" >NUL 2>&1
)
DEL "%TEMP_SCRIPT%" 2>NUL

REM === Calculate result ===
SET END_TIME=%TIME%

ECHO.
ECHO ================================
IF EXIST "%TARGET%" (
    ECHO [WARNING] Folder still exists: %TARGET%
    ECHO Some files may be locked or in use
) ELSE (
    ECHO [SUCCESS] All files and folders deleted
)

ECHO Start time: %START_TIME%
ECHO End time:   %END_TIME%
ECHO ================================

PAUSE
EXIT
