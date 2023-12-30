# DSC Configuration script for configuring Windows Server roles and features

configuration ServerConfig {
    param (
        [string]$NodeName
    )

    Node $NodeName {
        WindowsFeature WebServerRole {
            Ensure = "Present"
            Name   = "Web-Server"
        }

        WindowsFeature FileServerRole {
            Ensure = "Present"
            Name   = "File-Services"
        }

        # Add more configurations as needed
    }
}

# Generate MOF file
ServerConfig -NodeName "YourTargetNodeName" -OutputPath "C:\DSC\Config"

# Apply DSC configuration
Start-DscConfiguration -Path "C:\DSC\Config" -Wait -Force
