
-- tables
-- Table: auth
CREATE TABLE auth (
    id int NOT NULL AUTO_INCREMENT COMMENT 'id of the passwords',
    users_id int NOT NULL,
    password char(60) NOT NULL,
    tfa_key char(16) NOT NULL,
    auth_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT auth_pk PRIMARY KEY (id)
) ENGINE InnoDB COMMENT 'User passwords';

CREATE INDEX userid ON auth (users_id);

-- Table: keys
CREATE TABLE `keys` (
    id int NOT NULL AUTO_INCREMENT,
    users_id int NOT NULL,
    tfa_key blob NOT NULL,
    tfa_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE INDEX user (users_id,tfa_key),
    CONSTRAINT keys_pk PRIMARY KEY (id)
) COMMENT 'Encrypted 2FA keys';

CREATE INDEX userid ON `keys` (users_id);

-- Table: users
CREATE TABLE users (
    id int NOT NULL AUTO_INCREMENT,
    username varchar(16) NOT NULL COMMENT 'Username of users.',
    email varchar(255) NOT NULL,
    email_verified bool NOT NULL DEFAULT false,
    register_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    email_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE INDEX username (username),
    UNIQUE INDEX email (email),
    CONSTRAINT users_pk PRIMARY KEY (id)
) ENGINE InnoDB COMMENT 'User registration information';

CREATE INDEX username ON users (username);

CREATE INDEX email ON users (email);

-- foreign keys
-- Reference: users_auth (table: auth)
ALTER TABLE auth ADD CONSTRAINT users_auth FOREIGN KEY users_auth (users_id)
    REFERENCES users (id)
    ON DELETE CASCADE;

-- Reference: users_keys (table: keys)
ALTER TABLE `keys` ADD CONSTRAINT users_keys FOREIGN KEY users_keys (users_id)
    REFERENCES users (id)
    ON DELETE CASCADE;

-- End of file.
