CREATE DATABASE web2012 DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;

GRANT ALL ON web2012.* TO 'web'@'localhost' IDENTIFIED BY 'asdf';

use web2012;


CREATE TABLE users (
	id INT AUTO_INCREMENT PRIMARY KEY, 
	userid VARCHAR(100) NOT NULL UNIQUE,
	name VARCHAR(100),
	pwd VARCHAR(255) NOT NULL, 
	email VARCHAR(100) UNIQUE,
	country VARCHAR(100),
	gender CHAR(1) NOT NULL,
	favorites VARCHAR(255),
	per int
);

INSERT INTO users VALUES (1, 'admin', 'administrator', 'asdf', 'wow_mamond@naver.com', 'KOREA','M', null, 1);
INSERT INTO users VALUES (2, 'JS', 'Jisung', 'asdf', 'nolbu1009@gmail.com', 'USA','M', null, null);

create table list1(
	id int auto_increment primary key,
	lec_name varchar(100) not null,
	lec_url varchar(300) not null
);

insert into list1 values(1, 'Test Lecture', 'hello.co.kr')