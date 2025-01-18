:: Go to the user profile directory
cd %USERPROFILE%

:: Try to find the .fvm directory and delete if it exists
if exist ".fvm" (
 echo Deleting FVM directory: %USERPROFILE%\.fvm
 rd /s /q ".fvm"
) else (
 echo FVM directory .fvm not found.
)
 :: Try to find the appdata folder, and the fvm directory in it, delete if it exists
 if exist "%USERPROFILE%\AppData\Local\fvm" (
   echo Deleting FVM AppData directory: "%USERPROFILE%\AppData\Local\fvm"
   rd /s /q "%USERPROFILE%\AppData\Local\fvm"
 ) else (
   echo FVM AppData directory not found.
 )


:: Remove FVM_HOME environment variable
reg delete "HKCU\Environment" /v "FVM_HOME" /f >nul 2>&1

:: Remove FVM from PATH user environment variable
for /f "tokens=1* delims==" %%a in ('reg query HKCU\Environment /v PATH 2^>nul ^| findstr /i "PATH"') do (
  set userpath=%%b
  echo %userpath% | findstr /i /c:"fvm" >nul
  if not errorlevel 1 (
      echo Removing fvm from User PATH
      set modifiedpath=%userpath:;%fvm%=;%
      reg add "HKCU\Environment" /v "Path" /t REG_EXPAND_SZ /d "%modifiedpath%" /f
 ) else (
     echo No fvm entries found in user PATH
  )
)


:: Remove FVM from System PATH environment variable
for /f "tokens=1* delims==" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v PATH 2^>nul ^| findstr /i "PATH"') do (
  set systempath=%%b
  echo %systempath% | findstr /i /c:"fvm" >nul
  if not errorlevel 1 (
      echo Removing fvm from System PATH
      set modifiedpath=%systempath:;%fvm%=;%
      reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v "Path" /t REG_EXPAND_SZ /d "%modifiedpath%" /f
 ) else (
     echo No fvm entries found in System PATH
  )
)


echo FVM uninstalled (if present).

:: Go to user profile directory
 cd %USERPROFILE%

  :: Try to find the flutter directory and delete it
 if exist "flutter" (
     echo Deleting Flutter directory: %USERPROFILE%\flutter
     rd /s /q "flutter"
  ) else (
     echo Flutter directory not found.
  )

   ::Go to the root directory
 cd \

  :: Try to find the flutter directory and delete it from the root directory if present
 if exist "flutter" (
     echo Deleting Flutter directory: \flutter
     rd /s /q "flutter"
  ) else (
      echo Flutter directory not found in the root folder.
  )

 :: Remove Flutter environment variable
 reg delete "HKCU\Environment" /v "FLUTTER_HOME" /f >nul 2>&1

 :: Remove flutter path entry from user path
   for /f "tokens=1* delims==" %%a in ('reg query HKCU\Environment /v PATH 2^>nul ^| findstr /i "PATH"') do (
     set userpath=%%b
     echo %userpath% | findstr /i /c:"flutter" >nul
     if not errorlevel 1 (
         echo Removing flutter from User PATH
         set modifiedpath=%userpath:;%flutter%=;%
        reg add "HKCU\Environment" /v "Path" /t REG_EXPAND_SZ /d "%modifiedpath%" /f
     ) else (
        echo No flutter entries found in user PATH
      )
  )
 :: Remove flutter path entry from system path

  for /f "tokens=1* delims==" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v PATH 2^>nul ^| findstr /i "PATH"') do (
     set systempath=%%b
     echo %systempath% | findstr /i /c:"flutter" >nul
     if not errorlevel 1 (
         echo Removing flutter from System PATH
         set modifiedpath=%systempath:;%flutter%=;%
         reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v "Path" /t REG_EXPAND_SZ /d "%modifiedpath%" /f
     ) else (
          echo No flutter entries found in System PATH
      )
  )



 echo Flutter SDK uninstalled (if present).

:: Go to the Local AppData directory
 cd %LOCALAPPDATA%
 :: Try to remove the cache directory
  if exist "Pub\Cache" (
    echo Deleting the Flutter cache directory: %LOCALAPPDATA%\Pub\Cache
     rd /s /q "Pub\Cache"
  ) else (
      echo Flutter cache directory not found
  )
  echo Flutter cache cleared (if present).