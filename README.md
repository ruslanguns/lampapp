# Build Dockerfile for LAMP Stack APP

## What is inside?
1. php --version
> PHP 5.5.9-1ubuntu4.25 (cli) (built: May 10 2018 14:37:18)

> Copyright (c) 1997-2014 The PHP Group

> Zend Engine v2.5.0, Copyright (c) 1998-2014 Zend Technologies

>    with Zend OPcache v7.0.3, Copyright (c) 1999-2014, by Zend Technologies

2. uname -a
> Linux 7c57bd7de1c9 4.9.87-xxxx-std-ipv6-64 #1 SMP Tue Mar 13 18:41:47 CET 2018 x86_64 x86_64 x86_64 GNU/Linux

3. mysql --version
> mysql  Ver 14.14 Distrib 5.5.41, for debian-linux-gnu (x86_64) using readline 6.3

4. apache2 -v
> Server version: Apache/2.4.7 (Ubuntu)

6. php-m
> [PHP Modules]

> bcmath

> bz2

> calendar

> Core

> ctype

> date

> dba

> dom

> ereg

> exif

> fileinfo

> filter

> ftp

> gettext

> hash

> iconv

> json

> libxml

> mbstring

> mhash

> mysql

> mysqli

> openssl

> pcntl

> pcre

> PDO

> pdo_mysql

> Phar

> posix

> readline

> Reflection

> session

> shmop

> SimpleXML

> soap

> sockets

> SPL

> standard

> sysvmsg

> sysvsem

> sysvshm

> tokenizer

> wddx

> xml

> xmlreader

> xmlwriter

> Zend OPcache

> zip

> zlib
>
> [Zend Modules]

> Zend OPcache

5. myapp for puting there all right in the the public_html
6. You can myapp.conf modify the default apache2 configuration as per your need. 

## How to use it? 

First you can just build the image 

> docker build -t myapp .

Then just run a docker container, in this example I'll show you how to modify ports with flag -p

> docker run -d -p 8089:80 -p 3309:3306 --name myapp -t myapp

Then you can go to your browser and try http://localhost:8089 and if there's "Hola Mundo" it means it works.

## How can i get bash access?

Simple do docker exec as follow:

> docker exec -u 0 -it myapp bash

# Enjoy
