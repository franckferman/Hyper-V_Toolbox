@{
    ModuleVersion = '4.0'
    GUID = '7715ff52-5909-4fd9-8064-28b6857c1d38'
    Author = 'Franck FERMAN'
    Description = 'Interactive PowerShell script for virtual machine management, inspired by Docker and Vagrant.'
    PowerShellVersion = '5.1'
    RequiredModules = @('Hyper-V')
    ScriptsToProcess = @('hyper-v_toolbox.ps1')
    NestedModules = @('hyper-v_toolbox.psm1')
}