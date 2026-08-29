@echo off
REM Double-click to create a fresh GridBlock world, then just open Minecraft.
setlocal
set /p name=World name (blank = GridBlock):
if "%name%"=="" set name=GridBlock
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0new_gridblock_world.ps1" -Name "%name%" -NewSeed
echo.
echo Done. Open Minecraft and the world "%name%" is ready in your list.
pause
