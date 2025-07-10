#Step 1: Export event logs
$path = (Get-Location).Path + "\System.csv"
Get-WinEvent -LogName System -MaxEvents 10 |  Select-Object TimeCreated, Id, LevelDisplayName, Message | Export-Csv -Path $path -NoTypeInformation


# Step 2: Prepare MySQL table

        # CREATE DATABASE IF NOT EXISTS logs;
        # USE logs;

        # CREATE TABLE IF NOT EXISTS system_log (
        #   id INT AUTO_INCREMENT PRIMARY KEY,
        #   TimeCreated DATETIME,
        #   EventId INT,
        #   Level VARCHAR(50),
        #   Message TEXT
        # );


# Install-Module MySQL.Data
Add-Type -Path "C:\Program Files (x86)\MySQL\MySQL Installer for Windows\MySql.Data.dll"

# Read CSV
$logs = Import-Csv $path 

# Connect to MySQL
$conn = New-Object MySql.Data.MySqlClient.MySqlConnection
$conn.ConnectionString = "server=localhost;user=root;password=123456789;database=logs;port=3306"
$conn.Open()

foreach ($log in $logs) {

    $timeCreated = Get-Date $log.TimeCreated -Format "yyyy-MM-dd HH:mm:ss"

    $query = "INSERT INTO system_log (TimeCreated, EventId, Level, Message) VALUES (@TimeCreated, @EventId, @Level, @Message)"
    $cmd = $conn.CreateCommand()
    $cmd.CommandText = $query
    $cmd.Parameters.AddWithValue("@TimeCreated", $timeCreated)
    $cmd.Parameters.AddWithValue("@EventId", $log.Id)
    $cmd.Parameters.AddWithValue("@Level", $log.LevelDisplayName)
    $cmd.Parameters.AddWithValue("@Message", $log.Message)
    $cmd.ExecuteNonQuery()
}

$conn.Close()