
create database web2012 default character set utf8 default collate utf8_general_ci;

grant all on web2012.* TO 'web'@'localhost' identified by 'asdf';

use web2012;


create table users (
	id int auto_increment primary key, 
	userid varchar(40) not null unique,
	name varchar(40),
	pwd varchar(15) not null, 
	email varchar(100) unique,
	phone varchar(20) not null,
	per varchar(10)
	);

insert into users values (1, 'admin', 'Administrator', 'asdf', 'wow_mamond@naver.com','010-9959-5663','1');
insert into users values (2, 'nolbu1009', 'Jisung', '60092484', 'nolbu1009@gmail.com','010-9959-5663',null);
insert into users values (3, 'sungwoo1226', 'Sungwoo', '60092439', 'sungwoo1226@naver.com','010-9959-5663', null);
insert into users values (4, 'test3', '조덕주', '111112', 'wow_mamond@naver.com','010-9959-5663', null);


create table list1(
	id int auto_increment primary key,
	lec_name varchar(100) not null,
	lec_url varhcar(300) not null
);

insert into list1 values (1, 'Web_Programming', 'mju.ac.kr');
insert into list1 values (2, 'Database', 'mju.ac.kr');
insert into list1 values (3, 'Capstone Project', 'mju.ac.kr');