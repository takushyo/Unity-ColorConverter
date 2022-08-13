Remove-Item .\Export\* -Recurse -Force
New-Item -ItemType Directory -Force -Path ".\Export" >> $null
Get-ChildItem ".\Import" -Filter *.pal |
ForEach-Object {
    $path = ".\Export\"+$_.BaseName+".colors"
    $convertedList = Get-Content ".\template.txt" | Out-String
    $file = gc ".\Import\$_" | Select-Object -Skip 3 
    foreach($row in $file){
        $line = $row.Split(" ")
        $line[0] = [System.Math]::Round([decimal]$line[0] / 255.0, 6)
        $line[1] = [System.Math]::Round([decimal]$line[1] / 255.0, 6)
        $line[2] = [System.Math]::Round([decimal]$line[2] / 255.0, 6)
        $convertedList += "  - m_Name: `n"
        $convertedList += @("    m_Color: {r: " + $line[0]+", g: "+$line[1]+", b: "+$line[2] + ", a: 1}`n")
    }
    $convertedList | Out-File -Encoding utf8 $path
}

