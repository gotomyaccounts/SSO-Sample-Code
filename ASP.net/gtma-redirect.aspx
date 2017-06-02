<%

    ' ***************************************************************************
    ' GoToMyAccounts Single-Signon redirector (ASP.net Version)
    ' Instructions
    ' Set your portal URL and your master SSO password (set in your portal settings)
    ' To link to a portal page, use the following sample syntax:
    ' http://yourdomain.com/gtma-redirect.aspx?target=invoices.html

    ' set your GoToMyAccounts portalURL (no http/https or trailing "/")
    Dim portalURL As String = "xxxxxx.gotomyaccounts.com"

    ' set master sso password from portal settings
    Dim sso_password As String = "xxxxxxxxx"
    
    ' set email of the user to auto-login
    Dim email As String = "xxxxxx@xxxxxxxx.com"
    
    ' ***************************************************************************
    ' Don't edit below this line unless you know what you are doing
    ' ***************************************************************************

    ' get the target page to redirect to
    Dim targetPage As String
    targetPage = Request.QueryString("target")
    
    Dim sURL As String
    Dim strResponse As String
    Dim sRedir As String

    ' post URL
    sURL = "https://" & portalURL & "/sso?ssoPW=" & sso_password & "&email=" & email
    
    ' fetch the sso_token from GTMA servers
    Dim webClient As New System.Net.WebClient
    strResponse = webClient.DownloadString(sURL)
    
    ' clean up the var
    strResponse = Replace(strResponse, Chr(10), "")
    strResponse = Replace(strResponse, Chr(13), "")
    
    webClient.Dispose()
    
    If strResponse = "" Or strResponse = "0" Then
        Response.Write("Invalid Response")
        Response.End()
    Else
        sRedir = "https://" & portalURL & "/sso?token=" & strResponse & "&page=" & targetPage
        Response.Redirect(sRedir)
    End If

 %>