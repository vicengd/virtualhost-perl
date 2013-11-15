## Descripción

Script de Perl para automatizar la tarea de crear un nuevo virtual host en Apache.

## Info

Al ejecutar este script realiza las siguientes tareas:

1. Crea el grupo.
2. Crea el usuario.
3. Crea la entrada en el fichero /etc/hosts.
4. Crea los directorios para el dominio.
5. Pone los permisos y propietarios correspondientes a los nuevos directorios.
6. Genera una pagina indice de prueba.
7. Crea la entrada virtualhost en el fichero de apache vhost.conf
8. Recarga apache.

## Licencia
Copyright (c) 2013 Vicente García Dorado Licensed under the GPL license.