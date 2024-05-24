#This script uses PNP PowerShell to update the URLs for your Content Type
#The URL must be relative. It can not be a hard coded url

$SiteURL = "https://yourtenant.sharepoint.com/sites/yoursite"
$ListName = "Your SP List Name"
$TenantId = "yourtenantid"
$AppId = "yourappid"
$ContentTypeName = "Item" # The name of your Content Type


Connect-PnPOnline -Url $SiteURL -ForceAuthentication -Interactive

$Ctx = Get-PnPContext

$ListContentType = Get-PnPContentType -List $ListName -Identity $ContentTypeName

# The url parameters are delimited with a ; (semi-colon) instead of an & (ampersand) to prevent encoding
$ListContentType.NewFormUrl = "SiteAssets/SPToApp/SPToPowerAppsLink.aspx?tenantId=" + $TenantId + ";appId=" + $AppId + ";mode=NEW"
$ListContentType.EditFormUrl = "SiteAssets/SPToApp/SPToPowerAppsLink.aspx?tenantId=" + $TenantId + ";appId=" + $AppId + ";mode=EDIT"
$ListContentType.DisplayFormUrl = "SiteAssets/SPToApp/SPToPowerAppsLink.aspx?tenantId=" + $TenantId + ";appId=" + $AppId + ";mode=DISPLAY"
$ListContentType.Update($false)
 
$Ctx.ExecuteQuery()

