```PowerShell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force;.\hyper-v_toolbox.ps1
```
The command consists of two parts:

Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force: sets the execution policy for the current PowerShell session to bypass, allowing scripts to run without restrictions, and applies only to the current session.

.\hyper-v_toolbox.ps1: runs an interactive script that guides the user through the process with prompts and options.
