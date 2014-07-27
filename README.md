docker-xpertivy-server
======================

Create a docker image to run a Xpert.Ivy server (http://xpertivy.ch).

Usage
-----

To build the docker image, execute the following command in the root folder: 

	docker build -t dgauch/xpertivy-server .

But usually you will not create the image yourself as it will automatically generated and made available at https://registry.hub.docker.com/u/dgauch/xpertivy-server .

Usage of the docker image
-------------------------

To run the Xpert.Ivy server in demo mode, just fire this command:

	docker run -it --rm -p 8081:8081 dgauch/xpertivy-server
	
This will run the container showing the console and finally remove the container (`--rm`) after you stop it with `Ctrl-c`. After startup finished, access the server page at `http://{dockerhost}:8081/ivy`. On a Linux host, that's usually http://127.0.0.1:8081/ivy. Under Mac OS, you usually end up with http://192.168.59.103:8081/ivy.

If you want to run the service in non-demo mode, you have to provide a postgres database as well as a valid license. To run a suitable postgres container, you may execute:

	docker run -d -e LC_ALL=C.UTF-8 --name xpertivy-server-db postgres

Start the Xpert.Ivy server container then with a command similar to this (please use the correct path to the license file):

	docker run -d -p 8081:8081 --link xpertivy-server-db:db -v /directory/with/lic:/opt/lic --name xpertivy-server dgauch/xpertivy-server

After startup, the server is then available under the same links as above. To access the server administration application, use username `XpertIvy` with password `XpertIvy` as in demo mode.


Have fun!
