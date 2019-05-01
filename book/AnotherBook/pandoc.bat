setlocal

for %%I in (.) do set CurrDirName=%%~nxI

cd src
for %%I in (*.md) do call set "SrcList=%%SrcList%% ""%%I"""
if exist "metadata.yaml" call set "SrcList=%%SrcList%% ""metadata.yaml"""
if exist "template.latex" call set "SrcList=%%SrcList%% --template=""template.latex"""
pandoc -o "..\bin\%CurrDirName%.pdf" %SrcList%

cd ..
endlocal
