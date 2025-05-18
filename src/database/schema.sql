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
    text TEXT,
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


INSERT INTO news (title, description, text, link, image, category, decade, year, is_featured)
VALUES 
  (
    'Tecnologia Revoluciona a Medicina',
    'Novas tecnologias estão transformando os diagnósticos médicos.',
    'A tecnologia tem revolucionado a medicina com diagnósticos mais precisos, uso de inteligência artificial, telemedicina e avanços em tratamentos personalizados.',
    'https://exemplo.com/medicina-tecnologia',
    'https://exemplo.com/imagem1.jpg',
    'tecnologia',
    '20',
    2020,
    TRUE
  ),
  (
    'Clima Global em Alerta',
    'Pesquisadores alertam sobre mudanças climáticas cada vez mais intensas.',
    'Estudos recentes mostram que eventos climáticos extremos estão se tornando mais frequentes devido ao aquecimento global, exigindo ações urgentes de governos e sociedade.',
    'https://exemplo.com/clima-alerta',
    'https://exemplo.com/imagem2.jpg',
    'meio-ambiente',
    '10',
    2010,
    FALSE
  ),
  (
    'Educação Digital Ganha Espaço',
    'Escolas adotam ferramentas online para ensino remoto.',
    'Com a pandemia, a educação digital se tornou essencial. Plataformas online, videoaulas e recursos digitais passaram a fazer parte do cotidiano escolar.',
    'https://exemplo.com/educacao-digital',
    'https://exemplo.com/imagem3.jpg',
    'educação',
    '20',
    2021,
    TRUE
  ),
  (
    'Avanços na Energia Renovável',
    'Painéis solares e eólicos têm crescimento recorde no país.',
    'O uso de fontes renováveis de energia, como solar e eólica, bateu recordes em 2019, contribuindo para a matriz energética limpa e sustentável.',
    'https://exemplo.com/energia-renovavel',
    'https://exemplo.com/imagem4.jpg',
    'energia',
    '10',
    2019,
    FALSE
  );
INSERT INTO podcasts (title, description, link, image, category, is_featured)
VALUES 
('O Maníaco do Parque: Ullisses Campbel', 'Ullisses é escritor, e ele  vai contar histórias do livro que escreveu sobre o Maníaco do Parque, e como ele ludibriava as vítimas com sua moto. O Vilela nunca faria algo parecido, pois ele anda de patinete elétrico.', 'https://www.youtube.com/live/m_JMZDlVK9k?feature=shared', 'https://files.fm/u/bsqk5nqhs2', 'famoso', TRUE),
('Ilana Casoy', 'Ilana Casoy é escritora e expert em serial killers. Ilana tem como tema principal de seus livros os crimes de serial killers e assassinatos marcados pela perversidade, como os Nardoni e a Richthofen. O Vilela pensou em chamar a Richthofen para um papo, mas ela só estaria disponível no Dia das Mães.', 'https://www.youtube.com/live/YWaIk5BM3So?feature=shared', 'https://files.fm/u/42mzcw8dwq', 'antigo', TRUE),
('Crimes Reais: Ivan Mizanzuk', 'Ivan Mizanzuk é  professor universitário, designer, escritor, produtor de podcasts e jornalista. Ele conta “histórias reais de pessoas reais” no podcast Projeto Humanos. Já o Vilela só contrata projetos de humanos para trabalharem com ele.', 'https://youtu.be/UywLajXBLw4?feature=shared', 'https://files.fm/u/thfbuwngnx', 'reais', TRUE),
('Ela cuida das mentes mais pertubadas - Gabriela Cruz', 'Ela conhece a mente dos ped0filos! Gabriela Cruz é uma renomada psicóloga especialista em sexualidade humana. Antes de atender em clínicas, ela trabalhou durante anos em penitenciárias, acompanhando indivíduos condenados por ped0filia e outros cr1mes s3xuais', 'https://youtu.be/mdwQUT0i5dc?feature=shared', 'https://files.fm/u/ru4db2xayu', 'investigacao', TRUE),
('Crimes reais: Perita Rosangela Monteiro e Delegado Mauro Dias', 'Dra. Rosangela  é psicóloga e perita criminal, e MAURO DIAS é ex-delegado. Eles vão conversar sobre crimes reais e os processos de investigação e perícia para desvendar os casos. O Vilela é expert em esconder que comeu todo o chocolate da casa que nem um CSI São Paulo resolveria o caso.', 'https://www.youtube.com/live/28WQA1o1CDQ?feature=shared', 'https://files.fm/u/474xq2y5kf', 'investigação', TRUE),
('Crimes Reais: Caso Nardoni', 'Discussão sobre o assassinato de Isabella Nardoni.', 'https://www.youtube.com/watch?v=1XyODZb7APk', 'https://i.ytimg.com/vi/1XyODZb7APk/maxresdefault.jpg', 'famoso', TRUE),
('Crimes Reais: Caso Marísia e Marcos Matsunaga', 'Investigação sobre o assassinato de Marísia e Marcos Matsunaga.', 'https://www.youtube.com/watch?v=skj1q8v-f8k', 'https://i.ytimg.com/vi/skj1q8v-f8k/maxresdefault.jpg', 'investigacao', FALSE),
('Crime Junkie', 'Podcast semanal dedicado a cobrir casos de crimes reais.', 'https://open.spotify.com/show/3DgfoleqaW61T2amZQKINx', 'https://i.scdn.co/image/ab6765630000ba8a4e4e4e4e4e4e4e4e4e4e4e4e', 'impactante', TRUE),
('Most Notorious! A True Crime History Podcast', 'Histórias reais de crimes, criminosos, tragédias e desastres ao longo da história.', 'https://open.spotify.com/show/1JeYsvYZI4OxGTC9TJljLV', 'https://i.scdn.co/image/ab6765630000ba8a5f5f5f5f5f5f5f5f5f5f5f5f', 'reais', FALSE),
('Casos Reais', 'Histórias reais de crimes que chocaram o Brasil.', 'https://open.spotify.com/show/3eRD86zW8C1anhX5u56jBs', 'https://i.scdn.co/image/ab6765630000ba8a2b0e6e0e3f3e3e3e3e3e3e3e', 'famoso', TRUE),
('Crimecast', 'Podcast sobre crimes reais, abordando histórias conhecidas no Brasil e no mundo.', 'https://open.spotify.com/show/07MoJXc7KpasBvDSJVOMw8', 'https://i.scdn.co/image/ab6765630000ba8a3f3e3e3e3e3e3e3e3e3e3e', 'investigacao', TRUE),
('Real Crime', 'Documentários completos sobre crimes, gangsters, serial killers e as pessoas mais infames da história.', 'https://open.spotify.com/show/0JLjqhHBRN8qMTGKikm97B', 'https://i.scdn.co/image/ab6765630000ba8a6a6a6a6a6a6a6a6a6a6a6a6a', 'investigacao', FALSE),
('Crimes Reais: Telma Rocha, Edu Tachlitsky e Leandro Lopes', 'Discussão sobre crimes reais no Brasil com especialistas.', 'https://www.youtube.com/watch?v=SCYsS6VgxPY', 'https://i.ytimg.com/vi/SCYsS6VgxPY/maxresdefault.jpg', 'famoso', TRUE),
('Crimes Reais: Ricardo Salada e Jorge Lordello', 'Análise de casos criminais com especialistas.', 'https://www.youtube.com/watch?v=aPEYYaR8hVY', 'https://i.ytimg.com/vi/aPEYYaR8hVY/maxresdefault.jpg', 'impactante', FALSE),
('Crimes Reais: Ullisses Campbell e Beto Ribeiro', 'Discussão sobre crimes reais com escritores e roteiristas.', 'https://www.youtube.com/watch?v=p5xNmIgQ_Ps', 'https://i.ytimg.com/vi/p5xNmIgQ_Ps/maxresdefault.jpg', 'famoso', TRUE),
('Crimes Reais: Ivan Mizanzuk', 'Análise de crimes reais com o jornalista Ivan Mizanzuk.', 'https://www.youtube.com/watch?v=UywLajXBLw4', 'https://i.ytimg.com/vi/UywLajXBLw4/maxresdefault.jpg', 'reais', TRUE);


INSERT INTO videos (title, description, link, image, category, is_featured)
VALUES 

('Caso Evandro: Documentário Completo', 'Série documental sobre o desaparecimento de Evandro Ramos Caetano em 1992.', 'https://www.youtube.com/watch?v=XkoJiUI6jNg', 'https://i.ytimg.com/vi/XkoJiUI6jNg/maxresdefault.jpg', 'investigacao', TRUE),
('Daniel Alves: Absolvição na Espanha', 'Notícia sobre a absolvição de Daniel Alves da acusação de estupro.', 'https://www.youtube.com/watch?v=3Hs4beu3Pr8', 'https://i.ytimg.com/vi/3Hs4beu3Pr8/maxresdefault.jpg', 'recente', TRUE),
('Boate Kiss: A Tragédia de Santa Maria', 'Documentário sobre o incêndio na Boate Kiss que matou 242 pessoas.', 'https://www.youtube.com/watch?v=MCvD2tGSvSg', 'https://i.ytimg.com/vi/MCvD2tGSvSg/maxresdefault.jpg', 'impactante', FALSE),
('Máfia da Merenda: Corrupção em SP', 'Reportagem sobre o esquema de corrupção na merenda escolar em São Paulo.', 'https://www.youtube.com/watch?v=dMySOxRcAFk', 'https://i.ytimg.com/vi/dMySOxRcAFk/maxresdefault.jpg', 'investigacao', FALSE),
('Pacote Anticrime: Análise Jurídica', 'Análise das mudanças trazidas pelo Pacote Anticrime na legislação penal.', 'https://www.youtube.com/watch?v=PBtEWKVzxjk', 'https://i.ytimg.com/vi/PBtEWKVzxjk/maxresdefault.jpg', 'leis', FALSE),
('Suzane von Richthofen: O Crime', 'Documentário sobre o assassinato dos pais de Suzane von Richthofen.', 'https://www.youtube.com/watch?v=Iv572FJpZSc', 'https://i.ytimg.com/vi/Iv572FJpZSc/maxresdefault.jpg', 'crime', TRUE),
('Operação Lava Jato: 10 Anos', 'Especial sobre os 10 anos da Operação Lava Jato e seus desdobramentos.', 'https://www.youtube.com/watch?v=xaiPHbjRTmE', 'https://i.ytimg.com/vi/xaiPHbjRTmE/maxresdefault.jpg', 'investigacao', TRUE),
('Caso Lázaro Barbosa: A Caçada', 'Cobertura da caçada policial a Lázaro Barbosa em 2021.', 'https://www.youtube.com/watch?v=R6OGs5YQvKU', 'https://i.ytimg.com/vi/R6OGs5YQvKU/maxresdefault.jpg', 'recente', TRUE),
('João de Deus: Condenação', 'Notícia sobre a condenação de João de Deus por crimes de estupro.', 'https://www.youtube.com/watch?v=8zFQn_Z1o-I', 'https://i.ytimg.com/vi/8zFQn_Z1o-I/maxresdefault.jpg', 'investigacao', FALSE),
('Caso Miguel: Negligência Fatal', 'Reportagem sobre a morte do menino Miguel e a responsabilidade da patroa.', 'https://www.youtube.com/watch?v=9BijzzxvENA', 'https://i.ytimg.com/vi/9BijzzxvENA/maxresdefault.jpg', 'crime', TRUE),
('Chacina da Candelária: 30 Anos', 'Análise do massacre de oito jovens em frente à Igreja da Candelária.', 'https://www.youtube.com/watch?v=SJHxESnm6Ys', 'https://i.ytimg.com/vi/SJHxESnm6Ys/maxresdefault.jpg', 'impactante', FALSE),
('Caso Amarildo: Desaparecimento', 'Reportagem sobre o desaparecimento do pedreiro Amarildo na Rocinha.', 'https://www.youtube.com/watch?v=7ujN1Z717sY', 'https://i.ytimg.com/vi/7ujN1Z717sY/maxresdefault.jpg', 'investigacao', FALSE),
('Máfia das Sanguessugas: Fraude', 'Documentário sobre o esquema de fraude na compra de ambulâncias.', 'https://www.youtube.com/watch?v=FNmjVunHDps', 'https://i.ytimg.com/vi/FNmjVunHDps/maxresdefault.jpg', 'corrupção', FALSE),
('Assassinato de Celso Daniel', 'Investigação sobre o assassinato do prefeito Celso Daniel.', 'https://www.youtube.com/watch?v=zM1a1eVPO4Q', 'https://i.ytimg.com/vi/zM1a1eVPO4Q/maxresdefault.jpg', 'crime', FALSE),
('Caso Isabele Ramos: Tragédia em Cuiabá', 'Cobertura sobre a morte da adolescente Isabele Ramos em Cuiabá.', 'https://www.youtube.com/watch?v=rt7W8zsSxDg', 'https://i.ytimg.com/vi/rt7W8zsSxDg/maxresdefault.jpg', 'crime', FALSE);

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
    ('Julia Andrade Guarnieri', 'Product Owner', 'https://avatars.githubusercontent.com/u/158210661?v=4', 1),
    ('Luiza Nicoluci Schettini', 'Scrum Master', 'https://avatars.githubusercontent.com/u/158210596?v=4', 1),
    ('Anna Beatriz Leme Alves', 'Desenvolvedor (a)', 'https://avatars.githubusercontent.com/u/162629023?v=4', 1),
    ('Anna Beatriz Ribeiro Valentim', 'Desenvolvedor (a)', 'https://avatars.githubusercontent.com/u/158473512?v=4', 1),
    ('Luiz Gabriel Lopes Carvalho Pinto', 'Desenvolvedor (a)', 'https://mail.google.com/mail/u/0?ui=2&ik=1a84e770a3&attid=0.1&permmsgid=msg-f:1832212135489621963&th=196d533ad104cfcb&view=fimg&fur=ip&permmsgid=msg-f:1832212135489621963&sz=s0-l75-ft&attbid=ANGjdJ_uSM2lS10wc1pjDksQ-c1DpQyGezR9izRsi9wmVRQmDctfDS4bVqhfLIyTIV4WF8AJS48rdHQaE8u4LzqGwwcXNhyRndhVkQHF_3rzn5EAWc8hggQsOna98d8&disp=emb&realattid=ii_196d5336f88654b64d21&zw', 1),
    ('Carlos Eduardo Ferraz Augusto', 'Desenvolvedor (a)', 'https://avatars.githubusercontent.com/u/158209729?s=400&u=ea58c944f794b2851f01abda7ad25341d06255dc&v=4', 1);


    ALTER TABLE likes ADD CONSTRAINT unique_user_post UNIQUE (user_id, post_id);