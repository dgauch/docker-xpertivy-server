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

If you want to run the service in non-demo mode, you have to provide a database for the Xpert.Ivy system database, as well as a valid license. To run a suitable postgres container, you may execute:

	docker run -d -e LC_ALL=C.UTF-8 --name xpertivy-server-db postgres

The default environment is already configured to be used with a postgres database. If you want to use a different database, please configure these environment variables correctly, e.g. by using the -e switch: 

	-e XPERTIVY_SERVER_DB_URL=jdbc:postgresql://172.17.0.46:5432/XpertIvySystemDatabase
	-e XPERTIVY_SERVER_DB_USER=postgres
	-e XPERTIVY_SERVER_DB_PASS=mypass

Start the Xpert.Ivy server container then with a command similar to this (please use the correct path to the license file):

	docker run -d -p 8081:8081 --link xpertivy-server-db:db -v /directory/with/lic:/data --name xpertivy-server dgauch/xpertivy-server

After startup, the server is then available under the same links as above. Consider folder sharing as explained in https://github.com/boot2docker/boot2docker#folder-sharing when you're using boot2docker:

	docker run -d -p 8081:8081 --link xpertivy-server-db:db --volumes-from my-data --name xpertivy-server dgauch/xpertivy-server

To access the server administration application, use username `XpertIvy` with password `XpertIvy` as in demo mode.

Have fun!

Known Limitations
-----------------
* Even though you may select "JsfWorkflowUi" to be installed when creating a new application, it will not work, as the corresponding project is missing in the official Xpert.Ivy server package.