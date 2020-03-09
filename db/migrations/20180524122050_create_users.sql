-- +micrate Up
-- SQL in section 'Up' is executed when this migration is applied
CREATE TABLE realworld.users (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	username varchar(100) NOT NULL,
	hash VARCHAR(60) NOT NULL,
	email varchar(100) NOT NULL,
	bio TEXT NULL,
	image varchar(255) NULL,
	CONSTRAINT users_PK PRIMARY KEY (id),
	CONSTRAINT users_UN1 UNIQUE KEY (username),
	CONSTRAINT users_UN2 UNIQUE KEY (email)
);

-- +micrate Down
-- SQL section 'Down' is executed when this migration is rolled back
DROP TABLE realworld.users;