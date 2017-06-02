<%

' ***************************************************************************
' GoToMyAccounts Single-Signon redirector (Legacy ASP Version)
' Instructions
' Set your portal URL and your master SSO password (set in your portal settings)
' To link to a portal page, use the following sample syntax:
' http://yourdomain.com/gtma-redirect.asp?target=invoices.html


' set your GoToMyAccounts portalURL (no http/https or trailing "/")
Dim portalURL
portalURL = "xxxxxxx.gotomyaccounts.com"

' set master sso password from portal settings
Dim sso_password
sso_password = "xxxxxxxxxx"

' set email of the user to auto-login
Dim email
email = "xxxxxxxx@xxxxxxxxx.com"

' ***************************************************************************
' Don't edit below this line unless you know what you are doing
' ***************************************************************************

' get the target page to redirect to
Dim targetPage
targetPage = request.QueryString("target")

Dim xml
Dim sURL
Dim postData
Dim strStatus
Dim strResponse
Dim sRedir

' post URL
sURL = "https://" & portalURL & "/sso?ssoPW=" & sso_password & "&email=" & email

' fetch the sso_token from GTMA servers
set xml = Server.CreateObject("Msxml2.ServerXMLHTTP")

'xml.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
xml.open "GET", sURL, false
xml.send
strStatus = xml.Status
strResponse = xml.responseText
' clean up the var
strResponse = replace(strResponse, chr(10), "")
strResponse = replace(strResponse, chr(13), "")
    
Set xml = nothing

if strStatus = "200" Then
    
    If strResponse = "" or strResponse = "0" Then
        Response.Write "Invalid Response"
        Response.End
    Else
        sRedir = "https://" & portalURL & "/sso?token=" & strResponse & "&page=" & targetPage
        Response.Redirect(sRedir)
    End if
Else
    Response.Write "Invalid Response: " & strStatus
    Response.End
End if

 %>