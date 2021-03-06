#!/bin/sh

WAN_IP=$(http -b ifconfig.co)
COUNTRYCODE_ISO=$(http -b ifconfig.co/country-iso)

echo '
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p> Server WAN IP : '$WAN_IP'</p>
<p> Server COUNTRYCODE ISO: '$COUNTRYCODE_ISO'</p>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>
<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
' > /var/www/html/index.nginx-debian.html

exit