/*          HEART TO HEART          */


/*          CREATE DATABASE          */
DROP DATABASE IF EXISTS `MessengerAppsNameIsVeryBeautiful`;
CREATE DATABASE `MessengerAppsNameIsVeryBeautiful`;
USE `MessengerAppsNameIsVeryBeautiful`;


/*          USER TABLE          */
DROP TABLE IF EXISTS `Users`;
CREATE TABLE `Users` (
	`userID` INT UNSIGNED AUTO_INCREMENT,
    `username` VARCHAR(30) NOT NULL UNIQUE,
    `password` VARCHAR(30) NOT NULL,
    `isBlocked` BOOLEAN DEFAULT FALSE,
    `isActive` BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (`userID`)
) ENGINE = InnoDB;

/********************************INSERT TABLE*******************************/
INSERT INTO `Users` (`username`, `password`) VALUES ('username1', 'password');
INSERT INTO `Users` (`username`, `password`) VALUES ('username2', 'password');
INSERT INTO `Users` (`username`, `password`) VALUES ('username3', 'password');
INSERT INTO `Users` (`username`, `password`) VALUES ('username4', 'password');
INSERT INTO `Users` (`username`, `password`) VALUES ('username5', 'password');
INSERT INTO `Users` (`username`, `password`) VALUES ('username6', 'password');


/*          USER INFORMATION TABLE          */
DROP TABLE IF EXISTS `UserInformation`;
CREATE TABLE `UserInformation` (
	`userID` INT UNSIGNED AUTO_INCREMENT,
    `fullName` VARCHAR(50) NOT NULL,
    `age` TINYINT UNSIGNED,
    `address` VARCHAR(100),
    `phoneNumber` VARCHAR(10),
    `email` VARCHAR(50),
    PRIMARY KEY (`userID`),
	CONSTRAINT `userInformationForeignKey1` FOREIGN KEY (`userID`) REFERENCES `Users` (`userID`)
) ENGINE = InnoDB;

/********************************INSERT TABLE*******************************/
INSERT INTO `UserInformation` (`fullName`, `age`, `address`, `email`, `userID`) VALUES ('Nguyễn Văn Tràng', 40, 'Xóm Ngụ Cư', 'vualidon@gmail.com',1);
INSERT INTO `UserInformation` (`fullName`, `age`, `address`, `email`, `userID`) VALUES ('Lão Hạc', 69, 'Làng Vũ Tiểu', 'hacdaiphu@gmail.com',2);
INSERT INTO `UserInformation` (`fullName`, `age`, `address`, `email`, `userID`) VALUES ('Cậu Vàng', 5, 'Tokyo', 'hachiko@gmail.com',3);
INSERT INTO `UserInformation` (`fullName`, `age`, `address`, `email`, `userID`) VALUES ('Chí Phèo', 30, 'Làng Vũ Đại', 'nguoiluongthien@gmail.com',4);
INSERT INTO `UserInformation` (`fullName`, `age`, `address`, `email`, `userID`) VALUES ('Ông Giáo', 35, 'Lãng Vũ Bão', 'thaygiaothu@gmail.com',5);
INSERT INTO `UserInformation` (`fullName`, `age`, `address`, `email`, `userID`) VALUES ('A Phủ', 33, 'Wakanda', 'baodentonhatvung@gmail.com',6);

SELECT u.`userID` 'ID', u.`username` 'Username', `password` 'Password', `fullName` 'Full Name', `age` 'Age', `address` 'Address', `email` 'Email'
FROM `Users` u
INNER JOIN `UserInformation` ui
WHERE u.`userID` = ui.`userID`;


/*          GROUP TABLE          */
DROP TABLE IF EXISTS `Group`;
CREATE TABLE `Group` (
	`groupID` INT UNSIGNED AUTO_INCREMENT,
    `groupName` VARCHAR(50),
    PRIMARY KEY (`groupID`)
) ENGINE = InnoDB;
/*Thay đổi giá trị bắt đầu tăng*/
ALTER TABLE groupChat AUTO_INCREMENT = 2000000001;

/********************************INSERT TABLE*******************************/
INSERT INTO `Group` (`groupName`) VALUES ("Men of Culture");
INSERT INTO `Group` (`groupName`) VALUES ("Bronze Noobs");
INSERT INTO `Group` (`groupName`) VALUES ("Filthy Casuls");


/*          MEMBERS TABLE          */
DROP TABLE IF EXISTS `Members`;
CREATE TABLE `Members` (
    `groupID` INT UNSIGNED,
    `userID` INT UNSIGNED,
    PRIMARY KEY (`groupID`, `userID`),
    CONSTRAINT `membersForeignKey1` FOREIGN KEY (`groupID`) REFERENCES `Group` (`groupID`),
    CONSTRAINT `membersForeignKey2` FOREIGN KEY (`userID`) REFERENCES `Users` (`userID`)
) ENGINE = InnoDB;

INSERT INTO `Members` VALUES (2000000001, 1);
INSERT INTO `Members` VALUES (2000000001, 2);
INSERT INTO `Members` VALUES (2000000001, 3);
INSERT INTO `Members` VALUES (2000000002, 2);
INSERT INTO `Members` VALUES (2000000002, 3);
INSERT INTO `Members` VALUES (2000000002, 4);
INSERT INTO `Members` VALUES (2000000003, 3);
INSERT INTO `Members` VALUES (2000000003, 4);
INSERT INTO `Members` VALUES (2000000003, 1);


/*          MESSAGES TABLE          */
DROP TABLE IF EXISTS `Messages`;
CREATE TABLE `Messages` (
	`messageID` INT UNSIGNED AUTO_INCREMENT,
    `messageType` varchar(30),
    `messageContent` TEXT,
    PRIMARY KEY (idtn)
) ENGINE = InnoDB;

INSERT INTO `Messages` (`messageContent`) VALUES ('I, Giorno Giovanna, have a dream.');
INSERT INTO `Messages` (`messageContent`) VALUES ('I yearn for true gender equality.');
INSERT INTO `Messages` (`messageContent`) VALUES ('Ah, I see you are a man of culture as well.');
INSERT INTO `Messages` (`messageContent`) VALUES ('It\'s over 9000!');
INSERT INTO `Messages` (`messageContent`) VALUES ('This is not even my final form.');
INSERT INTO `Messages` (`messageContent`) VALUES ('Well, what is it?');
INSERT INTO `Messages` (`messageContent`) VALUES ('It\'s over, Anakin. I have the high ground.');
INSERT INTO `Messages` (`messageContent`) VALUES ('You underestimate my power.');
INSERT INTO `Messages` (`messageContent`) VALUES ('RIP in Spaghetti, never forgetti.');



/*          MESSAGE DETAILS TABLE          */
DROP TABLE IF EXISTS `MessageDetails`;
CREATE TABLE `MessageDetails` (
	`messageID` INT UNSIGNED AUTO_INCREMENT,
    `senderID` INT UNSIGNED,
    `receiverID` INT UNSIGNED,
    `groupID` INT UNSIGNED,
    `timeStamp` DATETIME DEFAULT CURRENT_TIMESTAMP(),
    `messageStatus` VARCHAR(20) DEFAULT 'Failed',
    PRIMARY KEY (`messageID`),
    CONSTRAINT `messageDetailsForeignKey1` FOREIGN KEY (`messageID`) REFERENCES `Messages` (`messageID`),
    CONSTRAINT `messageDetailsForeignKey2` FOREIGN KEY (`senderID`) REFERENCES `Users` (`userID`),
    CONSTRAINT `messageDetailsForeignKey3` FOREIGN KEY (`receiverID`) REFERENCES `Users` (`userID`),
    CONSTRAINT `messageDetailsForeignKey4` FOREIGN KEY (`groupID`) REFERENCES `Group` (`groupID`)
) ENGINE = InnoDB;

INSERT INTO `MessageDetails` (`senderID`, `receiverID`, `groupID`) VALUES (1, NULL, 2000000001);
INSERT INTO `MessageDetails` (`senderID`, `receiverID`, `groupID`) VALUES (2, NULL, 2000000001);
INSERT INTO `MessageDetails` (`senderID`, `receiverID`, `groupID`) VALUES (3, NULL, 2000000001);
INSERT INTO `MessageDetails` (`senderID`, `receiverID`, `groupID`) VALUES (2, NULL, 2000000002);
INSERT INTO `MessageDetails` (`senderID`, `receiverID`, `groupID`) VALUES (3, NULL, 2000000002);
INSERT INTO `MessageDetails` (`senderID`, `receiverID`, `groupID`) VALUES (4, NULL, 2000000002);
INSERT INTO `MessageDetails` (`senderID`, `receiverID`, `groupID`) VALUES (3, NULL, 2000000003);
INSERT INTO `MessageDetails` (`senderID`, `receiverID`, `groupID`) VALUES (4, NULL, 2000000003);
INSERT INTO `MessageDetails` (`senderID`, `receiverID`, `groupID`) VALUES (1, NULL, 2000000003);


/*          BLOCK DETAILS TABLE          */
DROP TABLE IF EXISTS `BlockDetails`;
CREATE TABLE `BlockDetails` (
	`blockerID` INT UNSIGNED,
    `blockedID` INT UNSIGNED,
    `timeStamp` DATETIME DEFAULT CURRENT_TIMESTAMP(),
    PRIMARY KEY (`blockerID`, `blockedID`)
) ENGINE = InnoDB;

INSERT INTO `BlockDetails` (`blockerID`, `blockedID`) VALUES (2, 3);