Check out http://shopify.github.com/dashing for more information.

![](https://github.com/derrybarry/nagios-check_mk-dashing/blob/master/dashboard%20scrn.jpg)

guide to install required items in order to run dashing on a new installation of debian 7

log on as root and add user to the sudoers files using adduser ##### sudo

eject debian install disk from machine
remove cdrom from sources list at /etc/apt/sources.list
apt-get install sudo
sudo apt-get update
check ruby version remove 1.8 if neccessary

apt-get install build-essential
apt-get install ruby1.9.1 ruby-dev
apt-get remove libruby1.8 ruby1.8 ruby1.8-dev rubygems1.8
apt-get install libcurl3 libcurl3-gnutls libcurl3-gnutls-dev libcurl-ocaml
apt-get install rubygems
apt-get install ruby-dev

########################################################################
run this as root!!
echo "deb http://ftp.us.debian.org/debian wheezy-backports main" >> /etc/apt/sources.list
apt-get update
apt-get install nodejs
########################################################################

apt-get install curl
gem install bundler
gem install execjs
gem install curb
gem install httparty -v '0.12.0'
gem install tzinfo-data
gem install dashing

##################################################################################
navigate into the relevant nagios-check_mk-dashing folder, open a terminal and run "bundle 
install" then "bundle" and finally dashing start
#####################################################################################
