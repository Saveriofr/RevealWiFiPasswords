### Save every Wi-fi key in windows pc ###

# save all ssid names in a variable

$ssidlist = netsh wlan show profile

# format the variable as a list
$newssidlist = $ssidlist | ForEach-Object{ $_.Split(':')[1]; }  2>$null

#count ssid list and put it in a variable
$counter = $newssidlist.Count

#while loop for every ssid in the list
while($counter -ne 0)
{
    #new variable with ssid name from list
    $ssid = $newssidlist[$counter-1]

    #format every single ssid name
    $ssid = $ssid.trim()

    #show pass in clear and format
    $netshow = netsh wlan show profile name="$ssid" key=clear
    $keycontent = $netshow | Select-String Contenuto 

    #check if the passowrd is present and write it in a file
    if ( $keycontent -eq $null) 
    {
    Write-Output " " >> passwords.txt
    Write-Output "Nome rete: $ssid " >> passwords.txt
    Write-Output "Contenuto chiave: Nessuna chiave" >> passwords.txt
    }
        else {
    Write-Output " " >> passwords.txt
    Write-Output "Nome rete: $ssid " >> passwords.txt 
    $netshow | Select-String Contenuto >> passwords.txt
         }
    
    $counter = $counter - 1

}