-- +micrate Up
-- SQL in section 'Up' is executed when this migration is applied
CREATE TABLE realworld.following (
	followed_user_id INT UNSIGNED NOT NULL,
	follower_user_id INT UNSIGNED NOT NULL,
	CONSTRAINT following_PK PRIMARY KEY (followed_user_id,follower_user_id),
	CONSTRAINT following_users1_FK FOREIGN KEY (followed_user_id) REFERENCES realworld.users(id),
	CONSTRAINT following_users2_FK FOREIGN KEY (follower_user_id) REFERENCES realworld.users(id)
);

-- +micrate Down
-- SQL section 'Down' is executed when this migration is rolled back
DROP TABLE realworld.following;