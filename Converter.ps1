$file = Get-Content .\RGB-Table
$filename = Read-Host -Prompt "filename without extension?"
$convertedList
foreach($row in $file){
    $line = $row.Split("`t")
    $line[0] = [System.Math]::Round([decimal]$line[0] / 255.0, 6)
    $line[1] = [System.Math]::Round([decimal]$line[1] / 255.0, 6)
    $line[2] = [System.Math]::Round([decimal]$line[2] / 255.0, 6)
    $convertedList += "  - m_Name: `n"
    $convertedList += @("    m_Color: {r: " + $line[0]+", g: "+$line[1]+", b: "+$line[2] + ", a: 1}`n")
}

Out-File .\converted.txt
Add-Content .\converted.txt @(Get-Content .\template)
Add-Content .\converted.txt $convertedList
New-Item -ItemType Directory -Force -Path ".\exported" >> $null
Get-Content .\converted.txt | Set-Content -Encoding utf8 .\exported\"$filename.colors"

