<?php

// ***************************************************************************
// GoToMyAccounts Single-Signon redirector (PHP Version)
// Instructions
// Set your portal URL and your master SSO password (set in your portal settings)
// To link to a portal page, use the following sample syntax:
// http://yourdomain.com/gtma-redirect.php?target=invoices.html


// set your GoToMyAccounts portalURL (DO NOT specify http/https or trailing "/")
$portalURL = "xxxxxxx.gotomyaccounts.com";

// set master sso password from portal settings
$sso_password = "xxxxxxxxxx";

// set email of the user to auto-login
$email = "xxxxxxx@xxxxxxxx.com";

// ***************************************************************************
// Don't edit below this line unless you know what you are doing
// ***************************************************************************

// get the target page to redirect to
if (isset($_REQUEST['target']))
{
	$targetPage = $_GET["target"];        
} else {
	$targetPage = "";
}

// post URL
$sURL = "https://" . $portalURL . "/sso?ssoPW=" . $sso_password . "&email=" . $email;

$curl = curl_init();
curl_setopt($curl,CURLOPT_URL,$sURL);
curl_setopt($curl, CURLOPT_FOLLOWLOCATION, true);
curl_setopt($curl,CURLOPT_RETURNTRANSFER,true);
// SSL verifyer is disbabled. CURL doesn't seem to like some wildcard certs
curl_setopt($curl,CURLOPT_SSL_VERIFYPEER,false);

// Send the request & save response to $resp
$strResponse = curl_exec($curl);
curl_close($curl);

If ($strResponse == "" or $strResponse == "0") {
    echo "Invalid Response";
} Else {
    $sRedir = "https://" . $portalURL . "/sso?token=" . urlencode($strResponse) . "&page=" . $targetPage;
	header( 'Location: '.$sRedir);
}

?>