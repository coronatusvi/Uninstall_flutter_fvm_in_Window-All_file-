# Uninstall_flutter_fvm_in_Window-All_file

**Important:** Before you start, make sure you have admin privileges (open Command Prompt as administrator). You can do this by:

1. Pressing the Windows key and typing "cmd".
2. Right-clicking on "Command Prompt" and selecting "Run as administrator".

**1. Uninstall Flutter (if installed via installer):**

- You can't directly uninstall an application through the command line if it was installed using a .exe installer. You would still need to do that through Control Panel as previously described. However if you wish to locate the install location of a program by the name of the executable (in this case Flutter) you can use this command

```cmd
where flutter
```

This will show you where the `flutter` executable is located, you can then navigate to the containing directory in File Explorer, and uninstall it from the Control Panel. If you did not install flutter using an installer proceed to step 3.

**2. Uninstall FVM:**

```cmd
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
```

**3. Remove Flutter SDK (if not installed via installer):**

```cmd
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
```

**4. Remove Flutter Cache:**

```cmd
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
```

**How to use this:**

1.  **Copy the code:** Copy the appropriate block of code (or all of them) into a text editor like Notepad.
2.  **Save as `.bat`:** Save the file with a `.bat` extension (e.g., `uninstall_flutter_fvm.bat`).
3.  **Run as administrator:** Right-click the `.bat` file and select "Run as administrator".
4.  **Review output:** The script will print messages indicating what it's doing, like deleting directories and removing environment variables.

**Explanation of the commands:**

- `cd`: Change directory. `%USERPROFILE%` is a variable for your user directory.
- `rd /s /q`: Remove directory recursively and quietly.
- `reg delete`: Delete a registry entry, which is where environment variables are stored.
- `reg add`: Add or modify a registry entry.
- `findstr /i /c:string`: Searches for a string in a case insensitive manner
- `for /f`: Loops through the output of a command.
- `if exist`: Checks if a directory exists.
- `echo`: Prints a message.
- `>nul 2>&1`: Silences output from a command.

**Important:**

- **Be careful:** These commands will remove data. Review the output and ensure you are removing the intended files and directories.
- **Backup (optional):** If you are unsure, back up any important data first before running these commands.
- **Reboot:** A reboot after removing environment variables and directories is good practice to ensure all the changes take effect.

This approach provides you with a command-line way of removing Flutter and FVM. Let me know if you have any further questions!
