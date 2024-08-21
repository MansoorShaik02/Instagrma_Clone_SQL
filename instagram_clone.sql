create database Instagram_Clone;
use Instagram_Clone;

CREATE TABLE users (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  username VARCHAR(255) NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  PRIMARY KEY (id),
  UNIQUE INDEX username_UNIQUE (username ASC) VISIBLE
);

CREATE TABLE photos (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  image_url VARCHAR(255) NOT NULL,
  user_id INT UNSIGNED NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  PRIMARY KEY (id),
  INDEX user_id_photos_idx (user_id ASC) VISIBLE,
  CONSTRAINT user_id_photos
    FOREIGN KEY (user_id)
    REFERENCES users (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

CREATE TABLE comments (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  comment_text VARCHAR(255) NOT NULL,
  photo_id INT UNSIGNED NOT NULL,
  user_id INT UNSIGNED NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  PRIMARY KEY (id),
  INDEX photo_id_comments_idx (photo_id ASC) VISIBLE,
  INDEX user_id_comments_idx (user_id ASC) VISIBLE,
  CONSTRAINT photo_id_comments
    FOREIGN KEY (photo_id)
    REFERENCES photos (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT user_id_comments
    FOREIGN KEY (user_id)
    REFERENCES users (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

CREATE TABLE likes (
  user_id INT UNSIGNED NOT NULL,
  photo_id INT UNSIGNED NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  PRIMARY KEY (user_id, photo_id),
  INDEX user_id_likes_idx (user_id ASC) VISIBLE,
  INDEX photo_id_likes_idx (photo_id ASC) VISIBLE,
  CONSTRAINT user_id_likes
    FOREIGN KEY (user_id)
    REFERENCES users (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT photo_id_likes
    FOREIGN KEY (photo_id)
    REFERENCES photos (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

CREATE TABLE follows (
  follower_id INT UNSIGNED NOT NULL,
  followee_id INT UNSIGNED NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  PRIMARY KEY (follower_id, followee_id),
  INDEX follower_id_follows_idx (follower_id ASC) VISIBLE,
  INDEX followee_id_follows_idx (followee_id ASC) VISIBLE,
  CONSTRAINT follower_id_follows
    FOREIGN KEY (follower_id)
    REFERENCES users (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT followee_id_follows
    FOREIGN KEY (followee_id)
    REFERENCES users (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

CREATE TABLE tags (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  tag_name VARCHAR(255) NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  PRIMARY KEY (id),
  UNIQUE INDEX tag_name_UNIQUE (tag_name ASC) VISIBLE
);

CREATE TABLE photo_tags (
  photo_id INT UNSIGNED NOT NULL,
  tag_id INT UNSIGNED NOT NULL,
  PRIMARY KEY (photo_id, tag_id),
  INDEX photo_id_photo_tags_idx (photo_id ASC) VISIBLE,
  INDEX tag_id_photo_tags_idx (tag_id ASC) VISIBLE,
  CONSTRAINT photo_id_photo_tags
    FOREIGN KEY (photo_id)
    REFERENCES photos (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT tag_id_photo_tags
    FOREIGN KEY (tag_id)
    REFERENCES tags (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

show tables;


INSERT INTO users (username) VALUES 
('Alice'), ('Bob'), ('Charlie'), ('Diana'), ('Eve'),
('Frank'), ('Grace'), ('Hannah'), ('Ivy'), ('Jack'),
('Kevin'), ('Laura'), ('Mike'), ('Nina'), ('Oscar'),
('Paul'), ('Quincy'), ('Rachel'), ('Steve'), ('Tina');

INSERT INTO photos (image_url, user_id) VALUES 
('alice_photo1.jpg', 1), ('bob_photo1.jpg', 2), ('charlie_photo1.jpg', 3), 
('diana_photo1.jpg', 4), ('eve_photo1.jpg', 5), ('frank_photo1.jpg', 6), 
('grace_photo1.jpg', 7), ('hannah_photo1.jpg', 8), ('ivy_photo1.jpg', 9), 
('jack_photo1.jpg', 10), ('kevin_photo1.jpg', 11), ('laura_photo1.jpg', 12), 
('mike_photo1.jpg', 13), ('nina_photo1.jpg', 14), ('oscar_photo1.jpg', 15), 
('paul_photo1.jpg', 16), ('quincy_photo1.jpg', 17), ('rachel_photo1.jpg', 18), 
('steve_photo1.jpg', 19), ('tina_photo1.jpg', 20);

INSERT INTO comments (comment_text, photo_id, user_id) VALUES 
('Great photo, Alice!', 1, 2), ('Amazing shot, Bob!', 2, 3), ('Nice click, Charlie!', 3, 4),
('Lovely picture, Diana!', 4, 5), ('So cool, Eve!', 5, 6), ('Wonderful, Frank!', 6, 7),
('Awesome, Grace!', 7, 8), ('Nice shot, Hannah!', 8, 9), ('Beautiful, Ivy!', 9, 10),
('Excellent, Jack!', 10, 11), ('Stunning, Kevin!', 11, 12), ('Fantastic, Laura!', 12, 13),
('Wow, Mike!', 13, 14), ('Nice one, Nina!', 14, 15), ('Superb, Oscar!', 15, 16),
('Incredible, Paul!', 16, 17), ('Brilliant, Quincy!', 17, 18), ('Amazing work, Rachel!', 18, 19),
('So creative, Steve!', 19, 20), ('Cool picture, Tina!', 20, 1);

INSERT INTO likes (user_id, photo_id) VALUES 
(1, 2), (2, 3), (3, 4), (4, 5), (5, 6), 
(6, 7), (7, 8), (8, 9), (9, 10), (10, 11), 
(11, 12), (12, 13), (13, 14), (14, 15), (15, 16), 
(16, 17), (17, 18), (18, 19), (19, 20), (20, 1);

INSERT INTO follows (follower_id, followee_id) VALUES 
(1, 2), (2, 3), (3, 4), (4, 5), (5, 6),
(6, 7), (7, 8), (8, 9), (9, 10), (10, 11), 
(11, 12), (12, 13), (13, 14), (14, 15), (15, 16),
(16, 17), (17, 18), (18, 19), (19, 20), (20, 1);

INSERT INTO tags (tag_name) VALUES 
('nature'), ('city'), ('people'), ('travel'), ('food'),
('sports'), ('animals'), ('art'), ('technology'), ('music'),
('fashion'), ('architecture'), ('landscape'), ('portrait'), ('abstract'),
('macro'), ('blackandwhite'), ('vintage'), ('aesthetic'), ('minimal');

INSERT INTO photo_tags (photo_id, tag_id) VALUES 
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (1,2)
(6, 6), (7, 7), (8, 8), (9, 9), (10, 10), 
(11, 11), (12, 12), (13, 13), (14, 14), (15, 15), 
(16, 16), (17, 17), (18, 18), (19, 19), (20, 20);

select * from photo_tags;

