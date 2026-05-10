# ==============================================================================
# Project: System Performance Audit Utility
# Description: Evaluates core system metrics for hardware optimization.
# License: MIT
# ==============================================================================

Write-Host "--- Initiating System Performance Audit ---" -ForegroundColor Cyan

# 1. Check Power Plan Metadata
$PowerPlan = Get-CimInstance -Namespace root\cimv2\power -ClassName Win32_PowerPlan | Where-Object { $_.IsActive }
Write-Host "[+] Active Power Profile: $($PowerPlan.ElementName)" -ForegroundColor Yellow

# 2. BIOS/Firmware Integrity
$BIOS = Get-CimInstance -ClassName Win32_BIOS
Write-Host "[+] BIOS Version: $($BIOS.SMBIOSBIOSVersion)" -ForegroundColor Yellow
Write-Host "[+] Manufacturer: $($BIOS.Manufacturer)" -ForegroundColor Yellow

# 3. CPU Core Siphon
$CPU = Get-CimInstance -ClassName Win32_Processor
Write-Host "[+] Processor Architecture: $($CPU.Name)" -ForegroundColor Yellow
Write-Host "[+] Current Clock Speed: $($CPU.CurrentClockSpeed)MHz" -ForegroundColor Yellow

# 4. Storage Performance Metric
$Disks = Get-PhysicalDisk | Select-Object FriendlyName, MediaType, OperationalStatus
foreach ($Disk in $Disks) {
    Write-Host "[+] Storage Node: $($Disk.FriendlyName) ($($Disk.MediaType)) - Status: $($Disk.OperationalStatus)" -ForegroundColor Green
}

Write-Host "`nAudit 1.0 (Absolute) Complete." -ForegroundColor Cyan
