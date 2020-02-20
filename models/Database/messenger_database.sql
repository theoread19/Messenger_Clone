/*********************************MYSQL DATABASE WEB MESSAGE*********************************/

/*********************************CREATE DATABASE*********************************/
CREATE DATABASE MESSENGER;
USE MESSENGER;

/********************************* CREATE USER AND PERMISSION *********************************/
create user 'user1'@'localhost' identified by 'user1';
GRANT ALL privileges ON MESSENGER TO 'USER1'@'LOCALHOST';
/*ERROR*/

/*********************************TABLE NGUOIDUNG *********************************/
CREATE TABLE NGUOIDUNG(
	idnd varchar(20) PRIMARY KEY,
    tknd varchar(20) NOT NULL,
    mknd varchar(30) NOT NULL,
    hoten varchar(50),
    isactive bool DEFAULT 'FLASE',
    isclock bool  DEFAULT 'FLASE'
) ENGINE=InnoDB;

/*********************************TABLE TTNGUOIDUNG*********************************/
CREATE TABLE TTNGUOIDUNG(
	idnd varchar(20),
    tuoi int,
    diachi varchar(100),
    sodt int,
    email varchar(50),
	FOREIGN KEY (IDND) REFERENCES NGUOIDUNG(IDND)
) ENGINE=InnoDB;

/*********************************TABLE TIN NHAN *********************************/
CREATE TABLE TINNHAN(
	idtn int,
    noidung varchar(500)
) ENGINE=InnoDB;

/*********************************TABLE NHOMCHAT*********************************/
CREATE TABLE NHOMCHAT(
	idnc varchar(20),
    sl int,
    thoigiantao datetime
) ENGINE=InnoDB;

/*********************************TABLE CHITIET*********************************/
CREATE TABLE CHITIET(
	ID varchar(20),
    thoigiangui datetime,
    trangthai varchar(20),
    IDTN int,
    nguoinhan varchar(20),
    nguoigui varchar(20),
    FOREIGN KEY (IDTN) REFERENCES TINNHAN(ID),
    FOREIGN KEY (nguoinhan) REFERENCES NguoiDung(IDND),
    FOREIGN KEY (nguoigui) REFERENCES NguoiDung(IDND)
) ENGINE=InnoDB

