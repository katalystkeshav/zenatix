# zenatix

Ubuntu Configuration
I started with a new installation of Ubuntu Server 16.04 LTS 64bit. During installation, when prompted for which predefined collections of software to install, only “standard system utilities” and “OpenSSH server” were selected.
After a clean installation, run:
	sudo apt-get update

Install InfluxDB
The instructions below are based on the official documentation which can be found here: https://docs.influxdata.com/influxdb/v0.12/introduction/installation/
curl -sL https://repos.influxdata.com/influxdb.key | sudo apt-key add -
source /etc/lsb-release
echo "deb https://repos.influxdata.com/${DISTRIB_ID,,} ${DISTRIB_CODENAME} stable" | sudo tee /etc/apt/sources.list.d/influxdb.list

Then install InfluxDB:
	sudo apt-get update && sudo apt-get install influxdb

Start InfluxDB. This command produces no output.
	sudo service influxdb start
Connect to InfluxDB using the commandline
	influx

Create a database. For this quickstart we’ll call the database “statsdemo“. Run this command inside the InfluxDB shell.
	CREATE DATABASE statsdemo
This command produces no output, but when you list the database, you should see that it was created:
	SHOW DATABASES

Select the new created database:
	USE statsdemo

Insert some test data using the following command.
	INSERT cpu,host=serverA value=0.64

Install Grafana
The instructions below are based on the official documentation, available here: http://docs.grafana.org/installation/debian/
Due to a bug with 2.6 and Ubuntu 16.04 Server, I recommend using the beta version if you’re using Ubuntu Server in a headless configuration (No X).
For the current Stable version (2.6), use:
echo "deb https://packagecloud.io/grafana/stable/debian/ wheezy main" | sudo tee /etc/apt/sources.list.d/grafana.list
curl https://packagecloud.io/gpg.key | sudo apt-key add -

Update package repositories and install Grafana:
	sudo apt-get update && sudo apt-get install grafana

Start the grafana server:
	sudo service grafana-server start

Install Apache
For our purposes, we can get started by typing these commands:
sudo apt-get update
sudo apt-get install apache2
Config Apache Proxypass
To enable these four modules, execute the following commands in succession.
sudo a2enmod proxy
sudo a2enmod proxy_http
sudo a2enmod proxy_balancer
sudo a2enmod lbmethod_byrequests

Reverse Proxying a Single Backend Server

<VirtualHost *:80>
    ProxyPreserveHost On

    ProxyPass / http://127.0.0.1:3000/
    ProxyPassReverse / http://127.0.0.1:3000/
</VirtualHost>
