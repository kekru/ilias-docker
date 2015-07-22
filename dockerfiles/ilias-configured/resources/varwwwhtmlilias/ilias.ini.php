; <?php exit; ?>
[server]
http_path = "inserthttppath"
absolute_path = "/var/www/html/ilias"
presetting = ""
timezone = "inserttimezone"

[clients]
path = "data"
inifile = "client.ini.php"
datadir = "/opt/iliasdata"
default = "insertdefaultclientid"
list = "0"

[setup]
pass = "insertmd5adminpassword"

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

[redhat]
data_dir = ""
log = ""
convert = ""
zip = ""
unzip = ""
java = ""
htmldoc = ""

[suse]
data_dir = ""
log = ""
convert = ""
zip = ""
unzip = ""
java = ""
htmldoc = ""

[https]
auto_https_detect_enabled = "0"
auto_https_detect_header_name = ""
auto_https_detect_header_value = ""