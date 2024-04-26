<#
Name: srcds manager
Author: n1clude
Description: A startup script that sets parameters for Source Dedicated Server
    and automatically restarts it on crash or shutdown.
Usage: Put the script in the same directory as srcds.exe.
    Then edit the fields in editable section and run the script.
Dependencies: PowerShell 5.1, Source Dedicated Server.
#>

function Add-Argument {
    process {
        if ($args[2]) {
            $args[0] += "$($args[1]) $($args[2]) "
        } else {
            $args[0] += "$($args[1]) "
        }
    }

    end {
        return $args[0]
    }
}

# Editable section
$SleepTime = 5 # How long should the script sleep after server shutdown, in seconds.

# You can add any parameter you want pass to srcds.exe her using the following structure.
[string[]]$srcdsArgumentList
$srcdsArgumentList = Add-Argument $srcdsArgumentList '-secure'
$srcdsArgumentList = Add-Argument $srcdsArgumentList '-console'
$srcdsArgumentList = Add-Argument $srcdsArgumentList '-port' '27015' # Server port
$srcdsArgumentList = Add-Argument $srcdsArgumentList '-game' 'cstrike' # Game name
$srcdsArgumentList = Add-Argument $srcdsArgumentList '+hostname' '"Counter-Strike Source Dedicated Server"' # Server name
$srcdsArgumentList = Add-Argument $srcdsArgumentList '+maxplayers' '16' # Max players
$srcdsArgumentList = Add-Argument $srcdsArgumentList '+sv_setsteamaccount' 'xxx' # Steam GSLT Token. Get it from https://steamcommunity.com/dev/managegameservers
$srcdsArgumentList = Add-Argument $srcdsArgumentList '+map' 'cs_office' # Start map
$srcdsArgumentList = Add-Argument $srcdsArgumentList '+sv_password' 'password' # Server password

$PrintSuppliedArgs = $true # Print supplied arguments on script startup
# Editable section end

Write-Host 'Source Dedicated Server Manager'
if ($PrintSuppliedArgs) { Write-Host "Arguments supplied: $srcdsArgumentList" }
while ($true) {
    Write-Host 'Starting server ...'
    $Process = Start-Process -PassThru -FilePath 'srcds.exe' -ArgumentList $srcdsArgumentList
    Write-Host 'Server is running. Press Ctrl+C to stop this script. Note: Server will not shutdown.'
    Wait-Process $Process.Id
    Write-Host "Server stopped. Restarting in $SleepTime seconds ..."
    Start-Sleep -Seconds $SleepTime
}