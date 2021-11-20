PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  author_id INTEGER NOT NULL,
  title TEXT NOT NULL,
  body TEXT,

  FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,

  PRIMARY KEY (question_id, user_id),

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  parent_id INTEGER,
  author_id INTEGER,
  body TEXT NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (parent_id) REFERENCES replies(id),
  FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE question_likes (
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,

  PRIMARY KEY (question_id, user_id),

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO
  users (fname, lname)
VALUES
  ("Ned", "Flanders"),
  ("Kush", "Flanders"),
  ("Earl", "Gray");

INSERT INTO
  questions (author_id, title, body)
VALUES
  (1, "Ned Q1", "NED NED NED NED"),
  (1, "Ned Q2", "NED 222 NED 222"),
  (2, "Kush Q1", "Kush Kush Kush Kush"),
  (2, "Kush Q2", "Kush 222 Kush 222"),
  (3, "Earl Q1", "EARL EARL EARL EARL");

INSERT INTO
  replies (question_id, parent_id, author_id, body)
VALUES
  (1, NULL, 1, "Clarifying statement"),
  (1, 1, 3, "You're wrong, Ned!"),
  (2, NULL, 3,"Great question!"),
  (2, NULL, 1, "Huh."),
  (3, NULL, 2, "Nope...");

INSERT INTO
  question_likes (question_id, user_id)
VALUES
  (1, 1),
  (1, 2),
  (2, 3);

INSERT INTO
  question_follows (question_id, user_id)
VALUES
  (1, 1),
  (1, 2),
  (2, 2),
  (3, 1),
  (3, 3);
