@echo off
setlocal

for %%I in (.) do set CurrDirName=%%~nxI

echo --- [BATCH FILE pandoc.bat IN %CurrDirName% BEGIN] ---

cd src

echo (Starting) [Retrieving Source]
echo                                                             ...
set SrcList="001.md" "002.md"
echo                                                             !
echo (Update) [Checking Metadata]
echo                                                             ...
if exist "metadata.yaml" (
    call set "SrcList=%%SrcList%% ""metadata.yaml"""
    echo   FOUND: metadata.yaml
) else (
    echo   MISSING: metadata.yaml
)
if exist "template.latex" (
    call set "SrcList=%%SrcList%% --template=""template.latex"""
    echo   FOUND: template.latex
) else (
    echo   MISSING: template.latex
)

echo                                                             ...
echo (Complete) [Retrieving Source]
echo                                                             !
echo (Starting) [Executing pandoc]
echo                                                             ...
echo pandoc -o "..\bin\something.pdf" "file001.md" "file323.md" "metadata.yaml" and so on

pandoc -o "..\bin\%CurrDirName%.pdf" %SrcList%

echo                                                             ...
echo (Complete) [Executing pandoc]
echo                                                             !
echo                                                             ...
echo   OUT : %CurrDirName%.pdf copied to bin folder

copy "..\bin\%CurrDirName%.pdf" "..\bin\out.pdf"

echo                                                             ...
echo   OUT : bin\out.pdf copied to bin folder
echo                                                             !

cd ..

echo --- [BATCH FILE pandoc.bat END] ---
endlocal


