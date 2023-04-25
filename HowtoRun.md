```PowerShell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force;.\hyper-v_toolbox.ps1
```

This command consists of two parts:

Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force: This part of the command sets the execution policy for the current PowerShell session. The execution policy determines if and how scripts are allowed to run. In this case, the policy is set to Bypass, which means that scripts can run without any restrictions. The -Scope Process parameter indicates that the policy change will only apply to the current PowerShell session (process), and the -Force parameter ensures that the policy is changed without prompting for confirmation. This is necessary to allow the hyper-v_toolbox.ps1 script to run without any restrictions, especially if your system's default execution policy is set to a more restrictive mode.

.\hyper-v_toolbox.ps1: This part of the command runs the hyper-v_toolbox.ps1 script, which is an interactive script that will guide you through the process with prompts and options.

By executing the command, you can run the hyper-v_toolbox.ps1 script in an unrestricted environment, and since the script is interactive, you'll be able to follow the prompts and make selections as needed.