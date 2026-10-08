@echo off
setlocal

rem ==========================================================
rem  Pinterest Pins Backup
rem  Downloads every pin saved to your Pinterest boards using
rem  gallery-dl, sorted into one folder per board.
rem
rem  Edit PINTEREST_USER below before running.
rem ==========================================================

rem --- Settings ---------------------------------------------
set PINTEREST_USER=your_pinterest_username
set COOKIES=pinterest_cookies.txt
set OUTPUT_DIR=pinterest_downloads
set LOG_FILE=pinterest_download_log.txt
set ARCHIVE=pinterest_archive.sqlite3
rem ----------------------------------------------------------

if "%PINTEREST_USER%"=="your_pinterest_username" (
  echo ERROR: Open this script in a text editor and set PINTEREST_USER to your Pinterest username.
  exit /b 1
)

where gallery-dl >nul 2>&1
if errorlevel 1 (
  echo ERROR: gallery-dl was not found. Install it with:  pip install gallery-dl
  exit /b 1
)

if not exist "%COOKIES%" (
  echo ERROR: Cookie file "%COOKIES%" not found. See README.md for how to export it.
  exit /b 1
)

if not exist "%OUTPUT_DIR%" mkdir "%OUTPUT_DIR%"

call :log "===== Starting Pinterest download for user: %PINTEREST_USER% ====="
call :log "Output directory: %OUTPUT_DIR%"

gallery-dl ^
  --cookies "%COOKIES%" ^
  --dest "%OUTPUT_DIR%" ^
  -o "filename={board[name]!l}/{filename}.{extension}" ^
  --write-log "%LOG_FILE%" ^
  --download-archive "%ARCHIVE%" ^
  -o "skip=true" ^
  "https://www.pinterest.com/%PINTEREST_USER%/_saved/"

set EXIT_CODE=%ERRORLEVEL%
if %EXIT_CODE% EQU 0 (
  call :log "===== Download completed successfully ====="
) else (
  call :log "===== Download finished with errors (exit code: %EXIT_CODE%) ====="
)

call :log "--- Files downloaded per board ---"
for /d %%D in ("%OUTPUT_DIR%\*") do call :count_board "%%D"

call :log "===== Done ====="
exit /b %EXIT_CODE%

:count_board
set count=0
for /f %%F in ('dir /b /a-d "%~1\*" 2^>nul ^| find /c /v ""') do set count=%%F
call :log "  %~nx1: %count% files"
goto :eof

:log
echo [%date% %time%] %~1
echo [%date% %time%] %~1 >> "%LOG_FILE%"
goto :eof
