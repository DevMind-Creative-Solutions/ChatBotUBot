create database ubotdatabase;

CREATE TABLE  users(
    iduser serial primary key not null,
    username varchar(50) not null unique,
    email VARCHAR(10),
    created_at TIME default current_timestamp
)
create table sessions(
    idSession serial primary key not null,
    userId int references users(iduser) On DELETE  CASCADE,
    session_token varchar(256) UNIQUE NOT NULL,
    is_active Boolean default TRUE,
    started_at TIMESTAMP default current_timestamp,
    ended_at TIMESTAMP
)
CREATE TABLE messages (
                          idMessages SERIAL PRIMARY KEY,
                          idSession INT REFERENCES sessions(idSession) ON DELETE CASCADE,
                          sender VARCHAR(50) NOT NULL, -- 'user' ou 'bot'
                          message TEXT NOT NULL,
                          timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE botResponses (
                               idResponses SERIAL PRIMARY KEY,
                               message_id INT REFERENCES messages(idMessages) ON DELETE CASCADE,
                               intent VARCHAR(100),
                               confidence NUMERIC(5, 2), -- Exemplo: 95.75%
                               response TEXT NOT NULL
);
CREATE TABLE feedback (
                          idFeedback SERIAL PRIMARY KEY,
                          messageId INT REFERENCES messages(idMessages) ON DELETE CASCADE,
                          rating INT CHECK (rating BETWEEN 1 AND 5),
                          comment TEXT
);
