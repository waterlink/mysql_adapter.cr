#!/usr/bin/env bash

PARAMS="-u ${MYSQL_USER:-root}"
[[ -z "$MYSQL_PASS" ]] || PARAMS="$PARAMS -P '${MYSQL_PASS}'"
[[ -z "$MYSQL_ASK_PASS" ]] || PARAMS="$PARAMS -p"

mysql $PARAMS -e "create database crystal_mysql_test"
mysql $PARAMS -e "create user 'crystal_mysql'@'localhost'"
mysql $PARAMS -e "grant all on crystal_mysql_test.* to 'crystal_mysql'@'localhost'"

mysql $PARAMS -e "use crystal_mysql_test; create table people( id int not null auto_increment primary key, last_name varchar(50), first_name varchar(50), number_of_dependents int )"

mysql $PARAMS -e "use crystal_mysql_test; create table something_else( id int not null auto_increment primary key, name varchar(50) )"

mysql $PARAMS -e "use crystal_mysql_test; create table posts( id int not null auto_increment primary key, title varchar(50), content varchar(50) )"
