@echo off
REM 永恒之蓝预防脚本：关闭文件共享端口
REM For Windows 7 or Higher Only
net session >nul 2>&1
if not "%errorLevel%" == "0" (
  echo Oops: 需要管理员权限！
  echo 程序可能会弹出UAC对话框请求获取管理员权限，请点击【是】继续。
  echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
  echo UAC.ShellExecute "%~s0", "%*", "", "runas", 1 >> "%temp%\getadmin.vbs"

  "%temp%\getadmin.vbs"
  exit /b 2
)

netsh advfirewall firewall add rule name="close445tcp" dir=in protocol=tcp localport=135-139,445 action=block
netsh advfirewall firewall add rule name="close445udp" dir=in protocol=udp localport=135-139,445 action=block

pause
