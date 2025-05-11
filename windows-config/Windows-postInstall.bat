@echo off
setlocal enabledelayedexpansion

rem List of programs to install
set apps=Mozilla.Firefox Microsoft.VisualStudioCode Microsoft.VisualStudio.2022.Community^
 Notepad++.Notepad++ Python.Python3.13 Git.Git Valve.Steam Intel.FortranCompiler VideoLAN.VLC^
 GIMP.GIMP.3 Kitware.ParaView Neovim.Neovim MiKTeX.MiKTeX Microsoft.PowerShell JanDeDobbeleer.OhMyPosh^
 junegunn.fzf

rem Installing loop
for %%A in (%apps%) do (
    echo Installing %%A...
    winget install -e --id %%A --silent --accept-package-agreements --accept-source-agreements --source winget
)

echo Installation completed.


echo Configuring LazyVim.
Move-Item $env:LOCALAPPDATA\nvim $env:LOCALAPPDATA\nvim.bak
Move-Item $env:LOCALAPPDATA\nvim-data $env:LOCALAPPDATA\nvim-data.bak
git clone https://github.com/LazyVim/starter $env:LOCALAPPDATA\nvim
Remove-Item $env:LOCALAPPDATA\nvim\.git -Recurse -Force

pause