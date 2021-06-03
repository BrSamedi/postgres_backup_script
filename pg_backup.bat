SET PGBIN=C:\Program Files\PostgreSQL\11\bin
SET PGDATABASE=
SET PGHOST=localhost
SET PGPORT=5432
SET PGUSER=
SET PGPASSWORD=


REM Change working folder
%~d0
CD %~dp0

REM Generate name of bd dump
SET DATETIME=%DATE:~6,4%-%DATE:~3,2%-%DATE:~0,2%_%TIME:~0,2%-%TIME:~3,2%-%TIME:~6,2%
SET DUMPFILE=%PGDATABASE%_%DATETIME%.sql
SET LOGFILE=%PGDATABASE% %DATETIME%.log
SET DUMPPATH=backup\%DUMPFILE%
SET LOGPATH=backup\%LOGFILE%

REM Creating backup
IF NOT EXIST backup MD backup
CALL "%PGBIN%\pg_dump.exe" --format=custom --verbose --file=%DUMPPATH%

REM Waiting result
IF NOT %ERRORLEVEL%==0 GOTO Error
GOTO Successfull

REM Error exception log to file
:Error
DEL %DUMPPATH%
MSG * "Error look to backup.log."
ECHO %DATETIME% Error to create dump of %DUMPFILE%. Look to %LOGFILE%. >> backup.log
GOTO End

REM Success!
:Successfull
ECHO %DATETIME% Successful task! %DUMPFILE% >> backup.log
CALL put_ftp.bat %DUMPPATH%
del %DUMPPATH%
GOTO End
:End
timeout 30
