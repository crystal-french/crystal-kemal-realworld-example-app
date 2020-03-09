-- +micrate Up
-- SQL in section 'Up' is executed when this migration is applied
CREATE TABLE realworld.articles (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	slug varchar(100) NOT NULL,
	title varchar(100) NOT NULL,
	body TEXT NOT NULL,
	description varchar(100) NOT NULL,
	user_id INT UNSIGNED NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL ON UPDATE CURRENT_TIMESTAMP,
	CONSTRAINT articles_PK PRIMARY KEY (id),
	CONSTRAINT articles_UN UNIQUE KEY (slug),
	CONSTRAINT articles_users_FK FOREIGN KEY (user_id) REFERENCES realworld.users(id)
);

-- +micrate Down
-- SQL section 'Down' is executed when this migration is rolled back
DROP TABLE realworld.articles;