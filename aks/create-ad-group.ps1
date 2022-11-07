New-AzureADGroup -DisplayName "kubernetes-admin" -SecurityEnabled $true -Description "kubernetes admin security group"  -MailEnabled $false -MailNickName "NotSet"

Get-AzureADGroup -SearchString "kubernetes-admin"

$Group = "kubernetes-admin"
$User = "nicholas.chang@cloudtechgenius.com"
$GroupObj = Get-AzureADGroup -SearchString $Group
$UserObj = Get-AzureADUser -ObjectId $User
 
Add-AzureADGroupMember -ObjectId $GroupObj.ObjectId -RefObjectId $UserObj.ObjectId
