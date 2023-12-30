# Script for automated backup using wbadmin

# Define backup configuration
$backupTarget = "C:\Project\virtual machines\Backup"
$includeSystemState = $true

# Check if the drive exists before creating a directory
if (Test-Path -Path $backupTarget -PathType Container) {
    # Get the current date for creating a unique backup folder name
    $backupFolderName = "Backup_" + (Get-Date -Format "yyyyMMdd_HHmmss")

    # Create a backup folder
    New-Item -ItemType Directory -Path "$backupTarget\$backupFolderName" -Force

    # Build the wbadmin command
    $wbadminCommand = "wbadmin start backup -backupTarget:$backupTarget\$backupFolderName -include:C:"

    if ($includeSystemState) {
        $wbadminCommand += " -allCritical"
    }

    # Start the backup using wbadmin
    Invoke-Expression -Command $wbadminCommand
} else {
    Write-Host "Error: Backup target drive '$backupTarget' does not exist."
}
