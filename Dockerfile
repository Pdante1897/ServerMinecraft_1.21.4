FROM debian:11

# servidor para minecraft 1.21.4

RUN apt-get update && apt-get install -y wget gnupg

# entramos a la carpeta home

RUN cd /home

# descargar instalador de java 23 de https://download.oracle.com/java/23/latest/jdk-23_linux-x64_bin.deb

RUN wget https://download.oracle.com/java/23/latest/jdk-23_linux-x64_bin.deb

# instalamos el instalador de java con apt

RUN apt install ./jdk-23_linux-x64_bin.deb


# instalamos el servidor de minecraft
RUN mkdir /opt/minecraft
WORKDIR /opt/minecraft
RUN cd /opt/minecraft

#copiamos el archivo eula.txt
COPY ./volumen/eula.txt /opt/minecraft/eula.txt

#opiamos el archivo server.properties
COPY ./volumen/server.properties /opt/minecraft/server.properties

COPY ./volumen/ops.json /opt/minecraft/ops.json

# descargamos el servidor de minecraft
RUN wget https://piston-data.mojang.com/v1/objects/4707d00eb834b446575d89a61a11b5d548d8c001/server.jar

#exponemos el puerto 25565
EXPOSE 25565

# ejecutamos el servidor de minecraft
RUN apt-get install -y tmux

#CMD ["tmux", "new-session", "-d", "-s", "minecraft", "java", "-Xmx1024M", "-Xms1024M", "-jar", "server.jar", "nogui"]

CMD ["java", "-jar", "server.jar", "nogui"]


#ejecutamos comando docker build -t minecraft-server .
