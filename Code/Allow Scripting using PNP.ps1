# This script connects to a SharePoint Online site, enables scripting capabilities, and prepares the client context for subsequent actions
$SiteURL = "https://youtenant.sharepoint.com/sites/yoursite"

Connect-PnPOnline -Url $SiteURL -ForceAuthentication -Interactive

Set-PnPSite -Identity $SiteURL -NoScriptSite $false

$Ctx = Get-PnPContext