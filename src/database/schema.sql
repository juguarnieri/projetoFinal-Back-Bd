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
    updated_at TIMESTAMP DEFAULT NOW(),  
    about_page_id INTEGER REFERENCES about_page(id) ON DELETE CASCADE
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
('Caso Suzane Von Richthofen 20 anos depois - Investigação Criminal', ' o Caso Richthofen, um crime que chocou o Brasil. Ele detalha a vida de Suzane von Richthofen, sua relação com os irmãos Daniel e Cristian Cravinhos e os acontecimentos que levaram ao assassinato brutal de seus pais. Também aborda o planejamento do crime, a execução e a tentativa de simular um latrocínio.', 'https://www.youtube.com/watch?v=FWPFbxJ_YkQ', 'https://f.i.uol.com.br/fotografia/2021/09/22/1632320117614b3a753f3a5_1632320117_3x2_rt.jpg', 'famoso', TRUE),
('Um ano do caso Lázaro: relembre a trajetória do criminoso | Primeiro Impacto (30/06/22)', 'O caso Lázaro Barbosa, uma das maiores operações policiais do Brasil, completou um ano. O assassino tirou a vida de quatro pessoas de uma mesma família, invadiu casas e fez reféns. A perseguição se estendeu por vinte dias em território goiano e terminou com a morte do criminoso. ', 'https://www.youtube.com/watch?v=yEpTjurqUxM', 'https://s2-oglobo.glbimg.com/Q6Fp2twhBSEKB8H3FAuLVEZLxQk=/0x0:301x301/888x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_da025474c0c44edd99332dddb09cabe8/internal_photos/bs/2022/5/0/hdhwI2St270nDxTqBtnQ/96450421-um-caseiro-de-21-anos-matou-sua-mulher-que-estava-gravida-de-4-meses-a-enteada-de-2-anos-e.jpg', 'recente', TRUE),
('Um dos mandantes da chacina de Unaí é preso no Rio grande do Sul', 'Norberto Mânica, condenado a 64 anos de prisão por ser um dos mandantes da chacina de Unaí, foi preso ontem em Nova Petrópolis, na Serra Gaúcha. O crime, ocorrido em 2004, resultou na morte de três auditores fiscais do trabalho e um motorista. Durante a abordagem, ele tentou mentir sobre sua identidade, mas acabou confessando ser procurado pela justiça. ', 'https://www.youtube.com/watch?v=QPfLvi0ixes', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQUo6tNMHfIdLmhI_S30C3Dj9pwTK7Fimtckw&s', 'impactante', FALSE),
('Os Infiltrados', 'Sobre a Operação 18 Minutos, realizada pela Polícia Federal, investiga um esquema de corrupção e lavagem de dinheiro no Tribunal de Justiça do Maranhão (TJ-MA). A operação cumpriu 55 mandados de busca e apreensão nos estados do Maranhão, Pará e Rio de Janeiro. As investigações apontam que uma organização criminosa manipulava processos judiciais para obter vantagens financeiras. Entre as medidas adotadas estão afastamento de cargos públicos, sequestro de bens e monitoramento eletrônico
', 'https://www.youtube.com/watch?v=ZP6ITqkh0Js', 'https://s2-g1.glbimg.com/QnXNKEmmIp7lmNhkPV5nyL1VD5o=/0x0:595x768/984x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_59edd422c0c84a879bd37670ae4f538a/internal_photos/bs/2024/u/h/2aeC7OTdunFugI8nzEPg/8ed85e0e-c0af-41d6-9023-0bc5531796ce.jpeg', 'investigacao', FALSE),
('Entendendo a Lei Maria da Penha', 'Como funcionam as medidas protetivas previstas na Lei Maria da Penha. Ele aborda os diferentes tipos de proteção disponíveis para vítimas de violência doméstica, como afastamento do agressor, restrição de contato e suporte jurídico. Além disso, o vídeo apresenta um passo a passo sobre como solicitar essas medidas e quais são os direitos garantidos pela legislação', 'https://www.youtube.com/watch?v=Et7eH-5b68E', 'https://iclnoticias.com.br/wp-content/uploads/2024/02/LEI-MARIA-DA-PENHA.jpeg', 'leis', FALSE);



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