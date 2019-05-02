cd src
pandoc -o "..\bin\SethAndCain.pdf" ^
    "001.md" ^
    "002.md" ^
    "003.md" ^
    "004.md" ^
    "005.md" ^
    "006.md" ^
    "007.md" ^
    "008.md" ^
    "..\metadata.yaml" ^
    --template="template.latex"
cd ..


