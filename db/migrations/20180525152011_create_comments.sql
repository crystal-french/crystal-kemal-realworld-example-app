-- +micrate Up
-- SQL in section 'Up' is executed when this migration is applied
CREATE TABLE realworld.comments (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	body TEXT NOT NULL,
	user_id INT UNSIGNED NOT NULL,
	article_id INT UNSIGNED NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL ON UPDATE CURRENT_TIMESTAMP,
	CONSTRAINT comments_PK PRIMARY KEY (id),
	CONSTRAINT comments_articles_FK FOREIGN KEY (article_id) REFERENCES realworld.articles(id),
	CONSTRAINT comments_users_FK FOREIGN KEY (user_id) REFERENCES realworld.users(id)
);

-- +micrate Down
-- SQL section 'Down' is executed when this migration is rolled back
DROP TABLE realworld.comments;