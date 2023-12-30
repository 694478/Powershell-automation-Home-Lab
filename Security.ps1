# Script to apply security baselines on Windows servers

# Define security baseline configurations
$securityConfig = @{
    UserRightsAssignment = @("SeDenyRemoteInteractiveLogonRight", "SeRemoteInteractiveLogonRight")
    RegistrySettings = @{
        Key = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate"
        Values = @{
            "WUServer" = "http://updateServer"
            "WUStatusServer" = "http://updateServer"
        }
    }
}

# Apply security configurations
$securityConfig.GetEnumerator() | ForEach-Object {
    $configType = $_.Key
    $configValue = $_.Value

    if ($configType -eq 'RegistrySettings') {
        # Check if the registry key exists
        if (-not (Test-Path -Path $configValue.Key)) {
            # Create the parent registry path
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows" -Force
        }

        # Set properties if the key exists
        if (Test-Path -Path $configValue.Key) {
            $configValue.Values.GetEnumerator() | ForEach-Object {
                Set-ItemProperty -Path $configValue.Key -Name $_.Key -Value $_.Value
            }
        }
        else {
            Write-Host "Error: Registry key does not exist - $($configValue.Key)"
        }
    }
    elseif ($configType -eq 'UserRightsAssignment') {
        # Your logic for User Rights Assignment goes here
        # Example: Use ntrights.exe or secedit.exe to set user rights
    }
    else {
        Write-Host "Unsupported security configuration type: $configType"
    }
}
