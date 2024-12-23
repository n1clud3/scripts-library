param (
    # Minimum range of number multiplications to practice
    [Parameter(Mandatory=$true, Position=0)]
    [int]$MininumNumber,
    # Maximum range of number multiplications to practice
    [Parameter(Mandatory=$true, Position=1)]
    [int]$MaximumNumber,
    # Number of tasks to generate by script
    [Parameter(Mandatory=$true, Position=2)]
    [int]$TaskCount
)

Write-Host 'Let us begin!'
Write-Host

$TotalTime = 0.0

for ($i = 0; $i -lt $TaskCount; $i++) {
    [int]$Num1 = (Get-Random -Minimum $MininumNumber -Maximum $MaximumNumber)
    [int]$Num2 = (Get-Random -Minimum $MininumNumber -Maximum $MaximumNumber)
    $CorrectAnswer = $Num1 * $Num2

    $TaskStopwatch = [System.Diagnostics.Stopwatch]::StartNew()
    Write-Host -NoNewline "$Num1 * $Num2 = "
    [int]$UserAnswer = Read-Host
    $TaskStopwatch.Stop()

    if ($UserAnswer -eq $CorrectAnswer) {
        Write-Host -NoNewline "Correct!"
    } else {
        Write-Host -NoNewline "Incorrect! Correct answer: $CorrectAnswer."
    }

    Write-Host " Time spent solving: $($TaskStopwatch.Elapsed.TotalSeconds)s"
    Write-Host

    $TotalTime += $TaskStopwatch.Elapsed.TotalSeconds
}

Write-Host "Finished $TaskCount tasks!"
Write-Host "Total time spent: $TotalTime seconds."
