## Descripción

Script de Perl para automatizar la tarea de crear un nuevo virtual host en Apache.

## Info

Al ejecutar este script realiza las siguientes tareas:
-Crea el grupo.
-Crea el usuario.
-Crea la entrada en el fichero /etc/hosts.
-Crea los directorios para el dominio.
-Pone los permisos y propietarios correspondientes a los nuevos directorios.
-Genera una pagina indice de prueba.
-Crea la entrada virtualhost en el fichero de apache vhost.conf
-Recarga apache.

## Licencia
Copyright (c) 2013 Vicente García Dorado Licensed under the GPL license.