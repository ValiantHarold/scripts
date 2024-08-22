$length = 40
# $line = '<[XXXXXXXXX]<:=~~~-----              '.ToCharArray()
# $line = "~^~^~'<====`~^~^~^~^~^~^~^~^~^~^~^~^".ToCharArray()
# $line = '_.~-._.-~._.-._.~-~._.~"(_.~-.'.ToCharArray()
$line = "`"`-._,-'".ToCharArray()

$duration = 5
$updateInterval = 0.1
$startTime = [DateTime]::Now



# $updatesPerCycle = $waveDuration / $updateInterval

while (([DateTime]::Now - $startTime).TotalSeconds -lt $duration) {
   $elapsedTime = ([DateTime]::Now - $startTime).TotalSeconds
   $position = [math]::Floor($elapsedTime / $updateInterval) % $line.Length

   $str = ''

   for ($i = 0; $i -lt $length; $i++) {
      $char = $line[($position + $i) % $line.Length]
      $str += $char
   }
   Write-Host -NoNewline "`r$str"

   Start-Sleep -Seconds $updateInterval
}

Write-Host "`nCompleted"