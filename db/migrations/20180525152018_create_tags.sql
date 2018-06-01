-- +micrate Up
-- SQL in section 'Up' is executed when this migration is applied
CREATE TABLE realworld.tags (
	article_id INT UNSIGNED NOT NULL,
	name VARCHAR(50) NOT NULL,
	CONSTRAINT tags_articles_FK FOREIGN KEY (article_id) REFERENCES realworld.articles(id)
);

-- +micrate Down
-- SQL section 'Down' is executed when this migration is rolled back
DROP TABLE realworld.tags;