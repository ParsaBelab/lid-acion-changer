# Ensure the script is running as Administrator
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process PowerShell -ArgumentList " -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# Define actions
$lidActions = @{
    1 = "Sleep"
    2 = "Shut down"
    3 = "Do nothing"
}

# Show menu for selecting action
Write-Host "Select laptop lid action:"
Write-Host "1 - Sleep"
Write-Host "2 - Shut down"
Write-Host "3 - Do nothing"

$selection = Read-Host "Enter your choice (1/2/3): "

if ($lidActions.ContainsKey([int]$selection)) {
    $action = $lidActions[[int]$selection]
    Write-Host "You selected: $action"
    
    # Get the current power scheme GUID
    $powerSchemeOutput = powercfg /getactivescheme
    $guidMatch = $powerSchemeOutput | Select-String -Pattern 'GUID:\s+([A-F0-9\-]+)'

    if ($guidMatch) {
        $guid = $guidMatch.Matches[0].Groups[1].Value.Trim()

        # Set the lid action in power settings (AC and DC)
        switch ([int]$selection) {
            1 {
                powercfg /SETACVALUEINDEX $guid SUB_BUTTONS LIDACTION 1 2>&1 | Out-Null
                powercfg /SETDCVALUEINDEX $guid SUB_BUTTONS LIDACTION 1 2>&1 | Out-Null
            }
            2 {
                powercfg /SETACVALUEINDEX $guid SUB_BUTTONS LIDACTION 2 2>&1 | Out-Null
                powercfg /SETDCVALUEINDEX $guid SUB_BUTTONS LIDACTION 2 2>&1 | Out-Null
            }
            3 {
                powercfg /SETACVALUEINDEX $guid SUB_BUTTONS LIDACTION 0 2>&1 | Out-Null
                powercfg /SETDCVALUEINDEX $guid SUB_BUTTONS LIDACTION 0 2>&1 | Out-Null
            }
        }

        # Apply the active power scheme
        powercfg /S $guid 2>&1 | Out-Null
        Write-Host "Lid close action has been updated to $action."
    } else {
        Write-Host "[ERROR] Failed to extract valid GUID from the active power scheme."
    }
} else {
    Write-Host "Invalid selection. Please select 1, 2, or 3."
}
