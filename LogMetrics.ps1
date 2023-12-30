# Script to collect and log system performance metrics

$metrics = Get-Counter -Counter "\Processor(_Total)\% Processor Time", "\Memory\Available MBytes", "\PhysicalDisk(_Total)\Disk Read Bytes/sec"

# Log metrics to a file
$metrics | Out-File -FilePath "C:\Project\virtual machines\Log.txt" -Append

