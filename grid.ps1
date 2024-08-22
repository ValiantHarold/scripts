$length = 40
$line = "`"`-._,-'".ToCharArray()

$duration = 5
$updateInterval = 0.2
$startTime = [DateTime]::Now

$consoleWidth = [Console]::WindowWidth
$consoleHeight = [Console]::WindowHeight

$rows = [math]::Min([math]::Ceiling($length / $line.Length) + 2, $consoleHeight)
$columns = [math]::Min([math]::Ceiling($length / $rows) + 2, $consoleWidth)

function Write-AtPosition {
   param (
       [int]$x,
       [int]$y,
       [string]$text
   )
   [Console]::SetCursorPosition($x, $y)
   Write-Host -NoNewline "`r$text"
}

# $updatesPerCycle = $waveDuration / $updateInterval

while (([DateTime]::Now - $startTime).TotalSeconds -lt $duration) {
   $elapsedTime = ([DateTime]::Now - $startTime).TotalSeconds
   $position = [math]::Floor($elapsedTime / $updateInterval) % $line.Length

   # [Console]::SetCursorPosition(0, 0)
   # for ($i = 0; $i -lt $consoleHeight; $i++) {
   #    Write-Host (" " * $consoleWidth)
   # }

   for ($i = 0; $i -lt $rows; $i++) {
      $str = ''

      for ($j = 0; $j -lt $columns; $j++) {
         if ($i -eq 0) {
             # Top row moving left to right
             $char = $line[($position + $j) % $line.Length]
         } elseif ($j -eq ($columns - 1)) {
             # Right column moving down
             $char = $line[($position + $rows + $i) % $line.Length]
         } elseif ($i -eq ($rows - 1)) {
             # Bottom row moving right to left
             $char = $line[($position + $rows + $columns + ($columns - $j - 1)) % $line.Length]
         } elseif ($j -eq 0) {
             # Left column moving up
             $char = $line[($position + $rows + $columns + $rows + ($rows - $i - 1)) % $line.Length]
         } else {
             $char = ' '
         }
         $str += $char
      }
      Write-AtPosition 0 $i $str

      Start-Sleep -Seconds $updateInterval
   }
}
Write-Host "`nCompleted"
















# # Function to display the grid
# $size = 9
# $char = '#'
# $blank = ' '

# function Show-Grid($grid) {
#    $grid | ForEach-Object { Write-Host ($_ -replace '', ' ') }
# }

# # Initialize an empty 9x9 grid
# $grid = @()
# for ($i = 0; $i -lt $size; $i++) {
#    $grid += ' ' * $size
# }

# # Define the border positions for the 9x9 square
# $borderPositions = @(
#    # Top row (left to right)
#    [PSCustomObject]@{Row=0; Col=0},
#    [PSCustomObject]@{Row=0; Col=1},
#    [PSCustomObject]@{Row=0; Col=2},
#    [PSCustomObject]@{Row=0; Col=3},
#    [PSCustomObject]@{Row=0; Col=4},
#    [PSCustomObject]@{Row=0; Col=5},
#    [PSCustomObject]@{Row=0; Col=6},
#    [PSCustomObject]@{Row=0; Col=7},
#    [PSCustomObject]@{Row=0; Col=8},
   
#    # Right column (top to bottom)
#    [PSCustomObject]@{Row=1; Col=8},
#    [PSCustomObject]@{Row=2; Col=8},
#    [PSCustomObject]@{Row=3; Col=8},
#    [PSCustomObject]@{Row=4; Col=8},
#    [PSCustomObject]@{Row=5; Col=8},
#    [PSCustomObject]@{Row=6; Col=8},
#    [PSCustomObject]@{Row=7; Col=8},
#    [PSCustomObject]@{Row=8; Col=8},
   
#    # Bottom row (right to left)
#    [PSCustomObject]@{Row=8; Col=7},
#    [PSCustomObject]@{Row=8; Col=6},
#    [PSCustomObject]@{Row=8; Col=5},
#    [PSCustomObject]@{Row=8; Col=4},
#    [PSCustomObject]@{Row=8; Col=3},
#    [PSCustomObject]@{Row=8; Col=2},
#    [PSCustomObject]@{Row=8; Col=1},
#    [PSCustomObject]@{Row=8; Col=0},
   
#    # Left column (bottom to top)
#    [PSCustomObject]@{Row=7; Col=0},
#    [PSCustomObject]@{Row=6; Col=0},
#    [PSCustomObject]@{Row=5; Col=0},
#    [PSCustomObject]@{Row=4; Col=0},
#    [PSCustomObject]@{Row=3; Col=0},
#    [PSCustomObject]@{Row=2; Col=0},
#    [PSCustomObject]@{Row=1; Col=0}
# )

# # # Animation duration
# $duration = 10 # seconds
# $startTime = [DateTime]::Now
# $previousIndex = $null

# # Loop to animate the '#' character around the border
# while (([DateTime]::Now - $startTime).TotalSeconds -lt $duration) {

#    # Calculate current position
#    $elapsedTime = ([DateTime]::Now - $startTime).TotalSeconds
#    $currentIndex = [math]::Floor($elapsedTime * 10) % $borderPositions.Count
   
#    if ($null -ne $previousIndex) {
#       $previousPosition = $borderPositions[$previousIndex]
#       [console]::SetCursorPosition($previousPosition.Col, $previousPosition.Row)
#       Write-Host $blank -NoNewline
#    }

#    # Place the '#' character at the current position
#    $position = $borderPositions[$currentIndex]
#    [console]::SetCursorPosition($position.Col, $position.Row)
#    Write-Host $char -NoNewline

#    $previousIndex = $currentIndex
   
#    # Show the grid
#    Show-Grid $grid
   
#    # Pause for a short duration before updating
#    Start-Sleep -Milliseconds 20
# }