/**********    MESSENGER DATABASE    **********/
/**********    Note: Execute theo thứ tự    **********/


/**********    0    **********/
/**********    CREATE DATABASE    **********/
DROP DATABASE IF EXISTS `MessengerAppsNameIsVeryBeautiful`;
CREATE DATABASE `MessengerAppsNameIsVeryBeautiful`;
USE `MessengerAppsNameIsVeryBeautiful`;


/**********    1    **********/
/**********    USERS TABLE    **********/
-- DROP TABLE IF EXISTS `Users`;
CREATE TABLE `Users` (
	`userID` INT UNSIGNED,
	`username` VARCHAR(30) NOT NULL UNIQUE, -- Username không trùng nhau
	`password` VARCHAR(50) NOT NULL,
    `fullName` VARCHAR(50) NOT NULL,
	`age` TINYINT UNSIGNED,
	`address` VARCHAR(100),
	`phoneNumber` VARCHAR(10),
	`email` VARCHAR(50),
	`isActive` BOOL DEFAULT FALSE,
	PRIMARY KEY (`userID`)
) ENGINE = InnoDB;


/**********    2    **********/
/**********    INSERT USERS    **********/
INSERT INTO `Users` VALUES (1, 'hacdaiphu', 'lumotdantuoitom', 'Lão Hạc', 69, 'Làng Vũ Đại', NULL, NULL, FALSE);
INSERT INTO `Users` VALUES (2, 'hachiko', 'anpateuongsting', 'Cậu Vàng', 5, 'Tokyo', NULL, NULL, FALSE);
INSERT INTO `Users` VALUES (3, 'nguoiluongthien', 'toikhongbaogiochoichatkichthich', 'Chí Phèo', 26, 'Làng Vũ Đại', NULL, NULL, FALSE);
INSERT INTO `Users` VALUES (4, 'baodentonhatvung', 'chungmaycovandevequanghoca', 'A Phủ', 33, 'Wakanda', NULL, NULL, FALSE);
INSERT INTO `Users` VALUES (5, 'sudaigia', 'thocamduckiengphapnhanitaly', 'A Sử', 34, 'Tây Bắc', NULL, NULL, FALSE);
INSERT INTO `Users` VALUES (6, 'thaygiaothu', 'toisekhongpartyvoimaynguoidau', 'Ông Giáo', 35, 'Làng Vũ Đại', NULL, NULL, FALSE);
INSERT INTO `Users` VALUES (7, 'doitruongtrang', 'vualidon', 'Nguyễn Văn Tràng', 40, 'Xóm Ngụ Cư', NULL, NULL, FALSE);


/**********    3    **********/
/**********    RELATIONSHIPS TABLE    **********/
-- DROP TABLE IF EXISTS `Relationships`;
CREATE TABLE `Relationships` (
	`user1ID` INT UNSIGNED,
	`user2ID` INT UNSIGNED,
	`relationStatus` VARCHAR(20), -- 'request', 'requestedBy', 'friend'
    `blockStatus` BOOL DEFAULT FALSE,
	PRIMARY KEY (`user1ID`, `user2ID`),
	CONSTRAINT `relationshipsForeignKey1` FOREIGN KEY (`user1ID`) REFERENCES `Users` (`userID`),
	CONSTRAINT `relationshipsForeignKey2` FOREIGN KEY (`user2ID`) REFERENCES `Users` (`userID`)
) ENGINE = InnoDB;


/**********    4    **********/
/**********    INSERT RELATIONSHIPS    **********/
INSERT INTO `Relationships` (`user1ID`, `relationStatus`, `user2ID`) VALUES (1, 'friend', 2);
INSERT INTO `Relationships` (`user1ID`, `relationStatus`, `user2ID`) VALUES (2, 'friend', 1);
INSERT INTO `Relationships` (`user1ID`, `relationStatus`, `user2ID`) VALUES (1, 'friend', 6);
INSERT INTO `Relationships` (`user1ID`, `relationStatus`, `user2ID`) VALUES (6, 'friend', 1);
INSERT INTO `Relationships` (`user1ID`, `relationStatus`, `user2ID`) VALUES (4, 'request', 7);
INSERT INTO `Relationships` (`user1ID`, `relationStatus`, `user2ID`) VALUES (7, 'requestedBy', 4);
INSERT INTO `Relationships` (`user1ID`, `blockStatus`, `user2ID`) VALUES (2, TRUE, 1)
ON DUPLICATE KEY UPDATE `blockStatus` = TRUE;
INSERT INTO `Relationships` (`user1ID`, `blockStatus`, `user2ID`) VALUES (5, TRUE, 4)
ON DUPLICATE KEY UPDATE `blockStatus` = TRUE;


/**********    5    **********/
/**********    CONVERSATIONS TABLE    **********/
-- DROP TABLE IF EXISTS `Conversations`;
CREATE TABLE `Conversations` (
	`conversationID` INT UNSIGNED AUTO_INCREMENT,
    `conversationName` VARCHAR(50) DEFAULT NULL,
	`creatorID` INT UNSIGNED,
    `numberOfMembers` TINYINT UNSIGNED DEFAULT 2,
    PRIMARY KEY (`conversationID`),
    CONSTRAINT `conversationsForeignKey1` FOREIGN KEY (`creatorID`) REFERENCES `Users` (`userID`)
) ENGINE = InnoDB;


/**********    6    **********/
/**********    CONVERSATION MEMBERS TABLE    **********/
-- DROP TABLE IF EXISTS `ConversationMembers`;
CREATE TABLE `ConversationMembers` (
    `conversationID` INT UNSIGNED,
    `memberID` INT UNSIGNED,
    PRIMARY KEY (`conversationID`, `memberID`),
    CONSTRAINT `conversationMembersForeignKey1` FOREIGN KEY (`conversationID`) REFERENCES `Conversations` (`conversationID`),
    CONSTRAINT `conversationMembersForeignKey2` FOREIGN KEY (`memberID`) REFERENCES `Users` (`userID`)
) ENGINE = InnoDB;


/**********    7    **********/
/**********    MESSAGES TABLE    **********/
-- DROP TABLE IF EXISTS `Messages`;
CREATE TABLE `Messages` (
	`messageID` INT UNSIGNED AUTO_INCREMENT,
    `messageType` VARCHAR(10) DEFAULT 'text',
    `conversationID` INT UNSIGNED,
    `senderID` INT UNSIGNED,
    `messageContent` TEXT,
    `timestamp` DATETIME DEFAULT CURRENT_TIMESTAMP(),
    `messageStatus` VARCHAR(20) DEFAULT 'sending', -- 'sending', 'sent', 'seen', 'failed'
    PRIMARY KEY (`messageID`),
    CONSTRAINT `messagesForeignKey1` FOREIGN KEY (`senderID`) REFERENCES `Users` (`userID`),
    CONSTRAINT `messagesForeignKey2` FOREIGN KEY (`conversationID`) REFERENCES `Conversations` (`conversationID`)
) ENGINE = InnoDB;


/**********    8    **********/
/**********    INSERT CONVERSATIONS AND MESSAGES    **********/
/* Lão Hạc và Cậu Vàng chat riêng */
INSERT INTO `Conversations` (`creatorID`) VALUES (1);
INSERT INTO `ConversationMembers` VALUES (1, 1);
INSERT INTO `ConversationMembers` VALUES (1, 2);
INSERT INTO `Messages` (`conversationID`, `senderID`, `messageContent`) VALUES (1, 1, 'Đi Trần Duy Hưng không cậu?');
INSERT INTO `Messages` (`conversationID`, `senderID`, `messageContent`) VALUES (1, 2, 'Có chó cái thì đi.');

/* Lão Hạc và Ông Giáo chat riêng */
INSERT INTO `Conversations` (`creatorID`) VALUES (1);
INSERT INTO `ConversationMembers` VALUES (2, 1);
INSERT INTO `ConversationMembers` VALUES (2, 6);
INSERT INTO `Messages` (`conversationID`, `senderID`, `messageContent`) VALUES (2, 1, 'Cậu Vàng đi đời rồi Ông Giáo ạ. 5000 đô.');
INSERT INTO `Messages` (`conversationID`, `senderID`, `messageContent`) VALUES (2, 1, 'Tầm này mấy Lý trưởng, lũ mọt dân tuổi gì mà cà khịa tôi nữa.');
INSERT INTO `Messages` (`conversationID`, `senderID`, `messageContent`) VALUES (2, 6, 'Bọn nó bướng thế nào được cụ.');

/* Team Vũ Đại chat nhóm */
INSERT INTO `Conversations` (`conversationName`, `creatorID`, `numberOfMembers`) VALUES ("Team Vũ Đại", 1, 4);
INSERT INTO `ConversationMembers` VALUES (3, 1);
INSERT INTO `ConversationMembers` VALUES (3, 2);
INSERT INTO `ConversationMembers` VALUES (3, 3);
INSERT INTO `ConversationMembers` VALUES (3, 6);
INSERT INTO `Messages` (`conversationID`, `senderID`, `messageContent`) VALUES (3, 1, 'Tôi thành đại gia rồi mấy thím ạ.');
INSERT INTO `Messages` (`conversationID`, `senderID`, `messageContent`) VALUES (3, 3, 'Cụ đầu tư cho tôi con đề.');
INSERT INTO `Messages` (`conversationID`, `senderID`, `messageContent`) VALUES (3, 6, 'Tôi phải đi Nepal rồi cụ ạ.');
INSERT INTO `Messages` (`conversationID`, `senderID`, `messageContent`) VALUES (3, 2, 'Bán bố để làm giàu thì có gì hay? Có ngon thì cho bố ăn Pa-tê uống Sờ-ting xem nào.');

/* Cậu Vàng, Chí Phèo và A Sử chat nhóm */
INSERT INTO `Conversations` (`conversationName`, `creatorID`, `numberOfMembers`) VALUES ("Iron IV", 2, 3);
INSERT INTO `ConversationMembers` VALUES (4, 2);
INSERT INTO `ConversationMembers` VALUES (4, 3);
INSERT INTO `ConversationMembers` VALUES (4, 5);
INSERT INTO `Messages` (`conversationID`, `senderID`, `messageContent`) VALUES (4, 2, 'Chào mừng các thím đếm với đội phản diện.');
INSERT INTO `Messages` (`conversationID`, `senderID`, `messageContent`) VALUES (4, 3, 'Tôi không phải nhân vật phản diện, tôi muốn làm người lương thiện.');
INSERT INTO `Messages` (`conversationID`, `senderID`, `messageContent`) VALUES (4, 5, 'Đố đứa nào giàu bằng nhà tao.');

/* Chí Phèo, A Phủ, A Sử và Tràng chat nhóm */
INSERT INTO `Conversations` (`conversationName`, `creatorID`, `numberOfMembers`) VALUES ("Men of Culture", 3, 4);
INSERT INTO `ConversationMembers` VALUES (5, 3);
INSERT INTO `ConversationMembers` VALUES (5, 4);
INSERT INTO `ConversationMembers` VALUES (5, 5);
INSERT INTO `ConversationMembers` VALUES (5, 7);

INSERT INTO `Messages` (`conversationID`, `senderID`, `messageContent`) VALUES (5, 4, 'Anh Tràng chỉ em cách cưa gái đi anh.');
INSERT INTO `Messages` (`conversationID`, `senderID`, `messageContent`) VALUES (5, 7, 'Cứ cướp vợ thằng nào đó là được.');
INSERT INTO `Messages` (`conversationID`, `senderID`, `messageContent`, `messageStatus`) VALUES (5, 5, 'Cái đệt.', 'failed');


/*test case 17*/
create table temp (select distinct a.memberid as id  from `ConversationMembers` a, `Conversations` b
where a.conversationID = b.conversationID
and conversationName = 'Men of Culture');

create table temp2 (select distinct c.senderid as id, messageContent from `ConversationMembers` a, `Conversations` b, `Messages` c
where a.conversationID = b.conversationID
and b.conversationID = c.conversationID
and conversationName = 'Men of Culture');

select a.id, b.messageContent from temp a left join temp2 b
on a.id=b.id
where messageContent is null;

drop table temp2;

/*test case 18*/
select * from conversations a
where numberOfMembers > 3;

/*test case 19*/

create table temp (Select user2id id, fullname, relationStatus from relationships a, users b
where a.user2id = b.userid
and relationStatus = 'friend'
and user1id = 1);

/*test case 20*/
/*lấy test case 19 lam temp*/
create table temp2 (select memberid as id, fullname from conversations a, users b, conversationmembers c
where a.conversationID = c.conversationID
and b.userid = c.memberid
and conversationName = 'Team Vũ Đại'
and memberid != 1);

select a.id, a.fullname, relationStatus from temp2 a left join temp b
on b.id=a.id
where relationStatus is null or relationStatus ('request', 'requestedBy');
drop table temp2;

/*test case 21*/
select conversationName from conversations

