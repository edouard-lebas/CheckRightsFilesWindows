
#This script finds basic flaws in file permissions

$Path = Read-Host -Prompt 'Input your path'
$FC = "FullControl"
$TLM = "Tout le monde"
$OW = "AUTORITE NT\Système"
$c = 0

$Directory = Get-Acl -Path $Path 
ForEach ($Dir in $Directory.Access){ 
    $obj = [PSCustomObject]@{ 
        Path = $Path 
        Owner = $Directory.Owner 
        Group = $Dir.IdentityReference 
        AccessType = $Dir.AccessControlType 
        Rights = $Dir.FileSystemRights
    }    
    if ($obj.Group -eq $TLM){
        if ($obj.Rights -eq $FC){
            if ($obj.Owner -ne $OW) {
                Write-Host ""
                Write-Host ""
                Write-Host $c -NoNewline -ForegroundColor Green
                Write-Host " : Attention ! " -ForegroundColor Green
                Write-Host "PATH : " $obj.Path
                Write-Host "OWNER : " $obj.Owner
                Write-Host "GROUP : " $obj.Group -ForegroundColor DarkRed
                Write-Host "ACCESSTYPE : " $obj.AccessType
                Write-Host "RIGHTS : " $obj.Rights -ForegroundColor DarkRed
                Write-Host ""
                Write-Host ""
            }
        }
    }
    $c = $c +1
}
