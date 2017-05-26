; <?php exit; ?>
[server]
http_path = "inserthttppath"
absolute_path = "/var/www/html"
presetting = ""
timezone = "inserttimezone"

[clients]
path = "data"
inifile = "client.ini.php"
datadir = "/opt/iliasdata"
default = "insertdefaultclientid"
list = "0"

[setup]
pass = "098f6bcd4621d373cade4e832627b4f6"

[tools]
convert = "/usr/bin/convert"
zip = "/usr/bin/zip"
unzip = "/usr/bin/unzip"
java = "/usr/bin/java"
htmldoc = "/usr/bin/htmldoc"
ffmpeg = ""
ghostscript = "/usr/bin/gs"
latex = ""
vscantype = "none"
scancommand = ""
cleancommand = ""
fop = ""

[log]
path = "/opt"
file = "iliasdata"
enabled = "0"
level = "WARNING"

[debian]
data_dir = "/var/opt/ilias"
log = "/var/log/ilias/ilias.log"
convert = "/usr/bin/convert"
zip = "/usr/bin/zip"
unzip = "/usr/bin/unzip"
java = ""
htmldoc = "/usr/bin/htmldoc"
ffmpeg = "/usr/bin/ffmpeg"

[https]
auto_https_detect_enabled = "0"
auto_https_detect_header_name = ""
auto_https_detect_header_value = ""