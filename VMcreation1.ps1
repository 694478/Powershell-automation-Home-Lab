#script to create virtual machines in Hyper-V

#define virtual machine(vm) names
$vmNames = "VM1", "VM2", "VM3"

#define vm Configuration

$vmConfiguration =@{
    MemoryStartupBytes = 1GB
    }

#Specify the path for virtual hard disk - vhd
$vhdpath = "C:\Program Files\Hyper-V\VMS"

foreach ($vmName in $vmNames){
    $newVHDPath = Join-Path -Path $vhdpath -ChildPath "$vmName.vhdx"

    #Specify the size for the virtual Hard disk in bytes
    $sizeInGB =50

    #CONVERT GB TO BYTES

    $sizeINBytes = [math]::pow(2,30) *$sizeInGB
    
    #create a new VHD
    New-VHD -Path $newVHDPath -SizeBytes $sizeInBytes

    #create a new VM
    New-VM -Name $vmName -MemoryStartupBytes $vmConfiguration.MemoryStartupBytes -NewVHDPath $newVHDPath
    
    #Start the virtual Machine

    Start-VM -Name $vmName
  
    }
