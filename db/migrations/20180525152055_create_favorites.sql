-- +micrate Up
-- SQL in section 'Up' is executed when this migration is applied
CREATE TABLE realworld.favorites (
	user_id INT UNSIGNED NOT NULL,
	article_id INT UNSIGNED NOT NULL,
	CONSTRAINT favorites_PK PRIMARY KEY (article_id,user_id),
	CONSTRAINT favorites_articles_FK FOREIGN KEY (article_id) REFERENCES realworld.articles(id),
	CONSTRAINT favorites_users_FK FOREIGN KEY (user_id) REFERENCES realworld.users(id)
);

-- +micrate Down
-- SQL section 'Down' is executed when this migration is rolled back
DROP TABLE realworld.favorites;