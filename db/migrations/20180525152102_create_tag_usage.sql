-- +micrate Up
-- SQL in section 'Up' is executed when this migration is applied
CREATE TABLE realworld.tag_usage (
	article_id INT UNSIGNED NOT NULL,
	tag_id INT UNSIGNED NOT NULL,
	CONSTRAINT tag_usage_PK PRIMARY KEY (article_id,tag_id),
	CONSTRAINT tag_usage_articles_FK FOREIGN KEY (article_id) REFERENCES realworld.articles(id),
	CONSTRAINT tag_usage_tags_FK FOREIGN KEY (tag_id) REFERENCES realworld.tags(id)
);

-- +micrate Down
-- SQL section 'Down' is executed when this migration is rolled back
DROP TABLE realworld.tag_usage;