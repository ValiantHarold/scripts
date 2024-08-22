# $counter = 0
# while ($counter -lt 100) {
#    if (($counter % 2) -eq 0) {
#       if (($counter % 10) -eq 0) {
#          Write-Host -NoNewline "`r{O_o}"
#       } else {

#          Write-Host -NoNewline "`r{o_o}"
#       }
#    } else {
#       Write-Host -NoNewline "`r{-_-}"
#    }
#    Start-Sleep -Seconds 1
#    $counter++
# }

function Write-Header {
   $header = @"
===============================
       My PowerShell Header       
===============================
"@

   # Set the cursor position to the top
   $host.UI.RawUI.CursorPosition = @{X=0; Y=0}
   Write-Host $header -ForegroundColor Cyan
}

# Create a runspace to update the header
$runspacePool = [runspacefactory]::CreateRunspacePool(1, 1)
$runspacePool.Open()

$runspace = [powershell]::Create().AddScript({
   while ($true) {
       Start-Sleep -Seconds 1
       $host.UI.RawUI.CursorPosition = @{X=0; Y=0}
       Write-Host "===============================" -ForegroundColor Cyan
       Write-Host "        My PowerShell Header       " -ForegroundColor Yellow
       Write-Host "===============================" -ForegroundColor Cyan
   }
})
$runspace.RunspacePool = $runspacePool
$runspace.BeginInvoke()

# Clear the screen and write the initial header
Clear-Host
Write-Header

# Enter an interactive mode to allow user commands
while ($true) {
   $command = Read-Host "Enter your command"
   Invoke-Expression $command
}

# Clean up runspace pool
$runspacePool.Close()
$runspacePool.Dispose()