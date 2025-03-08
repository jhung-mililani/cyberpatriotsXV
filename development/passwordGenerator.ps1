Function Get-RandomPassword
{
    #define parameters
    param([int]$PasswordLength = 15)
 
    #ASCII Character set for Password
    $CharacterSet = @{
            Uppercase   = (97..122) | Get-Random -Count 10 | ForEach-Object {[char]$_}
            Lowercase   = (65..90)  | Get-Random -Count 10 | ForEach-Object {[char]$_}
            Numeric     = (48..57)  | Get-Random -Count 10 | ForEach-Object {[char]$_}
            SpecialChar = (33..47)+(58..64)+(91..96)+(123..126) | Get-Random -Count 10 | ForEach-Object {[char]$_}
    }
 
    #Frame Random Password from given character set
    $StringSet = $CharacterSet.Uppercase + $CharacterSet.Lowercase + $CharacterSet.Numeric + $CharacterSet.SpecialChar
 
    -join(Get-Random -Count $PasswordLength -InputObject $StringSet)
}
