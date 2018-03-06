$Path = "C:\Share"
#Read-Host -Prompt 'Input your path'
$FC = "FullControl"
$GR = "BUILTIN\Administrateurs"
$GR2 = "AUTORITE NT\Système"
$OW = "AUTORITE NT\Système"
$Directory = Get-Acl -Path $Path 
ForEach ($Dir in $Directory.Access){ 
$obj = [PSCustomObject]@{ 
Path = $Path 
Owner = $Directory.Owner 
Group = $Dir.IdentityReference 
AccessType = $Dir.AccessControlType 
Rights = $Dir.FileSystemRights 
}#EndPSCustomObject
if ($obj.Rights = $FC) {
    if ($obj.Group -ne $GR) {
        if ($obj.Group -ne $GR2) {
            if ($obj.Owner -ne $OW) {
                Write-Host "Attention ! "
                Write-Host "PATH : " $obj.Path
                Write-Host "OWNER : " $obj.Owner
                Write-Host "GROUP : " $obj.Group
                Write-Host "ACCESSTYPE : " $obj.AccessType
                Write-Host "RIGHTS : " $obj.Rights
                Write-Host ""
                Write-Host ""
        }
        }
    }
}
}#EndForEach
