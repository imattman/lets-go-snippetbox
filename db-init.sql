DROP DATABASE IF EXISTS snippetbox;

CREATE DATABASE snippetbox CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE snippetbox;

CREATE TABLE snippets (
  id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(100) NOT NULL,
  content TEXT NOT NULL,
  created DATETIME NOT NULL,
  expires DATETIME NOT NULL
);

CREATE INDEX idx_snippets_created ON snippets(created);

-- users table

CREATE TABLE users (
  id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  hashed_password VARCHAR(60) NOT NULL,
  created DATETIME NOT NULL
);

ALTER TABLE users ADD CONSTRAINT user_uc_email UNIQUE(email);

-- INSERT INTO users (name, email, hashed_password, created) VALUES (
--   'demo',
--   'demo@example.com',
--   '',
--   UTC_TIMESTAMP()
-- );


-- user sessions table

CREATE TABLE sessions (
  token CHAR(43) PRIMARY KEY,
  data BLOB NOT NULL,
  expiry TIMESTAMP(6) NOT NULL
);

CREATE INDEX idx_sessions_expiry on sessions(expiry);

-- application user
DROP USER IF EXISTS 'web'@'%';

CREATE USER 'web'@'%' IDENTIFIED BY 'dev';

GRANT SELECT, INSERT, UPDATE, DELETE ON snippetbox.* TO 'web'@'%';


-- initial test data
INSERT INTO snippets (title, content, created, expires) VALUES (
  'An old silent pond',
  'An old silent pond...\nA frog jumps into the pond,\nsplash! Silence again.\n\n– Matsuo Bashō',
  UTC_TIMESTAMP(),
  DATE_ADD(UTC_TIMESTAMP(), INTERVAL 365 DAY)
);

INSERT INTO snippets (title, content, created, expires) VALUES (
  'Over the wintry forest',
  'Over the wintry\nforest, winds howl in rage\nwith no leaves to blow.\n\n– Natsume Soseki',
  UTC_TIMESTAMP(),
  DATE_ADD(UTC_TIMESTAMP(), INTERVAL 365 DAY)
);

INSERT INTO snippets (title, content, created, expires) VALUES (
  'First autumn morning',
  'First autumn morning\nthe mirror I stare into\nshows my father''s face.\n\n– Murakami Kijo',
  UTC_TIMESTAMP(),
  DATE_ADD(UTC_TIMESTAMP(), INTERVAL 7 DAY)
);

INSERT INTO snippets (title, content, created, expires) VALUES (
  'one fish two fish',
  'One fish\nTwo fish\nRed fish\nBlue fish\n\n- Dr. Seuss',
  UTC_TIMESTAMP(),
  DATE_ADD(UTC_TIMESTAMP(), INTERVAL 7 DAY)
);

INSERT INTO snippets (title, content, created, expires) VALUES (
  'Rime of the Ancient Mariner',
  'Water, water every where\nand all the boards did shrink;\nWater, water every where\nnor any drop to drink.\n\n-Coleridge',
  UTC_TIMESTAMP(),
  DATE_ADD(UTC_TIMESTAMP(), INTERVAL 7 DAY)
);

