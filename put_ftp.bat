@echo off
echo user username > ftpcmd.dat
echo password>> ftpcmd.dat
echo put %1>> ftpcmd.dat
echo quit>> ftpcmd.dat
ftp -n -s:ftpcmd.dat url
del ftpcmd.dat