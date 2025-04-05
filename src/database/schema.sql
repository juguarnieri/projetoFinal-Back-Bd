-- Criação do banco de dados
CREATE DATABASE rede_social;
\c rede_social;

-- Tabelas
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL,
    profile_picture TEXT
);

CREATE TABLE followers (
    id SERIAL PRIMARY KEY,
    follower_id INT REFERENCES users(id) ON DELETE CASCADE,
    following_id INT REFERENCES users(id) ON DELETE CASCADE,
    UNIQUE(follower_id, following_id) 
);

CREATE TABLE posts (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id) ON DELETE CASCADE,
    title VARCHAR(100),
    caption TEXT,
    media_url TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE likes (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id) ON DELETE CASCADE,
    post_id INT REFERENCES posts(id) ON DELETE CASCADE,
    UNIQUE(user_id, post_id) 
);

CREATE TABLE comments (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id) ON DELETE CASCADE,
    post_id INT REFERENCES posts(id) ON DELETE CASCADE,
    content TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- Usuários
INSERT INTO users (username, name, profile_picture) VALUES
('ana_silva', 'Ana Silva', 'https://example.com/ana.jpg'),
('joao_martins', 'João Martins', 'https://example.com/joao.jpg'),
('carla_oliveira', 'Carla Oliveira', 'https://example.com/carla.jpg'),
('lucas_ferreira', 'Lucas Ferreira', 'https://example.com/lucas.jpg');

-- Seguidores
INSERT INTO followers (follower_id, following_id) VALUES
(1, 2),
(1, 3),
(2, 1),
(3, 1),
(4, 2);

-- Posts
INSERT INTO posts (user_id, title, caption, media_url) VALUES
(1, 'Meu primeiro post!', 'Curtindo o dia na praia 🌊', 'https://example.com/foto1.jpg'),
(2, 'Trabalho novo!', 'Começando um novo desafio 🚀', 'https://example.com/foto2.jpg'),
(3, 'Look do dia', 'Pronta pra sair ✨', 'https://example.com/foto3.jpg'),
(1, 'Cachorro fofo', 'Olha esse doguinho 🐶', 'https://example.com/foto4.jpg');

INSERT INTO likes (user_id, post_id) VALUES
(2, 1),
(3, 1),
(1, 2),
(4, 3);

INSERT INTO comments (user_id, post_id, content) VALUES
(2, 1, 'Que lugar lindo!'),
(3, 1, 'Adorei essa foto!'),
(1, 2, 'Parabéns pelo novo trabalho!'),
(4, 3, 'Estilo top!'),
(3, 4, 'Fofo demais!');



