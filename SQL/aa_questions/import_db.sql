PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  author_id INTEGER NOT NULL,

  FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  follower_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (follower_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  parent_reply_id INTEGER,
  author_id INTEGER NOT NULL,
  body TEXT NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (parent_reply_id) REFERENCES replies(id),
  FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  liker_id INTEGER NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (liker_id) REFERENCES users(id)
);

INSERT INTO 
  users (fname, lname)
VALUES
  ('Elon', 'Musk'),
  ('Bill', 'Gates'),
  ('Will', 'Smith'),
  ('Dave', 'Chappelle');

INSERT INTO 
  questions (title, body, author_id)
VALUES
  ('Space X party?', 'I am having a party. RSVP to this thread.', 1),
  ('Like my new jokes?', 'What do y''all think about my new Netflix special?', 4);


INSERT INTO
  question_follows (question_id, follower_id)
VALUES 
  (1, 1),
  (1, 2),
  (2, 4);

INSERT INTO
  replies (question_id, author_id, body)
VALUES
  (1, 2, 'I am down to earth'),
  (2, 3, 'Masterpiece, D!');

INSERT INTO
  replies (question_id, author_id, body, parent_reply_id)
VALUES
  (1, 4, 'Word', 1);

INSERT INTO
  question_likes (question_id, liker_id)
VALUES 
  (1, 3), 
  (1, 2),
  (2, 1);
