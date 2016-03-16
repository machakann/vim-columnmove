@echo off
set VIM=vim
if defined THEMIS_VIM set VIM=%THEMIS_VIM%

%VIM% -u NONE -i NONE -N -n -e -s -S %1
if %errorlevel% neq 0 goto ERROR
echo Succeeded.
exit /b 0

:ERROR
exit /b 1
