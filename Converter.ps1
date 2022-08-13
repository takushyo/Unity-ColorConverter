$file = Get-Content .\RGB-Table
$filename = Read-Host -Prompt "filename without extension?"
New-Item -ItemType Directory -Force -Path ".\exported" >> $null
$path = ".\exported\$filename.colors"
Out-File $path
$convertedList = Get-Content ".\template.txt" | Out-String
foreach($row in $file){
    $line = $row.Split("`t")
    $line[0] = [System.Math]::Round([decimal]$line[0] / 255.0, 6)
    $line[1] = [System.Math]::Round([decimal]$line[1] / 255.0, 6)
    $line[2] = [System.Math]::Round([decimal]$line[2] / 255.0, 6)
    $convertedList += "  - m_Name: `n"
    $convertedList += @("    m_Color: {r: " + $line[0]+", g: "+$line[1]+", b: "+$line[2] + ", a: 1}`n")
}
$convertedList | Out-File -Encoding utf8 $path

