FROM debian:11

# servidor 1.21.4

RUN apt-get update && apt-get install -y wget gnupg

# entramos a la carpeta home

RUN cd /home

# descargar instalador de java 23 de https://download.oracle.com/java/23/latest/jdk-23_linux-x64_bin.deb

RUN wget https://download.oracle.com/java/23/latest/jdk-23_linux-x64_bin.deb

# instalamos el instalador de java con apt

RUN apt install ./jdk-23_linux-x64_bin.deb


# instalamos el servidor
RUN mkdir /opt/server
WORKDIR /opt/server
RUN cd /opt/server

#copiamos el archivo eula.txt
COPY ./volumen/eula.txt /opt/server/eula.txt

#opiamos el archivo server.properties
COPY ./volumen/server.properties /opt/server/server.properties

COPY ./volumen/ops.json /opt/server/ops.json

# descargamos el servidor
RUN wget https://piston-data.mojang.com/v1/objects/4707d00eb834b446575d89a61a11b5d548d8c001/server.jar

#exponemos el puerto 25565
EXPOSE 25565

# ejecutamos el servidor
RUN apt-get install -y tmux

#CMD ["tmux", "new-session", "-d", "-s", "minecraft", "java", "-Xmx1024M", "-Xms1024M", "-jar", "server.jar", "nogui"]

CMD ["java", "-jar", "server.jar", "nogui"]


#ejecutamos comando docker build -t minecraft-server .
