echo 'call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvars64.bat">NUL' > /mnt/c/Users/s/cl.bat
echo '"C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Tools\MSVC\14.28.29910\bin\Hostx64\x64\cl.exe" %*' >> /mnt/c/Users/s/cl.bat
alias cl="cmd.exe /q /c C:/Users/s/cl.bat"

echo 'call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvarsamd64_x86.bat">NUL' > /mnt/c/Users/s/cl32.bat
echo '"C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Tools\MSVC\14.28.29910\bin\Hostx64\x86\cl.exe" %*' >> /mnt/c/Users/s/cl32.bat
alias cl32="cmd.exe /q /c C:/Users/s/cl32.bat"

echo 'call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvars64.bat"' > /mnt/c/Users/s/windev.bat
alias windev="cmd.exe /k C:/Users/s/windev.bat"
echo 'call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvarsamd64_x86.bat"' > /mnt/c/Users/s/windev32.bat
alias windev32="cmd.exe /k C:/Users/s/windev32.bat"
