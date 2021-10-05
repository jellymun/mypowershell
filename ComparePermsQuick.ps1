$computers=Get-ADComputer -filter * -searchbase 'OU=AppDesktop,OU=RDS,OU=Windows,OU=Servers,DC=MyDomain'

$referenceACL = Get-Acl -Path  \\Server16\C$\ProgramData

foreach ($machine in $computers){

$dapath='\\'+$machine.name+'\C$\ProgramData'
$dapath

#could of done in 1 line but allows me to troubleshoot
$TargetACL = Get-Acl -Path  $dapath 
$raclt=$referenceACL.AccessToString -replace '(LC\\)(.+)( Allow  FullControl)','$1@@@$3'|Sort
$taclt=$TargetACL.AccessToString -replace '(LC\\)(.+)( Allow  FullControl)','$1@@@$3'|Sort

Compare-Object $taclt $raclt -Verbose -IncludeEqual

} 
