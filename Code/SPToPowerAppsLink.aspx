<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ Page Language="C#" %>
<%@ Register tagprefix="SharePoint" namespace="Microsoft.SharePoint.WebControls" assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<html dir="ltr" xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
<title>Rapid Forms - SharePoint to Power Apps Redirect</title>
<meta http-equiv="X-UA-Compatible" content="IE=10" />
<SharePoint:CssRegistration Name="default" runat="server"/>

<script type="text/javascript">

//This function is useful for extracting query parameters from the URL 
function getQueryVariable(variable, defaultValue) {
    var query = window.location.search.substring(1);
    var vars = query.split(/[;&]/); // Split by semicolon or ampersand
    for (var i = 0; i < vars.length; i++) {
        var pair = vars[i].split('=');
        if (decodeURIComponent(pair[0]) === variable) {
            return decodeURIComponent(pair[1]);
        }
    }
    return defaultValue;
    // console.log('Query variable %s not found', variable);
}

console.log(window.location);
console.log("window.location.href: " + window.location.href);

// Get the index of the substring "/siteassets/" in the current URL
var indexOfSiteAssets = window.location.href.toLowerCase().indexOf("/siteassets/");

// Initialize a default source URL based on the current origin (domain)
var defaultSource = window.location.origin;

// If "/siteassets/" is found in the URL, update the default source
if (indexOfSiteAssets !== -1) {
	defaultSource = window.location.href.slice(0, indexOfSiteAssets);
}

// Log the default source URL to the console
console.log("defaultSource: " + defaultSource);

// Get query parameters from the URL
var tenantId = getQueryVariable("tenantId",undefined);
var appId = getQueryVariable("appId",undefined);
var mode = getQueryVariable("mode","VIEW"); //NEW, EDIT, VIEW
var environment=getQueryVariable("env","DEV"); //DEV, STG, PROD

// Define the base URL for Power Apps play URL
var playUrlBase = "https://apps.powerapps.com/play/providers/Microsoft.PowerApps/apps/<appId>?tenantId=<tenantId>";

// Initialize an empty play URL
var play = "";

// Get the lowercase location path (pathname) from the URL
var locationPath = window.location.pathname.toLowerCase();
console.log("Location Path: " + locationPath);

// Get the URL-encoded value of the query parameter "Source" (fallback to defaultSource)
var urlSource = encodeURIComponent(getQueryVariable("Source", defaultSource));
// See https://learn.microsoft.com/en-us/microsoft-365/community/query-string-url-tricks-sharepoint-m365#redirect-users-navigation-from-a-list

// Get the query parameter "ID"
var id = getQueryVariable("ID",undefined);

// Verify there is both an AppId and a TenantId
if (!((typeof tenantId === 'undefined' || tenantId === null || tenantId === 'undefined') || (typeof appId === 'undefined' || appId === null || appId === 'undefined'))) 
{
    // Construct the play URL by replacing placeholders with actual values
	play = playUrlBase.replace("<appId>",appId).replace("<tenantId>",tenantId);

	// If an ID exists, open the item with specified mode and other parameters
	if (id) {
    	window.location.replace(play+"&mode="+mode+"&env="+environment+"&ID="+id+"&hidenavbar=true&source="+urlSource);
    }
    else {
        // If no ID (New Item Form), open with mode and other parameters
    	window.location.replace(play+"&mode="+mode+"&env="+environment+"&hidenavbar=true&source="+urlSource);
    }
}
else
{
    // Alert the user if TenantId and/or AppId is not set
    alert("The Power Apps TenantId and/or AppId is not set for this List or Item.");
}

</script>

</head>

<body>

<form id="form1" runat="server">

<h1>The Power Apps TenantId and/or AppId is not set for this List or Item.</h1>
<SharePoint:FormDigest ID="FormDigest1" runat="server"></SharePoint:FormDigest>
</form>

</body>

</html>





