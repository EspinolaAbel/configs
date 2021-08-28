#!/bin/bash

cd /opt/eclipse/java

preguntar() {
	read -p "? (y): " respuesta;

	if [[ $respuesta == "y" ]];
	then return 0;
	else return 1;
	fi;
}

echo "1- Correr eclipse-installer. Hacer update dentro de la app para traer la última versión de eclipse";
preguntar && ./eclipse-installer/eclipse-inst

echo "2- Actualizar link latest/ para que apunte a la carpeta del nuevo eclipse descargado"
preguntar && {
	versionDescargada=`ls -d -1 jee-* | sort -rn | head -n1`;
	if [[ ! -h "./latest" ]];
	then
		ln --symbolic "${versionDescargada}/eclipse" latest;
	fi;
};

echo "3- lombok";
preguntar && {
	lombokOut="./latest/lombok.jar";
	wget --output-document=$lombokOut https://projectlombok.org/downloads/lombok.jar 
	java -jar $lombokOut install ./latest/
};

echo "3- eclipse.ini update"
grep --quiet '\-Dvrapper\.vrapperrc=/media/aee/data/Users/AEE/_vrapperrc' ./latest/eclipse.ini || echo '-Dvrapper.vrapperrc=/media/aee/data/Users/AEE/_vrapperrc' >> latest/eclipse.ini

echo ""; echo ""; echo ""; echo ""; echo ""; echo "";
echo "4- Abrir eclipse e importar /opt/eclipse/java/mi-config/eclipse/Preferences.epf"
echo "5- Instalar plugin VIM"
