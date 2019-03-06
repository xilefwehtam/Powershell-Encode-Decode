<#
.DESCRIPTION
    Powershell to XOR a string with a key
 
.EXAMPLE
    
 
.NOTES
    Author: Felix Mathew
    Date:   February 2019    
 
.SYNOPSIS
    .
#>
 
 #I am looking at 
$enc = [System.Text.Encoding]::UNICODE

function xor {
    param($string, $method)
    $xorkey = $enc.GetBytes("SecretKey123!")

    if ($method -eq "decrypt"){
        $string = $enc.GetString([System.Convert]::FromBase64String($string))
    }

    $byteString = $enc.GetBytes($string)
    $xordData = $(for ($i = 0; $i -lt $byteString.length; ) {
        for ($j = 0; $j -lt $xorkey.length; $j++) {
            $byteString[$i] -bxor $xorkey[$j]
            $i++
            if ($i -ge $byteString.Length) {
                $j = $xorkey.length
            }
        }
    })

    if ($method -eq "encrypt") {
        $xordData = [System.Convert]::ToBase64String($xordData)
    } else {
        $xordData = $enc.GetString($xordData)
    }
    
    return $xordData
}
#Invoking the actual function
$output = xor "text to encrypt" "encrypt"
#writing the output here
Write-Host $output