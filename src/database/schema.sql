CREATE DATABASE rede_social;
\c rede_social;

-- Usuários
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL,
    profile_picture TEXT
);

-- Seguidores
CREATE TABLE followers (
    id SERIAL PRIMARY KEY,
    follower_id INT REFERENCES users(id) ON DELETE CASCADE,
    following_id INT REFERENCES users(id) ON DELETE CASCADE,
    UNIQUE(follower_id, following_id)
);

-- Posts
CREATE TABLE posts (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id) ON DELETE CASCADE,
    title VARCHAR(100),
    caption TEXT,
    media_url TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Curtidas
CREATE TABLE likes (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id) ON DELETE CASCADE,
    post_id INT REFERENCES posts(id) ON DELETE CASCADE,
    UNIQUE(user_id, post_id)
);

-- Comentários
CREATE TABLE comments (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id) ON DELETE CASCADE,
    post_id INT REFERENCES posts(id) ON DELETE CASCADE,
    content TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Notícias 
CREATE TABLE news (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    description TEXT,
    link TEXT NOT NULL,
    image TEXT,
    category VARCHAR(100),
    decade VARCHAR(10),
    year INTEGER, 
    views INTEGER DEFAULT 0,
    is_featured BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Podcasts 
CREATE TABLE podcasts (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    description TEXT,
    link TEXT NOT NULL,
    image TEXT,
    category VARCHAR(100),
    views INTEGER DEFAULT 0,
    is_featured BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Vídeos 
CREATE TABLE videos (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    description TEXT,
    link TEXT NOT NULL,
    image TEXT,
    category VARCHAR(100),
    views INTEGER DEFAULT 0,
    is_featured BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- exemplos de inserts para popular as tabelas

INSERT INTO users (username, name, profile_picture) VALUES
('ana_silva', 'Ana Silva', 'https://example.com/ana.jpg'),
('joao_martins', 'João Martins', 'https://example.com/joao.jpg'),
('carla_oliveira', 'Carla Oliveira', 'https://example.com/carla.jpg'),
('lucas_ferreira', 'Lucas Ferreira', 'https://example.com/lucas.jpg');

INSERT INTO followers (follower_id, following_id) VALUES
(1, 2),
(1, 3),
(2, 1),
(3, 1),
(4, 2);

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


INSERT INTO news (title, description, link, image, category, decade, year, is_featured)
VALUES 
  ('Tecnologia Revoluciona a Medicina', 'Novas tecnologias estão transformando os diagnósticos médicos.', 'https://exemplo.com/medicina-tecnologia', 'https://exemplo.com/imagem1.jpg', 'tecnologia', '20', 2020, TRUE),
  ('Clima Global em Alerta', 'Pesquisadores alertam sobre mudanças climáticas cada vez mais intensas.', 'https://exemplo.com/clima-alerta', 'https://exemplo.com/imagem2.jpg', 'meio-ambiente', '10', 2010, FALSE),
  ('Educação Digital Ganha Espaço', 'Escolas adotam ferramentas online para ensino remoto.', 'https://exemplo.com/educacao-digital', 'https://exemplo.com/imagem3.jpg', 'educação', '20', 2021, TRUE),
  ('Avanços na Energia Renovável', 'Painéis solares e eólicos têm crescimento recorde no país.', 'https://exemplo.com/energia-renovavel', 'https://exemplo.com/imagem4.jpg', 'energia', '10', 2019, FALSE);


INSERT INTO podcasts (title, description, link, image, category, is_featured)
VALUES 
('O Caso Evandro', 'Podcast investigativo sobre o desaparecimento de um garoto nos anos 90', 'https://exemplo.com/casoevandro', 'https://img.com/evandro.jpg', 'famoso', TRUE),
('Caso Daniel Alves', 'Podcast analisa as acusações contra o jogador em 2023', 'https://exemplo.com/danielalves', 'https://img.com/daniel.jpg', 'recente', TRUE),
('Boate Kiss', 'Tragédia com mais de 240 mortos em Santa Maria-RS', 'https://exemplo.com/kiss', 'https://img.com/kiss.jpg', 'impactante', FALSE),
('Investigação da Máfia da Merenda', 'Esquemas de corrupção em contratos públicos', 'https://exemplo.com/mafia', 'https://img.com/mafia.jpg', 'investigacao', FALSE),
('Pacote Anticrime', 'Podcast explicando os impactos da nova legislação criminal', 'https://exemplo.com/anticrime', 'https://img.com/anticrime.jpg', 'leis', FALSE);

INSERT INTO videos (title, description, link, image, category, is_featured)
VALUES 
('Caso Richthofen', 'Entrevistas e reconstituições do assassinato dos pais', 'https://youtube.com/richthofen', 'https://img.com/richthofen.jpg', 'famoso', TRUE),
('Caso Lázaro Barbosa', 'Cobertura completa da caçada policial de 2021', 'https://youtube.com/lazaro', 'https://img.com/lazaro.jpg', 'recente', TRUE),
('Crime da Chacina de Unaí', 'Crime político com repercussão nacional', 'https://youtube.com/unai', 'https://img.com/unai.jpg', 'impactante', FALSE),
('Os Infiltrados', 'Documentário sobre operações da PF contra corrupção', 'https://youtube.com/infiltrados', 'https://img.com/infiltrados.jpg', 'investigacao', FALSE),
('Entendendo a Lei Maria da Penha', 'Explicação visual e casos práticos', 'https://youtube.com/mariadapenha', 'https://img.com/penha.jpg', 'leis', FALSE);

-- Tabela principal com informações da página "Sobre Nós"
CREATE TABLE about_page (
    id SERIAL PRIMARY KEY,
    main_title TEXT NOT NULL,
    subtitle TEXT,
    description TEXT,
    commitment_title TEXT,
    commitment_text TEXT,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()  
);

-- Tabela de integrantes da equipe
CREATE TABLE team_members (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    role VARCHAR(255) NOT NULL,
    photo_url TEXT,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW() ON UPDATE NOW(),  
    about_page_id INTEGER REFERENCES about_page(id) ON DELETE CASCADE
);


INSERT INTO about_page (main_title, subtitle, description, commitment_title, commitment_text)
VALUES (
    'Sobre Nós',
    'Conheça nossa equipe e propósito',
    'Somos uma equipe dedicada a preservar e divulgar a memória histórica de décadas passadas por meio de notícias, vídeos e podcasts.',
    'Nosso Compromisso',
    'Garantir informação de qualidade, curadoria histórica e acesso livre ao conhecimento.'
);

INSERT INTO team_members (name, role, photo_url, about_page_id)
VALUES 
    ('João Silva', 'Editor-Chefe', 'https://exemplo.com/fotos/joao.jpg', 1),
    ('Maria Oliveira', 'Produtora de Conteúdo', 'https://exemplo.com/fotos/maria.jpg', 1),
    ('Carlos Mendes', 'Designer Gráfico', 'https://exemplo.com/fotos/carlos.jpg', 1);
