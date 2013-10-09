# CINC [![Build Status](https://travis-ci.org/fermuch/CINC.png?branch=master)](https://travis-ci.org/fermuch/CINC)

Conectar Igualdad Netbook Manager

## ¿Qué es?

(Un poco de historia)

Por el año 2010 o 2011 llegaron las primeras netbooks del plan Conectar Igualdad a la escuela donde concurro. Frente al caos de desorden que se armó al no tener cómo llevar un control de quién tiene máquina actualmente, a quién le falta, si la máquina está dañada, o cuántas veces ya fue «desbloqueada», decidí desarrollar CINC.

Actualmente, esta es una reescritura completa de CINC. El original estaba escrito bajo PHP, y al ser un proyecto que tenía que terminarlo pronto, su código es desastroso. En esta versión trato de mantenerlo fácil de actualizar e instalar, aparte de seguir estándares.

## ¿Cómo lo instalo?

Esta guía asume que estás usando una distribución basada en linux, de preferencia Debian o derivados.

Primero que nada es necesario instalar Ruby, en su versión 1.9.3 o superior. Para esto, se va a usar RVM.

```bash
$ sudo apt-get install build-essential bison openssl libreadline5 libreadline-dev curl git-core zlib1g zlib1g-dev libssl-dev vim libsqlite3-0 libsqlite3-dev sqlite3 libreadline-dev libxml2-dev git-core subversion autoconf
$ bash -s stable < <(curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer)
$ echo '[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"' >> ~/.bashrc
$ source ~/.bashrc
$ rvm install ruby-1.9.3-p448
```

Eso instalará todas las dependencias necesarias.

Ahora, hay que clonar el proyecto e instalarlo. Esto puede tomar apróx. 5 min o más.

```bash
$ git clone git@github.com:fermuch/CINC.git
$ cd CINC
# aparecerá una adveretencia de RVM, escribir «y» y darle enter.
$ bundle install
$ rake db:migrate
$ rake assets:precompile:all
```

Y finalmente, para iniciar el servidor:

```bash
$ RAILS_ENV=production rails server
```
Y entrar a http://localhost:3000


### NOTA
Para poder acelerar el proceso de instalación en servidores, se están creando paquetes .deb para su distribución.

## ¿Cómo actualizar?

Actualizar es un proceso bastante fácil. Sólo hace falta introducir estos comandos:

```bash
$ git pull
$ rake db:migrate
$ rake assets:precompile:all
```

Y ya se tiene la versión actualizada.
