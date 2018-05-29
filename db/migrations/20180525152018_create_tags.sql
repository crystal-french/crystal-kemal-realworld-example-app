-- +micrate Up
-- SQL in section 'Up' is executed when this migration is applied
CREATE TABLE realworld.tags (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	name VARCHAR(50) NOT NULL,
	CONSTRAINT tags_PK PRIMARY KEY (id)
);

-- +micrate Down
-- SQL section 'Down' is executed when this migration is rolled back
DROP TABLE realworld.tags;