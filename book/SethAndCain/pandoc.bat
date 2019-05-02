@echo off
setlocal

for %%I in (.) do set CurrDirName=%%~nxI

echo (Starting) [Executing pandoc.bat for %CurrDirName%]
echo                                                             ...

cd src

echo (Starting) [Retrieving Source]
echo                                                             ...
for %%I in (*.md) do (
    call set "SrcList=%%SrcList%% ""%%I"""
    echo   SRC : %%I
)
echo (Update) [Checking Metadata]
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

echo (Complete) [Retrieving Source]
echo                                                             !
echo (Starting) [Executing pandoc]
echo                                                             ...
echo pandoc -o "..\bin\something.pdf" "file001.md" "file323.md" "metadata.yaml" and so on

pandoc -o "..\bin\%CurrDirName%.pdf" %SrcList%

echo (Complete) [Executing pandoc]
echo                                                             !
echo   OUT : %CurrDirName%.pdf copied to bin folder

cd ..

echo (Complete) [Executing pandoc.bat for %CurrDirName%]
echo                                                             !
endlocal

