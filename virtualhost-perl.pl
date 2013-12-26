#!/usr/bin/perl

$dominio="DOMINIO_AQUI";
$usuario="USUARIO_AQUI";
$grupo="GRUPO_AQUI";
$password="PASSWORD_AQUI";

#Si queremos crear usuario o no
$crea_user="si";
#Si queremos crear los directorios o no
$crea_dirs="si";
#Si queremos crear la entrada en apache o no
$crea_apache="si";

#La IP de nuestro servidor
$ip="IP_AQUI";
#Ruta al directorio de nuestra web
$path_dominio = "/var/www/html";

if ($crea_user eq "si") {

print "Creando usuario y grupo para el dominio.\n";

system ("/usr/sbin/groupadd $grupo");

sleep 1;

system ("/usr/sbin/useradd -g $grupo -s /sbin/nologin -d $path_dominio/$dominio $usuario");

sleep 1;

system ("rm -f /var/mail/$usuario");

sleep 1;

open (NC, "+>/usr/custombin/$usuario") || die print "ERROR 0003";
print NC <<EOT;
$password
EOT
close NC;

sleep 1;

system ("/usr/bin/passwd --stdin $usuario < /usr/custombin/$usuario");

sleep (1);
system ("rm -f /usr/custombin/$usuario");

sleep(1);

}

sleep 1;

print "Creando entrada en hosts.\n";

open (HOSTS, ">>/etc/hosts");
print HOSTS <<EOTV;

$ip www.$dominio

EOTV
close HOSTS;

if ($crea_dirs eq "si") {

print "Creando directorios para el dominio.\n";

system "mkdir $path_dominio/$dominio/www";

sleep 1;

system "chmod 711 $path_dominio/$dominio";
system "chmod 751 $path_dominio/$dominio/www";
sleep 1;

system "chown -R $usuario:$grupo $path_dominio/$dominio";

sleep 1;

print "Creando pagina de pruebas para el dominio.\n";
open (INDEX, "+>$path_dominio/$dominio/www/index.html");

print INDEX <<EOTU;
<html>
<head>
<title>Bienvenido a nuestra Web - $dominio</title>
<body>
$dominio
</body>
</html>

EOTU

close INDEX;

system "chown $usuario:$grupo $path_dominio/$dominio/www/index.html";

system ("rm -f $path_dominio/$dominio/.bash_logout");
system ("rm -f $path_dominio/$dominio/.bash_profile");
system ("rm -f $path_dominio/$dominio/.bashrc");
system ("rm -f $path_dominio/$dominio/.gtkrc");

}

sleep 1;

if ($crea_apache eq "si") {

print "Creando apache para el dominio.\n";
open (HTTPD, ">>/etc/httpd/conf.d/vhost.conf");
print HTTPD <<EOTV;

<VirtualHost $ip:80>
ServerName www.$dominio
ServerAlias $dominio www.$dominio
DocumentRoot $path_dominio/$dominio/www
CustomLog /etc/httpd/logs/$dominio.access_log combined
ErrorLog /etc/httpd/logs/$dominio.error_log
</virtualhost>

EOTV

close HTTPD;

system "/etc/rc.d/init.d/httpd reload";

}

exit;

