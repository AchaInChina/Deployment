@echo off

setlocal ENABLEDELAYEDEXPANSION
mode con: cols=65 lines=25
color 0a
rem �������ȡ����ԱȨ��
:-------------------------------------  
%1 mshta vbscript:createobject("shell.application").shellexecute("""%~0""","::",,"runas",1)(window.close)&&exit /b
CD /D "%~dp0"
:-------------------------------------  

 
:begin

rem ��������

set name=
set Fpath=
set /p name=���������ǽ��������(ʹ�����������):
set /p Fpath=�����������װ·��(C:Program FilesWinRAR):

rem ����õ���������Ϣ
echo ������ķ���ǽ���������ǣ�%name%
echo ������������װ·���ǣ�%Fpath%


echo "ȷ���밴����������밴Ctrl+Cȡ��"
pause

setlocal enabledelayedexpansion
set /a n=0
for /r "%Fpath%" %%i in (*.exe) do (
    set /a n+=1
    echo "!n!_%name%","%%i" 
    netsh advfirewall firewall del rule name="!n!_%name%">nul 2>nul
    netsh advfirewall firewall add rule name="!n!_%name%" program="%%i" action=block dir=out>null
    echo ��ֹ!n!_%name%�����վ��������ӳɹ�
)

rem pause>null

echo.

rem ��begin��ǩ�����ٴ�����
goto begin