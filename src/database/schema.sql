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

    INSERT INTO about_page (main_title, subtitle, description, commitment_title, commitment_text)
    VALUES (
        'Sobre Nos',
        'Conheça nossa equipe e proposito',
        'Somos uma equipe dedicada a preservar e divulgar a memoria historica de decadas passadas por meio de noticias, videos e podcasts.',
        'Nosso Compromisso',
        'Garantir informação de qualidade, curadoria historica e acesso livre ao conhecimento.'
    );
        
    INSERT INTO team_members (name, role, photo_url, about_page_id)
    VALUES 
        ('Julia Andrade Guarnieri', 'Product Owner', 'https://avatars.githubusercontent.com/u/158210661?v=4', 1),
        ('Luiza Nicoluci Schettini', 'Scrum Master', 'https://avatars.githubusercontent.com/u/158210596?v=4', 1),
        ('Anna Beatriz Leme Alves', 'Desenvolvedor (a)', 'https://avatars.githubusercontent.com/u/162629023?v=4', 1),
        ('Anna Beatriz Ribeiro Valentim', 'Desenvolvedor (a)', 'https://avatars.githubusercontent.com/u/158473512?v=4', 1),
        ('Luiz Gabriel Lopes Carvalho', 'Desenvolvedor (a)', 'https://github.com/juguarnieri/site-ingles/blob/main/img/luiz.jpg?raw=true', 1),
        ('Carlos Eduardo Ferraz Augusto', 'Desenvolvedor (a)', 'https://avatars.githubusercontent.com/u/158209729?s=400&u=ea58c944f794b2851f01abda7ad25341d06255dc&v=4', 1);


        ALTER TABLE likes ADD CONSTRAINT unique_user_post UNIQUE (user_id, post_id);
    -- exemplos de inserts para popular as tabelas

    INSERT INTO users (username, name, profile_picture) VALUES
    ('ana_silva', 'Ana Silva', 'anasilva.jpeg'),
    ('joao_martins', 'Joao Martins', 'joaomartins.jpeg'),
    ('carla_oliveira', 'Carla Oliveira', 'carlaoliveira.jpeg'),
    ('alice01', 'Alice Silva', 'alice01.jpeg'),
    ('bob02', 'Bob Costa', 'bob02.jpeg'),
    ('carol03', 'Carol Mendes', 'carolmendes.jpeg'),
    ('david04', 'David Rocha', 'davidrocha.jpeg'),
    ('eva05', 'Eva Lima', 'evalima.jpeg'),
    ('felipe06', 'Felipe Souza', 'felipesouza.jpeg'),
    ('gabriela07', 'Gabriela Oliveira', 'gabrielaoliveira.jpeg'),
    ('henrique08', 'Henrique Almeida', 'henriquealmeida.jpeg'),
    ('isabela09', 'Isabela Pereira', 'isabelapereira.jpeg'),
    ('joao10', 'Joao Santos', 'joaosantos.jpeg'),
    ('karla11', 'Karla Martins', 'karlamartins.jpeg'),
    ('luan12', 'Luan Costa', 'luancosta.jpeg'),
    ('mariana13', 'Mariana Rocha', 'marianarocha.jpeg'),
    ('natalia14', 'Natalia Lima', 'natalialima.jpeg'),
    ('olga15', 'Olga Fernandes', 'olgafernandes.jpeg'),
    ('lucas_ferreira', 'Lucas Ferreira', 'lucasferreira.jpeg'),
    ('jornalista_marcelo', 'Marcelo Almeida', 'marceloalmeida.jpg'),
    ('criminologa_ana', 'Ana Costa', 'anacosta.jpeg'),
    ('familia_isabella', 'Familia Nardoni', 'familianardoni.jpeg'),
    ('investigador_joao', 'Joao Pereira', 'joaopereira.jpeg'),
    ('curioso_luana', 'Luana Souza', 'luanasouza.jpg'),
    ('jornalista_luiz', 'Luiz Oliveira', 'luizoliveira.jpeg'),
    ('especialista_ricardo', 'Ricardo Silva', 'ricardosilva.jpg'),
    ('familia_eloa', 'Familia Eloa', 'familiaeloa.png'),
    ('advogada_maria', 'Maria Fernandes', 'mariafernandes.jpeg'),
    ('historiador_pedro', 'Pedro Gomes', 'pedrogomes.jpeg'),
    ('psicologa_clara', 'Clara Martins', 'claramartins.jpg'),
    ('blogueira_tatiane', 'Tatiane Lima', 'tatianelima.jpeg'),
    ('fotografo_rafael', 'Rafael Costa', 'rafaelcosta.jpeg'),
    ('youtuber_eduardo', 'Eduardo Pereira', 'eduardopereira.jpeg'),
    ('professor_jose', 'Jose Almeida', 'josealmeida.jpg'),
    ('estudante_ana', 'Ana Beatriz', 'anabeatriz.jpeg'),
    ('pesquisador_lucas', 'Lucas Rocha', 'lucasrocha.jpg'),
    ('jornalista_fernanda', 'Fernanda Oliveira', 'fernandaoliveira.jpg'),
    ('familia_bernardo', 'Familia Boldrini', 'familiabernardo.jpg'),
    ('curioso_patricia', 'Patricia Souza', 'patriciasouza.jpg'),
    ('especialista_fernando', 'Fernando Lima', 'fernandolima.jpg'),
    ('advogado_ricardo', 'Ricardo Costa', 'ricardocosta.jpg'),
    ('historiador_luiza', 'Luiza Martins', 'luizamartins.jpg'),
    ('psicologa_juliana', 'Juliana Pereira', 'julianapereira.jpg'),
    ('blogueira_marcela', 'Marcela Gomes', 'marcelagomes.jpeg'),
    ('fotografo_juliano', 'Juliano Silva', 'julianosilva.jpg'),
    ('youtuber_renata', 'Renata Costa', 'renatacosta.jpg'),
    ('professor_pedro', 'Pedro Lima', 'pedrolima.jpg'),
    ('estudante_rafael', 'Rafael Almeida', 'rafaelalmeida.jpg'),
    ('pesquisador_claudia', 'Claudia Rocha', 'claudiarocha.jpg'),
    ('jornalista_ana', 'Ana Souza', 'anasouza.jpg'),
    ('familia_realengo', 'Familia Realengo', 'familiarealengo.jpg');

    INSERT INTO followers (follower_id, following_id) VALUES
(1, 2), 
(1, 3), 
(1, 4),
(1, 5), 
(1, 6),
(2, 1), 
(2, 3), 
(2, 4), 
(2, 5), 
(3, 1), 
(3, 2), 
(3, 4), 
(3, 5), 
(3, 6),
(4, 2), 
(5, 1), 
(6, 2), 
(7, 3), 
(8, 1),
(20, 1), 
(20, 2),
(21, 3), 
(21, 6),
(22, 3),
(23, 1), 
(23, 2),
(24, 3), 
(24, 5),
(25, 1),
(25, 20),
(26, 21),
(27, 8),
(28, 20), 
(28, 23),
(29, 1),
(30, 3), 
(30, 4),
(31, 6), 
(31, 24),
(32, 2), 
(32, 4),
(33, 1), 
(33, 3),
(34, 2),
(35, 3),
(36, 26), 
(36, 21),
(37, 1), 
(37, 2),
(38, 14),
(39, 5), 
(39, 8),
(40, 26),
(41, 28), 
(41, 23),
(42, 29),
(43, 30),
(44, 31),
(45, 32),
(46, 33),
(47, 34),
(48, 35),
(49, 36),
(50, 37),
(51, 5), 
(51, 2);

    INSERT INTO posts (user_id, title, caption, media_url) VALUES
(1, 'Caso Evandro', 'O desaparecimento do menino Evandro chocou o Brasil nos anos 90.', 'evandro.jpg'),
(2, 'Chacina da Candelaria', 'Tragedia que marcou o Rio de Janeiro em 1993.', 'candelaria.jpg'),
(3, 'Caso Isabella Nardoni', 'Uma investigacao que parou o pais em 202008.', 'nardoni.jpg'),
(4, 'Crimes da Rua Cuba', 'Um misterio sem solucao que intriga ate hoje.', 'cuba.jpg'),
(5, 'Maniaco do Parque', 'Francisco de Assis foi condenado por uma serie de assassinatos brutais.', 'maniacoparque.jpg'),
(1, 'Caso Richthofen', 'Suzane planejou o assassinato dos proprios pais.', 'richthofen.jpg'),
(2, 'Caso Nardoni: Julgamento', 'Acompanhe os detalhes do julgamento mais marcante da decada.', 'julgamento.jpg'),
(3, 'Caso Eloa', 'O sequestro e morte de Eloa teve repercussao nacional.', 'eloa.jpg'),
(4, 'Caso Joao Helio', 'Um crime brutal que mobilizou o pais por justica.', 'joao_helio.jpg'),
(5, 'Assassinato de PC Farias', 'Um dos maiores misterios politicos do Brasil.', 'pcfarias.jpg'),
(1, 'Caso Mercia Nakashima', 'Ciumes e vinganca em um dos crimes mais midiaticos.', 'nakashima.jpg'),
(2, 'Bruno e Eliza', 'O goleiro Bruno foi condenado pelo assassinato de Eliza Samudio.', 'brunoeliza.jpg'),
(3, 'Caso Daniela Perez', 'Crime passional que chocou o pais na decada de 90.', 'danielaperez.jpg'),
(4, 'Caso Bernardo Boldrini', 'O assassinato de uma crianca pelo proprio pai e madrasta.', 'bernardo.jpg'),
(5, 'Chacina de Osasco', 'Execucoes em serie envolvendo PMs e ex-PMs.', 'osasco.jpg'),
(1, 'Caso Ana Lidia', 'Assassinato brutal de uma crianca em Brasilia (1973).', 'analidia.jpg'),
(2, 'Caso Madeleine McCann', 'Desaparecimento que teve repercussao internacional.', 'mccann.jpg'),
(3, 'O Monstro de Goiania', 'Crime de serial killer que chocou o centro-oeste brasileiro.', 'goiania.jpg'),
(4, 'Assassinato de Angela Diniz', 'Caso de feminicidio com grande repercussao nos anos 70.', 'angela.jpg'),
(5, 'Massacre de Realengo', 'Ataque a uma escola no Rio em 202011 deixou 12 mortos.', 'realengo.jpg'),
(6, 'Caso Pedrinho', 'O reencontro emocionante apos 16 anos de sequestro.', 'pedrinho.jpg'),
(7, 'Caso Marielle Franco', 'O assassinato que mobilizou investigacoes federais.', 'mariellefranco.jpg'),
(8, 'Caso Henry Borel', 'A morte do menino Henry e a comocao nacional.', 'henryborel.jpg'),
(9, 'Caso Daniel Correa', 'O crime brutal envolvendo o jogador Daniel Correa.', 'danielcorrea.jpg'),
(10, 'Caso Rafael Miguel', 'O assassinato do ator e seus pais chocou o Brasil.', 'rafaelmiguel.jpg'),
(11, 'Caso Amarildo', 'O desaparecimento do pedreiro Amarildo na Rocinha.', 'amarildo.jpg'),
(12, 'Caso Celso Daniel', 'O misterio do assassinato do prefeito de Santo Andre.', 'celsodaniel.jpg'),
(13, 'Caso Boate Kiss', 'A tragedia que matou 242 pessoas em Santa Maria.', 'kiss.jpg'),
(14, 'Caso Madeleine McCann', 'O desaparecimento que virou misterio mundial.', 'madeleinemccann.jpeg'),
(15, 'Caso Eloa', 'O sequestro transmitido ao vivo pela TV.', 'eloa.jpg'),
(16, 'Caso Suzane Richthofen', 'O crime que chocou o pais pelo envolvimento da filha.', 'richthofen.jpg'),
(17, 'Caso Maniaco do Parque', 'A historia de um dos maiores serial killers do Brasil.', 'maniacoparque.jpg'),
(18, 'Caso Bernardo Boldrini', 'O assassinato brutal de uma crianca pelo proprio pai.', 'bernardo.jpg'),
(19, 'Caso Realengo', 'O massacre em uma escola do Rio de Janeiro.', 'realengo.jpg'),
(20, 'Caso Chris Watts', 'O crime familiar que chocou os EUA.', 'chriswhatts.jpeg'),
(21, 'Caso Luka Magnotta', 'O assassinato filmado e divulgado na internet.', 'lukamagnotta.jpeg'),
(22, 'Caso Eliza Samudio', 'O feminicidio ligado ao goleiro Bruno.', 'elizasamudio.jpeg'),
(23, 'Caso Onibus 174', 'O sequestro transmitido ao vivo no Rio.', 'onibus174.jpeg'),
(24, 'Caso Friedenbach-Caffe', 'O crime barbaro contra um casal de adolescentes.', 'friedenbach.jpg'),
(25, 'Caso Angela Diniz', 'O feminicidio que marcou a luta por justica.', 'angela.jpg'),
(26, 'Caso Carlinhos', 'O desaparecimento misterioso no Rio de Janeiro.', 'carlinhos.jpeg'),
(27, 'Caso John Lennon', 'O assassinato do ex-Beatle em Nova York.', 'john_lennon.jpeg'),
(28, 'Caso Niels Hogel', 'O enfermeiro alemao condenado por 85 assassinatos.', 'nielshogel.jpeg'),
(29, 'Caso John Wayne Gacy', 'O palhaco assassino dos EUA.', 'johnwayne.jpeg'),
(30, 'Caso Jeffrey Dahmer', 'O canibal de Milwaukee.', 'jeffreydahmer.jpg'),
(31, 'Caso Serial Killers nos EUA', 'A decada de 80 marcada por assassinos em serie.', 'serialkillers.jpeg'),
(32, 'Caso Caryn Campbell', 'Uma das vitimas de Ted Bundy.', 'caryncampbell.jpeg'),
(33, 'Caso Lynda Ann Healy', 'A primeira vitima conhecida de Ted Bundy.', 'lyndaannhealy.jpeg'),
(34, 'Caso Kimberly Leach', 'A ultima vitima de Ted Bundy.', 'kimberlyleach.jpeg'),
(35, 'Caso Angela Diniz no STF', 'O caso citado como marco contra o feminicidio.', 'angela.jpg'),
(36, 'Caso Daniella Perez', 'O assassinato da atriz e o debate sobre feminicidio.', 'danielaperez.jpg'),
(37, 'Caso Miriam Brandao', 'A morte da menina Miriam e a mobilizacao nacional.', 'meninamiriam.jpeg'),
(38, 'Caso Acari', 'O desaparecimento de 11 jovens no Rio.', 'acari.jpeg'),
(39, 'Caso Shopping Morumbi', 'O ataque a tiros em um shopping de SP.', 'morumbi.jpg'),
(40, 'Caso Madeleine: Novas pistas', 'A investigacao reaberta pela Scotland Yard.', 'madeleinemccann.jpeg'),
(41, 'Caso Stephen Paddock', 'O massacre de Las Vegas em 202017.', 'stephenpaddock.jpeg'),
(42, 'Caso Clara Maria', 'O crime brutal em Belo Horizonte em 202025.', 'claramaria.jpeg'),
(43, 'Caso Menino Arremessado', 'O crime chocante em Sao Gabriel, RS.', 'meninoarremessado.jpeg'),
(44, 'Caso Trapezista Argentina', 'O assassinato em Buzios em 202023.', 'trapezistaargentina.jpeg'),
(45, 'Caso Motorista de App', 'Tentativa de estupro e roubo em SP.', 'motoristadeapp.jpeg'),
(46, 'Caso Cantor Afogado', 'A morte suspeita em Pernambuco.', 'cantorafogado.jpeg'),
(47, 'Caso Filho Mata Pai', 'O crime familiar em Santa Catarina.', 'filhomatapai.jpg'),
(48, 'Caso Vitoria Regina', 'Investigacao sobre a morte de Vitoria Regina.', 'vitoriaregina.jpg'),
(49, 'Caso Familia Goncalves', 'O crime brutal em Sao Bernardo do Campo.', 'familiagoncalves.jpg'),
(50, 'Caso Milena Dantas', 'O feminicidio com requintes de crueldade.', 'milenadantas.jpg'),
(51, 'Caso Mangue 937', 'O sequestro e execucao de tres mulheres em Fortaleza.', 'mangue937.jpg');



    INSERT INTO likes (user_id, post_id) VALUES
    (1, 2),
    (1, 3),
    (2, 1),
    (2, 4),
    (3, 5),
    (3, 1),
    (4, 4),
    (4, 2),
    (5, 3),
    (5, 1),
    (6, 5),
    (7, 9),
    (8, 4),
    (9, 3),
    (10, 2);

    INSERT INTO comments (user_id, post_id, content) VALUES
(1, 1, 'Esse caso me marcou muito, lembro das noticias na TV.'),
(2, 3, 'A investigacao desse crime foi muito detalhada.'),
(3, 5, 'O Maniaco do Parque realmente chocou o Brasil.'),
(4, 8, 'A morte do Henry Borel foi muito triste, acompanhei tudo.'),
(5, 2, 'A Chacina da Candelaria e um dos casos mais tristes do Rio.'),
(6, 6, 'O caso Pedrinho teve um final surpreendente.'),
(7, 7, 'O assassinato da Marielle Franco precisa de justica.'),
(8, 4, 'O caso Joao Helio nunca saiu da minha cabeca.'),
(9, 10, 'O caso Rafael Miguel foi muito impactante para todos.'),
(10, 12, 'O desaparecimento do Amarildo ainda e um misterio.'),
(11, 13, 'A tragedia da Boate Kiss foi uma das maiores do Brasil.'),
(12, 14, 'O caso Madeleine McCann e um misterio ate hoje.'),
(13, 15, 'O caso Eloa foi transmitido ao vivo, muito tenso.'),
(14, 16, 'O crime da Suzane Richthofen chocou o pais.'),
(15, 18, 'O caso Bernardo Boldrini mostra a importancia da protecao a infancia.'),
(16, 19, 'O massacre de Realengo foi um dia triste para todos nos.'),
(17, 20, 'O caso Chris Watts e um exemplo de como o mal pode estar perto.'),
(18, 21, 'O caso Luka Magnotta e um dos mais bizarros que ja ouvi falar.'),
(19, 22, 'O feminicidio da Eliza Samudio e um caso que nao podemos esquecer.'),
(20, 23, 'O sequestro do onibus 174 foi um momento tenso na TV.'),
(21, 24, 'O caso Friedenbach-Caffe e um exemplo de como a violencia pode atingir qualquer um.'),
(22, 25, 'O caso Angela Diniz e um marco na luta contra o feminicidio.'),
(23, 26, 'O desaparecimento do Carlinhos e um misterio que ainda intriga.'),
(24, 27, 'O assassinato do John Lennon foi um choque mundial.'),
(25, 28, 'O caso Niels Hogel e um exemplo de como a confianca em profissionais de saude pode ser traicoeira.'),
(26, 29, 'O caso John Wayne Gacy e um dos mais assustadores da historia dos EUA.'),
(27, 30, 'O caso Jeffrey Dahmer e um exemplo de como a mente humana pode ser sombria.'),
(28, 31, 'A decada de 80 foi marcada por muitos serial killers nos EUA.'),
(29, 32, 'Caryn Campbell foi uma das vitimas de Ted Bundy, um caso que ainda choca.'),
(30, 33, 'Lynda Ann Healy foi a primeira vitima conhecida de Ted Bundy, um caso que marcou a historia dos crimes nos EUA.'),
(31, 34, 'Kimberly Leach foi a ultima vitima de Ted Bundy, um caso que ainda gera discussoes sobre seguranca publica.'),
(32, 35, 'O caso de Angela Diniz e um marco na luta contra o feminicidio no Brasil.'),
(33, 36, 'O caso Carlinhos e um dos maiores misterios criminais do Brasil, ainda sem solucao.'),
(34, 37, 'O assassinato de John Lennon foi um evento tragico que abalou o mundo todo.'),
(35, 38, 'O caso Niels Hogel e um exemplo de como a confianca em profissionais de saude pode ser traicoeira.'),
(36, 39, 'John Wayne Gacy, o palhaco assassino, e um dos casos mais assustadores da historia dos EUA.'),
(37, 40, 'Jeffrey Dahmer, o canibal de Milwaukee, e um exemplo de como a mente humana pode ser sombria.'),
(38, 41, 'A decada de 80 foi marcada por muitos serial killers nos EUA, um periodo sombrio na historia do crime.'),
(39, 42, 'O caso de Caryn Campbell e um lembrete tragico dos crimes de Ted Bundy, um dos serial killers mais notorios da historia.'),
(40, 43, 'Lynda Ann Healy foi a primeira vitima conhecida de Ted Bundy, um caso que marcou a historia dos crimes nos EUA.'),
(41, 44, 'Kimberly Leach foi a ultima vitima de Ted Bundy, um caso que ainda gera discussoes sobre seguranca publica.'),
(42, 45, 'O caso de Angela Diniz e um marco na luta contra o feminicidio no Brasil, um exemplo de como a sociedade pode se mobilizar por justica.'),
(43, 46, 'O caso Carlinhos e um dos maiores misterios criminais do Brasil, ainda sem solucao.'),
(44, 47, 'O assassinato de John Lennon foi um evento tragico que abalou o mundo todo, um lembrete da fragilidade da vida.'),
(45, 48, 'O caso Niels Hogel e um exemplo de como a confianca em profissionais de saude pode ser traicoeira, um alerta para todos nos.'),
(46, 49, 'John Wayne Gacy, o palhaco assassino, e um dos casos mais assustadores da historia dos EUA, um exemplo do mal que pode se esconder atras de uma fachada.'),
(47, 50, 'Jeffrey Dahmer, o canibal de Milwaukee, e um exemplo de como a mente humana pode ser sombria, um caso que ainda intriga especialistas em criminologia.'),
(48, 51, 'A decada de 80 foi marcada por muitos serial killers nos EUA, um periodo sombrio na historia do crime que ainda gera discussoes sobre seguranca publica.');

    --decadas de 70
    INSERT INTO news (title, description, text, link, image, category, decade, year, is_featured)
VALUES 

('Caryn Campbell, uma das vitimas de Ted Bundy.',
'Campbell tinha 23 anos quando desapareceu do resort no Colorado. Ela foi vista pela ultima vez indo ao saguao buscar uma revista e nunca voltou.',
'Caryn Campbell, de 23 anos, desapareceu misteriosamente em 1975 enquanto estava hospedada com sua familia em um resort no Colorado. Vinda de Chicago para passar ferias, ela foi vista pela ultima vez ao sair do quarto para buscar uma revista no saguao do hotel, mas nunca retornou. Sua ausencia foi notada rapidamente, e buscas foram iniciadas, mas sem sucesso imediato. O caso chamou a atencao da imprensa pela falta de pistas e pelo contexto aparentemente tranquilo em que o desaparecimento ocorreu. Meses depois, seu corpo foi encontrado proximo ao resort, confirmando que ela fora vitima de homicidio. Posteriormente, investigacoes ligaram seu assassinato ao serial killer Ted Bundy, que aterrorizou os Estados Unidos na decada de 1970. A tragedia de Caryn se tornou um dos exemplos mais emblematicos da brutalidade de Bundy e do impacto devastador em familias e comunidades.',
'https://www.reddit.com/r/serialkillers/comments/1794p7g/caryn_campbell_one_of_ted_bundys_victims_was_on/?tl=pt-br',
'caryncampbell.jpeg',
'Homicidio', '70', 1975, FALSE),

('Lynda Ann Healy: A Primeira Vitima de Ted Bundy',
'Aos 21 anos, Lynda Ann Healey desapareceu em 1974. Sangue foi encontrado em seus lencois, e sua camisola pendurada no armario.',
'Lynda Ann Healy, uma jovem de 21 anos, era estudante da Universidade de Washington e trabalhava como garota do tempo em uma radio local. Em fevereiro de 1974, ela desapareceu misteriosamente de sua casa, marcando o inicio da serie de crimes brutais de Ted Bundy. Na manha seguinte ao desaparecimento, amigos estranharam sua ausencia e acionaram a policia, que encontrou o quarto de Lynda com sinais de luta: sangue em seus lencois e travesseiro, e marcas de violencia. O caso chocou a comunidade universitaria e trouxe medo a regiao, pois nao havia sinais de arrombamento e o crime parecia cuidadosamente planejado. Lynda foi posteriormente identificada como a primeira vitima confirmada de Bundy, um assassino em serie que ficaria conhecido por sua frieza e manipulacao, deixando um rastro de dor e misterio por onde passou.',
'https://aventurasnahistoria.com.br/noticias/vitrine/historia-as-vitimas-esquecidas-de-ted-bundy.phtml',
'lyndaannhealy.jpeg',
'Homicidio', '70', 1974, FALSE),

('Kimberly Leach, a ultima vitima de Ted Bundy',
'Kimberly Leach, 12 anos, desapareceu em 1978 em Lake City, Florida. A policia prendeu Ted Bundy, ja procurado pelo FBI.',
'Kimberly Leach, de apenas 12 anos, foi a ultima vitima conhecida de Ted Bundy. Em 9 de fevereiro de 1978, ela desapareceu durante o horario escolar em Lake City, Florida. Professores e colegas notaram rapidamente sua ausencia e a policia foi acionada, dando inicio a uma intensa busca. A investigacao logo apontou para Ted Bundy, que estava foragido e era considerado extremamente perigoso, ja figurando na lista dos mais procurados do FBI. Aproximadamente dois meses depois, o corpo de Kimberly foi encontrado em uma area remota, confirmando o pior desfecho para sua familia e para a comunidade. O assassinato de Kimberly marcou o fim da trajetoria criminosa de Bundy, que foi capturado pouco depois e responsabilizado por uma serie de crimes violentos que chocaram a sociedade norte-americana.',
'https://aventurasnahistoria.com.br/noticias/vitrine/historia-as-vitimas-esquecidas-de-ted-bundy.phtml',
'KimberlyLeach.jpeg',
'Homicidio', '70', 1978, TRUE),

('O Caso de Angela Diniz Mudou a Justica Brasileira',
'O caso Angela Diniz foi um marco na luta contra o feminicidio no Brasil.',
'O caso de Angela Diniz tornou-se um simbolo na luta contra o feminicidio no Brasil. Em 1976, Angela foi assassinada a tiros pelo entao namorado, Raul Fernando do Amaral Street, conhecido como Doca Street, em Buzios, RJ. O crime chocou o pais nao apenas pela brutalidade, mas tambem pela reacao da sociedade e pelos desdobramentos juridicos. Inicialmente, o assassino foi beneficiado por um discurso de defesa que culpabilizava a vitima, gerando revolta publica. A mobilizacao social e midiaticia em torno do caso impulsionou debates fundamentais sobre violencia de genero e mudancas na legislacao, influenciando o endurecimento das penas para crimes passionais e o reconhecimento do feminicidio como crime hediondo. Ate hoje, Angela e lembrada como um marco na luta pelos direitos das mulheres e justica para as vitimas de violencia domestica no Brasil.',
'https://g1.globo.com/rj/rio-de-janeiro/noticia/202023/09/16/quem-ama-nao-mata-o-feminicidio-de-1976-que-ajudou-a-mudar-a-justica-brasileira.ghtml',
'angela-e-doca.jpeg',
'Feminicidio', '70', 1976, TRUE),

('Caso Carlinhos',
'Aos 77 anos, Conceicao lembra de um evento tragico que mudou sua familia para sempre',
'O caso Carlinhos e um dos maiores misterios criminais do Brasil. Em 2 de agosto de 1973, Carlinhos, um menino de apenas 10 anos, foi sequestrado em sua casa, no Rio de Janeiro, enquanto dormia com os pais e irmaos. Apesar das buscas intensas e de diversas linhas de investigacao, incluindo suspeitas sobre seu proprio pai, Joao, o paradeiro de Carlinhos jamais foi descoberto. O caso abalou profundamente a familia, especialmente sua mae, Conceicao, que aos 77 anos ainda relembra o sofrimento e a falta de respostas. O desaparecimento de Carlinhos mobilizou a opiniao publica, repercutiu na midia nacional e internacional, e permanece sem solucao ate hoje. O misterio e a dor da familia se tornaram simbolo da luta de parentes de desaparecidos, e o caso segue como um dos mais emblematicos e intrigantes do pais.', 
'https://oglobo.globo.com/rio/dez-crimes-que-chocaram-rio-de-janeiro-17845895',
'Carlinhos.jpeg',
'Assassinato', '70', 1973, FALSE);


    --decadas de 80
  INSERT INTO news (title, description, text, link, image, category, decade, year, is_featured)
VALUES 
('1980: decada dos SERIAL KILLERS nos EUA',
'Durante tres decadas da segunda metade do seculo 2020, a America do Norte registrou um crescimento expressivo no numero de homicidios em serie, caracterizados por crimes semelhantes cometidos por um mesmo autor, os chamados serial killers.',
'Washington 10 de junho de 2025. O ano de 1980 e mais amplamente a decada de 1980 ficou para sempre marcado na historia dos Estados Unidos como o periodo mais sombrio no que diz respeito a proliferacao de serial killers. Foi uma epoca em que o medo permeava as ruas e a midia popularizou o termo serial killer cunhado pelo FBI para descrever criminosos que cometiam assassinatos em serie com intervalos de tempo entre os crimes.Nos anos 80 os EUA enfrentavam uma combinacao de fatores que segundo especialistas contribuiram para o aumento da atividade desses assassinos em serie.Movimentacao massiva de pessoas entre estados dificultando o rastreamento de criminosos.
Deficiencias tecnologicas nas investigacoes forenses.Mudancas culturais e sociais que criavam tanto vitimas vulneraveis quanto criminosos oportunistas.Ted Bundy executado em 1989 confessou mais de 30 assassinatos embora o numero real permaneça desconhecido.
John Wayne Gacy condenado por matar pelo menos 33 jovens e enterra-los sob sua casa capturado em 1978 e executado em 1994.
Richard Ramirez Night Stalker aterrorizou a California em meados da decada.
Gary Ridgway Green River Killer embora so tenha sido preso em 2001 cometeu muitos de seus crimes na decada de 1980.
David Berkowitz Son of Sam preso em 1977 mas seu caso e cobertura midiática impulsionaram a paranoia no inicio da decada.',
'https://www.bbc.com/portuguese/internacional-45363043',
'SerialKillers.jpeg',
'Criminologia', '80', 1980, TRUE),

('Um homem aparentemente inofensivo dos EUA: Ted Bundy',
'Jeffrey Dahmer, o Canibal de Milwaukee, matou 17 homens e garotos entre 1977 e 1991. Nascido em 1960, cometeu o primeiro assassinato aos 17 anos.',
'Atraia suas vitimas para sua casa, utilizando diferentes artifcios e estrategias para conquistar sua confianca, como promessas de empregos, ofertas de ajuda ou ate mesmo convites para eventos sociais. Ao chegarem ao local, as vitimas eram surpreendidas por sua verdadeira intencao: cometia atos horriveis, envolvendo violencia extrema, tortura psicologica e fisica, alem de abusos de varias naturezas. Ele demonstrava uma crueldade incomum, prolongando o sofrimento de suas vitimas antes de desmembrar os corpos de maneira meticulosa, evidenciando um grau assustador de frieza e falta de empatia. Apos cometer esses crimes brutais, ele se dedicava a ocultar cuidadosamente as provas, espalhando partes dos corpos em locais remotos, enterrando restos mortais em seu proprio quintal ou ate mesmo mantendo fragmentos como trofeus macabros. Sua habilidade em manipular e enganar pessoas dificultou por muito tempo as investigacoes policiais, fazendo com que permanecesse impune por anos. Antes de ser finalmente capturado, ja havia tido varios problemas com a lei, incluindo envolvimento em pequenos delitos e comportamentos suspeitos. Sua passagem pelo exercito tambem foi marcada por episodios de indisciplina, agressividade e desrespeito as regras, fatores que contribuiram para sua expulsao da instituicao militar. Esse historico de transgressoes, associado a sua personalidade fria e calculista, permitiu que ele continuasse a agir sem levantar grandes suspeitas, ate que suas atrocidades vieram a tona, chocando toda a sociedade.',
'https://f5.folha.uol.com.br/cinema-e-series/202022/10/jeffrey-dahmer-por-que-serie-sobre-serial-killer-americano-causa-tanta-polemica.shtml',
'JeffreyDahmer.jpg',
'Homicidio Qualificado', '80', 1980, TRUE),

('O assassino em serie: John Wayne Gacy',
'John Wayne Gacy, nascido em 1942 nos suburbios de Chicago, teve uma infancia marcada por abusos. Trabalhou em funeraria, casou-se e virou gerente de restaurante, onde comecou seus crimes.',
'John Wayne Gacy ficou conhecido como o "Palhaco Assassino" e, durante os anos 1970, chocou os Estados Unidos com seus crimes. Entre 1972 e 1978, Gacy sequestrou, torturou e assassinou ao menos 33 jovens, a maioria garotos e adolescentes. Muitos de seus crimes foram cometidos em sua propria casa, onde escondia os corpos das vitimas sob o assoalho.

O modus operandi de Gacy consistia em atrair suas vitimas com promessas de trabalho, dinheiro facil ou ate mesmo aproveitando-se de sua imagem amigavel como palhaco em festas infantis. Apos conquistar a confianca dos jovens, Gacy revelava sua verdadeira natureza, cometendo os assassinatos de maneira brutal.

A investigacao que levou a sua prisao comecou apos o desaparecimento de um adolescente, cujo ultimo paradeiro conhecido era justamente um encontro com Gacy. A policia descobriu provas contundentes em sua casa, culminando na prisao e confissao dos crimes. O caso teve enorme repercussao midiática, principalmente pelo contraste entre seu papel de animador de festas e sua crueldade.

Condenado a morte, John Wayne Gacy foi executado em 1994. Sua historia permanece como um dos maiores exemplos de serial killers nos EUA e reforcou o estigma do palhaco como figura assustadora, inspirando livros, filmes e documentarios sobre sua trajetoria macabra.',
'https://brasil.elpais.com/brasil/202019/06/28/actualidad/1561705341_083525.html',
'JohnWayne.jpeg',
'Serial Killers', '80', 1980, TRUE),

('Assassinato de John Lennon',
'Em 8 de dezembro de 1980, o ex-Beatle John Lennon foi assassinado a tiros por Mark David Chapman na entrada do edificio Dakota, em Nova York.',
'No dia 8 de dezembro de 1980, o mundo foi surpreendido por uma noticia devastadora: John Lennon, ex-integrante da lendaria banda The Beatles, foi assassinado a tiros em Nova York. O crime aconteceu na entrada do edificio Dakota, onde Lennon morava com sua esposa, Yoko Ono.
Naquela noite, Lennon voltava para casa apos uma sessao de gravacao. Mark David Chapman, um fa obcecado, ja o aguardava em frente ao predio. Mais cedo naquele dia, Chapman havia conseguido um autografo de Lennon. Quando Lennon retornou ao Dakota por volta das 22h50, Chapman se aproximou e disparou cinco vezes, acertando Lennon quatro vezes nas costas e no ombro. O musico foi rapidamente levado ao Hospital Roosevelt, mas chegou sem vida. Ele tinha apenas 40 anos de idade.
Mark David Chapman era um jovem perturbado do Hawai, que alegou ter sido inspirado pelo livro "O Apanhador no Campo de Centeio", de J.D. Salinger. Segundo ele, vozes em sua cabeca e uma fixacao pelo livro o motivaram a cometer o crime. Apos atirar em Lennon, Chapman permaneceu no local, lendo calmamente o romance enquanto aguardava a chegada da policia, a qual se entregou sem resistir.
A morte de John Lennon provocou uma comoção mundial. Milhares de fas se reuniram em vigilias em frente ao edificio Dakota, no Central Park e em varios lugares do mundo para prestar homenagens ao musico. Lennon era mais do que um ex-Beatle: era simbolo de paz, ativismo e liberdade de expressao. Seu assassinato reacendeu debates sobre o controle de armas nos Estados Unidos e o perigo da obsessao de fas por celebridades.
O legado de John Lennon permanece vivo ate hoje, seja por sua musica, sua mensagem de paz ou pela influencia cultural que exerceu. O crime interrompeu de forma brutal uma das trajetorias mais marcantes da historia da musica, e ate hoje e lembrado como um dos episodios mais tragicos do seculo XX.',
'https://people.com/john-lennon-death-what-to-know-7511226',
'John_Lennon.jpeg',
'Assassinato', '80', 1980, TRUE);

    --decadas de 90
    INSERT INTO news (title, description, text, link, image, category, decade, year, is_featured)
VALUES 
('Chacina de Acari',
'A Chacina de Acari ocorreu no dia 26 de julho de 1990 quando 11 jovens, sendo 7 menores de idade, da favela do Acari, no Rio de Janeiro.',
'A Chacina de Acari ocorreu no dia 26 de julho de 1990 quando 11 jovens, sendo 7 menores de idade, da favela do Acari, no Rio de Janeiro, foram sequestrados de um sitio em Surui, municipio de Mage, onde passavam o dia, por um grupo que se identificava como sendo formado por policiais. Mesmo apos pedir joias e dinheiro em troca da liberacao dos jovens aos familiares, nenhum deles retornou a suas familias e seus corpos nunca foram encontrados. Formada pelas maes das vitimas, a organizacao Maes de Acari foi pioneira na luta contra a violencia da policia no pais, ainda que em 1993, Edmea da Silva Euzebio, lider do grupo, tenha sido assassinada. A Anistia Internacional relatou em 1994 que os sequestradores haviam sido identificados pelo setor de inteligencia da Policia Militar como sendo policiais militares. Em 2010 o caso prescreveu e nenhum acusado foi responsabilizado pela Chacina. Em 2019, foi anunciado que sete acusados de matar Edmea Euzebio vao a juri popular - o que tambem ainda nao aconteceu. A historia das maes dos garotos desaparecidos que buscam justica foi contada no livro "Maes de Acari", do jornalista Carlos Nobre. O caso esta na lista da Superinteressante (2015) de "5 crimes que chocaram o Brasil na decada de 1990". Apos 32 anos, em 1 de julho de 2022, foi sancionada lei que determina que o Governo do Estado do Rio de Janeiro pague indenizacao as maes das vitimas da Chacina de Acari.',
'https://g1.globo.com/jornal-nacional/noticia/202024/12/04/chacina-de-acari-corte-interamericana-responsabiliza-brasil-pelo-desaparecimento-de-11-jovens-no-rio.ghtml',
'ChacinadeAcari.jpeg',
'Chacina', '90', 1990, FALSE),

('Caso da menina Miriam',
'Em 22 de dezembro de 1992, Miriam Brandao, de 5 anos, foi sequestrada pelos irmãos Wellington e William enquanto dormia.',
'Em 22 de dezembro de 1992, Miriam Brandão, de 5 anos, foi sequestrada pelos irmãos Wellington e William enquanto dormia, na casa de seus pais, o homeopata Volney Henrique Brandao e a sociologa Jocelia de Castro, no Bairro Dona Clara, Regiao da Pampulha de Belo Horizonte.Eles se passaram por funcionarios de uma empresa telefonica para entrar no imovel. No dia seguinte, Miriam chorou e chamou pela mae, no cativeiro.Para que a menina parasse de chorar, os irmaos a sufocaram com eter. Em seguida, ela foi estrangulada, esquartejada e queimada. No mesmo dia, os sequestradores fizeram o primeiro contato com a familia para exigir dinheiro pelo resgate. Em 7 de janeiro de 1993, os dois foram presos na casa usada como cativeiro, onde foram encontrados os restos mortais da crianca enterrados no quintal.',
'https://www.em.com.br/app/noticia/gerais/202011/09/02/interna_gerais,248406/assassino-que-chocou-a-capital-em-1992-esta-proximo-da-liberdade.shtml',
'MeninaMiriam.jpeg',
'Homicidio', '90', 1992, FALSE),

('Caso Daniella Perez',
'O assassinato da atriz Daniella Perez em 1992, cometido por um colega de elenco, gerou grande comocao nacional.',
'Filha da autora Gloria Perez e esposa do ator Raul Gazolla, foi vitima de um crime brutal, recebendo 18 punhaladas de tesoura e sem oportunidade de reagir. As investigacoes revelaram como responsaveis o ator Guilherme de Padua, que contracenava com Daniella como seu par romantico na novela, e sua esposa, Paula Thomaz.
Os dois foram condenados pelo assassinato. De acordo com a acusacao, o crime teria sido motivado por inveja e ressentimento, uma vez que o ator buscava insistentemente mais destaque para seu personagem na novela "De Corpo e Alma", escrita pela mae da vitima.
Antes de ser identificado como responsavel pelo crime, no entanto, Guilherme de Padua chegou a oferecer suas condolencias a Gloria Perez e a Raul Gazolla. O casal foi incriminado depois que uma testemunha registrou a placa do veiculo usado no crime.
Horas depois, Guilherme confessou o crime. Segundo as investigacoes, Padua abordou Daniella ao final das gravacoes, obrigando-a a entrar no carro, que foi conduzido por sua esposa ate o local onde o assassinato ocorreu.
Em 1997, Guilherme de Padua foi sentenciado a 19 anos de prisao e Paula Nogueira Thomaz a 18 anos e 6 meses pelo assassinato da atriz, classificado como homicidio qualificado por motivo torpe e sem chance de defesa para a vitima.
Padua foi liberado em outubro de 1999, apos cumprir 6 anos e 9 meses de prisao. Ele se casou novamente em 2006, divorciou-se em 2014 e casou-se pela terceira vez em 2017, ano em que tambem passou a atuar como pastor na Igreja Batista da Lagoinha, em Belo Horizonte.',
'https://www.cnnbrasil.com.br/entretenimento/daniella-perez-assassinato-de-atriz-completa-32-anos-relembre-o-caso/L',
'danielaperez.jpg',
'Feminicidio', '90', 1992, TRUE),

('Caso Maniaco do Parque',
'Francisco de Assis Pereira, o Maniaco do Parque, aterrorizou Sao Paulo no final dos anos 1990.',
'Em 1998, ele estuprou e assassinou pelo menos seis mulheres, e tentou matar outras nove. Seus crimes aconteciam no Parque do Estado, na regiao sul de Sao Paulo. Francisco tinha uma conversa sedutora. Ele dizia para suas vitimas que elas seriam fotografadas para um catalogo no meio da mata no parque do Estado. Para isso tinha de convence-las a fazer longas viagens, de dez a quinze quilometros.
Na entrevista aos peritos, o Francisco diz que viveu aqui uma experiencia marcante de sua infancia, ele ficava escondido observando o abate dos bois no matadouro. Segundo Francisco, e como se depois de receber o golpe, os bois se ajoelhassem para pedir perdao ou clemencia.
A primeira acusacao de tentativa de estupro contra Francisco foi feita em Sao Jose do Rio Preto, quase tres anos antes dele ser preso e ficar claro que se tratava de um assassino em serie de mulheres. Na epoca do crime, nao tinha ainda especificacao de feminicidio. Em sua defesa, Francisco relatou ter sido vitima de abuso de um tio e de uma tia quando crianca. Psiquiatras o descrevem como um homem que descontava sua frustracao nas mulheres. E ele ainda tinha um problema fisico que atrapalhava as relacoes sexuais.
Francisco de Assis Pereira foi condenado a mais de 280 anos de cadeia em 1998. Ele podera pedir progressao de pena em 2028. Isso porque a Legislacao Brasileira impede que alguem fique preso por mais de trinta anos.',
'https://www.cnnbrasil.com.br/nacional/relembere-o-caso-do-maniaco-do-parque-tema-de-filme-que-estreia-hoje/',
'ManiacodoParque.jpeg',
'Assassinato em serie', '90', 1998, TRUE),

('Caso atirador do shopping',
'Em 1998, um atirador abriu fogo em um shopping center no Brasil, deixando vitimas e espalhando panico entre os frequentadores. O caso trouxe a tona discussoes sobre seguranca em locais publicos e o controle de armas.',
'Tres de novembro de 1999. Mateus da Costa Meira entrou no cinema de um shopping, em Sao Paulo, com uma submetralhadora.
Ele reencenou o roteiro de um videogame do qual era fa. Depois de atirar contra o espelho do banheiro, veio para diante da tela e comecou a disparar.
Uma das vitimas achou que era uma performance, parte da exibicao do filme Clube da luta.
O planejamento para o massacre foi desenvolvido ao longo de 7 meses, como relatado pelo criminoso.
Os tiros na sala duraram cerca de 3 minutos. Mateus foi detido por segurancas do local quando parou para recarregar a arma. Ele logo foi preso em flagrante, em sua mochila ainda foram encontradas mais municoes para a arma que usou.
Tres pessoas morreram e quatro ficaram feridos.
Mateus foi condenado a 120 anos de prisao, com cumprimento dos formais 30 anos, que sao o maximo previsto por lei, no Brasil. Nos primeiros anos de cadeia, ele foi transferido diversas vezes, e continuava com o mesmo comportamento agressivo com os presos.
Em 8 de maio de 2009, Mateus tentou assassinar um colega de cela usando uma tesoura.
So em 2011, com mais de uma decada de atraso, foi considerado inimputavel por doenca mental. Entao, nao poderia responder criminalmente pelo ataque. Hoje esta em um hospital de custodia na Bahia.',
'https://www.cnnbrasil.com.br/nacional/atirador-do-shopping-morumbi-em-sp-deixa-prisao-apos-25-anos-entenda/',
'AtiradordoShopping.jpeg',
'Homicidio', '90', 1998, FALSE);


    -- INSERTS de noticias pesquisadas 00

INSERT INTO news (title, description, text, link, image, category, decade, year, is_featured)
VALUES

('Caso Richthofen', 'Assassinato brutal dos pais de Suzane von Richthofen que chocou o pais em 2002.', 'O assassinato de Manfred e Marisia von Richthofen, pais de Suzane von Richthofen, ocorreu na madrugada de 31 de outubro de 2002, na casa da familia em Sao Paulo. O crime, cometido com extrema brutalidade, chocou o pais nao apenas pela violencia, mas pelo perfil social dos envolvidos. Suzane, entao com 18 anos, planejou e executou o assassinato com a ajuda de seu namorado, Daniel Cravinhos, e do irmao dele, Cristian Cravinhos.

Suzane vinha enfrentando resistencia dos pais em relacao ao seu namoro com Daniel. Para se livrar da interferencia e obter acesso a heranca familiar, estimada em cerca de 11 milhoes de reais, ela arquitetou o crime ao longo de semanas. No dia da execucao, levou o irmao, Andreas, de 15 anos, para um cybercafe, garantindo que ele nao testemunhasse o ato. Enquanto os pais dormiam, Daniel e Cristian os atacaram com barras de ferro, desferindo multiplos golpes. Manfred morreu instantaneamente, enquanto Marisia tentou se defender, mas tambem foi morta.

Para simular um assalto, os criminosos espalharam documentos e levaram dinheiro. Apos o assassinato, Suzane passou a noite com Daniel em um motel e retornou pela manha com os irmaos Cravinhos para "descobrir" o crime junto a policia. No entanto, sua frieza e comportamento levantaram suspeitas. Em poucos dias, os tres confessaram e foram condenados em 2006 por homicidio triplamente qualificado. Suzane e Daniel receberam 39 anos e 6 meses de prisao, enquanto Cristian foi condenado a 38 anos e 6 meses.

O caso teve grande repercussao, inspirando livros, documentarios e filmes, como A Menina que Matou os Pais e O Menino que Matou Meus Pais. Em 2023, Suzane obteve liberdade condicional apos cumprir parte da pena, enquanto Cristian voltou a ser preso em 2018 por porte de armas e suborno. O crime gerou debates sobre valores familiares, justica criminal e reintegracao de condenados a sociedade.', 'https://www.estadao.com.br/brasil/suzane-von-richthofen-relembre-como-a-policia-desvendou-o-caso-e-como-estao-os-acusados-hoje-nprm/', 'Richthofen.jpg', 'Crime hediondo', '2000', 2002, TRUE),

('Caso Friedenbach-Caffe', 'Crime barbaro contra casal de adolescentes que reacendeu o debate sobre maioridade penal no Brasil.', 'O assassinato de Liana Friedenbach e Felipe Caffe em novembro de 2003 foi um dos crimes mais chocantes da historia brasileira, mobilizando a opiniao publica e reacendendo debates sobre seguranca e legislacao penal. O casal, que namorava ha cerca de dois meses, decidiu viajar para acampar na zona rural de Embu-Guacu, Sao Paulo. Para isso, Liana mentiu para os pais, dizendo que participaria de uma excursao para Ilhabela, enquanto Felipe omitiu que estaria apenas com ela. No dia 31 de outubro, partiram para o sitio abandonado onde montaram acampamento.

No dia seguinte, ao caminharem pela regiao, cruzaram com Roberto Aparecido Alves Cardoso, conhecido como Champinha, de 16 anos, e Paulo Cesar da Silva Marques, o Pernambuco, de 32 anos. Os criminosos perceberam que o casal estava desprotegido e decidiram aborda-los. Na tarde de 1 de novembro, invadiram a barraca, armados, e os levaram para uma area isolada na mata. Mantidos em cativeiro, Felipe foi assassinado na manha do dia 2 de novembro com um tiro na nuca por Pernambuco, enquanto Liana foi violentada repetidamente por Champinha e outros cumplices por dias, antes de ser brutalmente morta.

O desaparecimento dos jovens mobilizou familiares e autoridades. O pai de Liana, Ari Friedenbach, intensificou as buscas com helicopteros e panfletagem. A policia identificou Champinha como suspeito e, apos sua captura, ele revelou os locais onde os corpos estavam. Felipe havia sido executado com um unico tiro, enquanto Liana apresentava multiplos ferimentos por arma branca.

Os criminosos foram julgados e condenados. Pernambuco recebeu pena de 110 anos de prisao, enquanto Antonio Caetano da Silva foi sentenciado a 124 anos. Agnaldo Pires recebeu 47 anos, e Antonio Matias de Barros foi condenado a seis anos. Champinha, por ser menor de idade, cumpriu tres anos na Fundacao CASA e, devido a avaliacoes psiquiatricas que indicaram transtorno de personalidade antissocial, foi transferido para uma unidade psiquiatrica onde permanece ate hoje.

O caso gerou forte impacto social e reacendeu debates sobre a maioridade penal no Brasil. Ari Friedenbach tornou-se um defensor de mudancas na legislacao para endurecer penas e garantir maior protecao aos jovens. A tragedia evidenciou fragilidades do sistema de seguranca e justica, impulsionando discussoes sobre reforma penal e medidas preventivas contra crimes violentos.', 'https://projetocolabora.com.br/ods16/caso-champinha-crime-perverso-fim-aventura-adolescentes-apaixonados/', 'Friedenbach.jpg', 'Crime hediondo', '2000', 2003, FALSE),

('Caso Madeleine McCann', 'Desaparecimento de menina britanica em Portugal que virou um dos maiores misterios da decada.', 'O desaparecimento de Madeleine Beth McCann, uma menina britanica de 3 anos, ocorreu em 3 de maio de 2007, no resort Praia da Luz, Algarve, Portugal. O caso teve repercussao global imediata e, ate hoje, permanece cercado de misterio, investigacoes e inumeras teorias.

Madeleine estava de ferias com seus pais, Kate e Gerry McCann, medicos britanicos, e seus irmaos gemeos. A familia se hospedava no Ocean Club, e na noite do desaparecimento, os pais sairam para jantar com amigos em um restaurante proximo, deixando os filhos dormindo no apartamento. Eles faziam verificacoes periodicas, mas, por volta das 22h, Kate McCann descobriu que Madeleine havia sumido, com a janela aberta. O alerta foi dado, e buscas intensas comecaram imediatamente.

A policia portuguesa foi criticada por falhas na conducao inicial do caso, como o isolamento inadequado da cena do crime e a demora na coleta de provas. Ao longo das semanas, varias pistas surgiram, incluindo relatos de um homem ou uma mulher carregando uma crianca naquela noite, mas nenhuma levou ao paradeiro de Madeleine.

Em setembro de 2007, a policia portuguesa declarou os proprios pais como suspeitos, alegando que Madeleine teria morrido acidentalmente e sua morte foi encoberta. No entanto, sem provas conclusivas, o caso foi arquivado em julho de 2008, e o status de suspeitos dos McCann foi removido.

Em 2011, a Scotland Yard reabriu o caso com a Operacao Grange, investigando novas pistas. Em junho de 2020, as autoridades alemas apontaram um novo suspeito: Christian Bruckner, um criminoso sexual alemao que estava em Portugal na epoca do desaparecimento. Em 2022, a policia portuguesa o declarou arguido, mas ele continua negando envolvimento, e nao ha provas definitivas.

O caso ganhou enorme cobertura midiaticas e apoio de celebridades e lideres mundiais, como o Papa Bento XVI e o primeiro-ministro britanico Gordon Brown. A campanha "Find Madeleine" arrecadou milhoes em busca de respostas. Em 2019, a Netflix lancou o documentario The Disappearance of Madeleine McCann.

Ate hoje, Madeleine continua desaparecida, tornando esse caso um dos maiores misterios criminais da historia recente. Seus pais seguem na luta por respostas, mantendo viva a esperanca de reencontra-la.', 'https://www.cnnbrasil.com.br/tudo-sobre/caso-madeleine-mccann/', 'MadeleineMcCann.jpeg', 'Crime de Sequestro', '2000', 2007, FALSE),

('Caso Onibus 174', 'Sequestro de onibus no Rio transmitido ao vivo, que terminou em tragedia e criticas a policia.', 'O sequestro do onibus 174, ocorrido em 12 de junho de 2000 no Rio de Janeiro, foi um dos episodios mais marcantes da cronica policial brasileira. O criminoso Sandro Barbosa do Nascimento, sobrevivente da Chacina da Candelaria, manteve refens dentro do veiculo por quase cinco horas, em um evento transmitido ao vivo para todo o pais.

Sandro, entao com 21 anos, entrou no onibus da linha 174 no bairro Jardim Botanico, armado com um revolver calibre 38. Pouco depois, um dos passageiros conseguiu alertar uma viatura policial, que interceptou o veiculo. O motorista e alguns passageiros conseguiram escapar, mas dez pessoas permaneceram como refens. Durante o sequestro, Sandro obrigou uma das vitimas a escrever frases ameacadoras nas janelas do onibus, como "Ele vai matar geral as seis horas".

A operacao policial foi caotica e transmitida ao vivo pelas principais emissoras. A presenca da imprensa intensificou a tensao, e Sandro usou as cameras para exibir suas ameacas. Apos horas de negociacao, ele desceu do onibus usando a refem Geisa Firmo Goncalves, uma professora de 21 anos, como escudo humano. No momento da acao, um policial do BOPE disparou, mas acertou Geisa, que foi baleada novamente por Sandro e morreu no local.

O sequestrador foi rendido e levado para uma viatura policial, onde morreu por asfixia, supostamente sufocado pelos agentes. O caso gerou grande repercussao e criticas a atuacao da policia, que falhou na contencao do criminoso e na protecao dos refens.

O episodio inspirou o documentario Onibus 174, dirigido por Jose Padilha, que explora a infancia de Sandro e as condicoes sociais que o levaram ao crime. O caso tambem levantou debates sobre violencia urbana, desigualdade social e a abordagem policial em situacoes de crise.', 'https://oglobo.globo.com/blogs/blog-do-acervo/post/202024/03/sequestro-do-onibus-174-horas-de-tensao-com-uma-tragedia-no-final.ghtml', 'Onibus174.jpeg', 'Crime Hediondo', '2000', 2000, FALSE),

('Caso Isabella Nardoni', 'Assassinato de menina de cinco anos em Sao Paulo, com grande comoocao nacional.', 'O assassinato de Isabella de Oliveira Nardoni, ocorrido em 29 de marco de 2008, foi um dos crimes mais chocantes da historia brasileira. A menina de cinco anos foi jogada do sexto andar de um predio na Vila Guilherme, Sao Paulo, e seu caso comoveu o pais pela brutalidade e pela suspeita de envolvimento de pessoas proximas.

Na noite do crime, Isabella estava com o pai, Alexandre Nardoni, e a madrasta, Anna Carolina Jatoba. Segundo o casal, ao chegarem ao apartamento, alguem teria invadido o imovel e jogado a crianca pela janela. No entanto, as investigacoes apontaram um cenario completamente diferente. Exames periciais indicaram que Isabella havia sido agredida antes da queda, com sinais de asfixia e lesoes compativeis com violencia dentro do apartamento.

A Policia Civil iniciou uma investigacao minuciosa, e em poucos dias, Alexandre e Anna Carolina se tornaram os principais suspeitos. A pericia detectou vestigios de sangue no apartamento e no carro da familia, alem de marcas de tentativa de limpeza da cena do crime. O laudo indicou que Isabella foi estrangulada antes de ser arremessada pela janela, tornando impossivel a tese de invasao por terceiros.

O julgamento, realizado em 2010, teve grande repercussao nacional. A defesa alegou que nao havia provas diretas contra o casal, mas a promotoria apresentou um conjunto robusto de evidencias periciais e testemunhais. No fim, Alexandre Nardoni foi condenado a 31 anos de prisao por homicidio triplamente qualificado, e Anna Carolina Jatoba recebeu 26 anos pelo mesmo crime.

O caso gerou uma onda de comoocao e revolta no Brasil, levando a debates sobre violencia infantil e a eficacia da justica. Isabella tornou-se simbolo da luta por protecao as criancas, e sua historia continua sendo lembrada como um dos crimes mais impactantes do pais.

Ate hoje, a tragedia de Isabella Nardoni marca a memoria coletiva brasileira, evidenciando a importancia da justica e do combate a violencia domestica.', 'https://g1.globo.com/tudo-sobre/isabella-nardoni/', 'nardoni.jpg', 'Crime Hediondo', '2000', 2008, FALSE);

-- INSERTS de notícias pesquisadas 10

INSERT INTO news (title, description, text, link, image, category, decade, year, is_featured)
VALUES

('Caso Eliza Samudio', 'Feminicidio ligado ao goleiro Bruno que expos a violencia contra mulheres no meio esportivo.', 'O assassinato de Eliza Samudio, ocorrido em junho de 2010, gerou grande repercussao nacional, especialmente pelo envolvimento do goleiro Bruno Fernandes, entao jogador do Flamengo. O crime, marcado pela brutalidade e ocultacao de provas, levantou debates sobre violencia contra a mulher e impunidade.

Eliza e Bruno tiveram um relacionamento conturbado, do qual nasceu um filho. Em 2009, ela entrou com uma acao judicial para reconhecimento da paternidade, o que gerou conflitos. Em junho de 2010, ela desapareceu, e as investigacoes apontaram que Bruno ordenou seu sequestro no Rio de Janeiro. Eliza foi levada para um sitio em Minas Gerais, onde foi agredida e morta. Marcos Aparecido dos Santos, o Bola, um ex-policial militar, teria sido responsavel pela execucao e ocultacao do cadaver, que nunca foi encontrado.

A Policia Civil de Minas Gerais conduziu a investigacao, reunindo testemunhos que indicavam Bruno como mandante do crime. Em julho de 2010, ele foi preso e admitiu envolvimento indireto. O julgamento aconteceu em 2013, quando Bruno foi condenado a 22 anos e 3 meses de prisao por homicidio triplamente qualificado, sequestro e ocultacao de cadaver. Bola recebeu pena de 22 anos, e outros cumplices foram condenados a penas menores.

O caso teve forte impacto social, gerando debates sobre violencia de genero e poder de figuras publicas. Bruno tentou retomar a carreira no futebol apos a prisao, provocando indignacao e protestos da sociedade. Sua possivel reintegracao levantou questoes sobre a responsabilidade de clubes e patrocinadores diante de crimes violentos.

Ate hoje, o assassinato de Eliza Samudio permanece como um dos crimes mais marcantes do pais, evidenciando a necessidade de politicas mais rigidas contra o feminicidio e de maior protecao as vitimas de violencia domestica.', 'https://g1.globo.com/tudo-sobre/eliza-samudio/', 'ElizaSamudio.jpeg', 'Crime Hediondo', '2010', 2010, TRUE),

('Caso Luka Magnotta', 'Assassino canadense que filmou e divulgou crime brutal na internet, gerando comocao mundial.', 'O assassinato de Jun Lin, um estudante chines de 33 anos, em maio de 2012, foi um dos crimes mais brutais e midiaticos da decada. Com requintes de crueldade e exibicao publica, o caso expos questoes sobre psicopatia, narcisismo e o impacto das redes sociais em crimes violentos.

Luka Rocco Magnotta, um ex-modelo e ator porno canadense, era obcecado por atencao e fama. Antes do crime, ele ja havia publicado videos matando gatos, o que chamou a atencao de internautas e ativistas. Em 2012, Magnotta assassinou e esquartejou Jun Lin em Montreal, filmando toda a acao e divulgando o video na internet com o titulo 1 Lunatic 1 Ice Pick. Como se nao bastasse, ele enviou partes do corpo da vitima para escolas e sedes de partidos politicos no Canada.

Apos cometer o crime, Magnotta fugiu para a Europa, dando inicio a uma cacada internacional. Internautas e autoridades rastrearam seus movimentos, e ele foi encontrado dias depois em Berlim, Alemanha, enquanto acessava sites de noticias sobre si mesmo em um cyber cafe. Sua prisao foi rapida e atraiu enorme atencao midiática.

No julgamento, ocorrido em 2014, a defesa tentou alegar insanidade, mas o juri rejeitou essa tese diante da premeditacao e crueldade do crime. Magnotta foi condenado a prisao perpetua, com possibilidade de liberdade condicional apos 25 anos.

O caso ganhou ainda mais notoriedade com o lancamento do documentario da Netflix Dont Fk With Cats, que detalha como internautas ajudaram na captura do criminoso. Alem da investigacao, o documentario levanta debates sobre os limites da exibicao de crimes na internet e o papel das redes sociais na construcao da identidade de psicopatas.

O assassinato de Jun Lin continua sendo lembrado como um dos mais macabros da era digital, evidenciando os perigos da busca desenfreada por atencao e notoriedade online.', 'https://noticias.uol.com.br/ultimas-noticias/efe/202017/06/21/canibal-de-montreal-se-casara-com-outro-preso-no-final-do-mes.htm', 'LukaMagnotta.jpeg', 'Crime Hediondo', '2010', 2012, FALSE),

('Caso Chris Watts', 'Homem mata esposa gravida e filhas pequenas nos EUA em um dos crimes mais chocantes da decada.', 'O assassinato de Shanann Watts, gravida de 15 semanas, e suas filhas Bella (4 anos) e Celeste (3 anos), ocorrido em agosto de 2018, foi um dos crimes mais chocantes dos Estados Unidos. A brutalidade do ato e a frieza do autor, Chris Watts, marido e pai das vitimas, causaram enorme repercussao mundial. O contraste entre a imagem publica da familia nas redes sociais e a realidade sombria por tras do crime levantou questoes sobre relacionamentos abusivos e a ilusao da vida perfeita online.

Na manha de 13 de agosto de 2018, Shanann desapareceu junto com suas filhas em Frederick, Colorado. Inicialmente, Chris Watts se apresentou como um marido preocupado, pedindo ajuda para encontra-las. No entanto, as investigacoes revelaram inconsistencias em seu depoimento. Um teste de poligrafo apontou suas mentiras, e, pouco depois, ele confessou ter estrangulado sua esposa durante uma discussao e, em seguida, matado suas filhas. Ele levou os corpos ao seu local de trabalho, um campo de petroleo, onde enterrou Shanann em uma cova rasa e colocou Bella e Celeste dentro de tanques de oleo.

A motivacao para o crime foi revelada durante as investigacoes. Chris mantinha um caso extraconjugal e queria comecar uma nova vida com a amante. Inicialmente, alegou que matou Shanann em um acesso de raiva, mas as provas indicavam premeditacao. Em novembro de 2018, Chris foi condenado a cinco prisoes perpetuas sem possibilidade de liberdade condicional, alem de 84 anos adicionais por ocultacao de cadaver e interrupcao de gravidez.

O caso gerou grande repercussao e virou documentario da Netflix (American Murder: The Family Next Door), que detalhou a vida da familia atraves de videos e mensagens. A tragedia levantou debates sobre violencia domestica, feminicidio e a influencia das redes sociais na construcao de imagens irreais.

A historia de Chris Watts continua sendo lembrada como um alerta sobre os perigos de relacoes abusivas e sobre como uma fachada de felicidade pode esconder segredos sombrios.', 'https://g1.globo.com/mundo/noticia/202019/03/07/homem-que-matou-esposa-gravida-e-duas-filhas-nos-eua-revela-pela-primeira-vez-como-cometeu-crime.ghtml', 'ChrisWhatts.jpeg', 'Crime Hediondo', '2010', 2018, TRUE),

('Caso Stephen Paddock', 'Maior ataque a tiros da historia dos EUA, com 60 mortos durante festival em 2017.', 'O Massacre de Las Vegas, ocorrido em 1 de outubro de 2017, foi o ataque a tiros mais mortal da historia dos Estados Unidos. Stephen Paddock, um contador aposentado de 64 anos, abriu fogo contra uma multidao durante o festival de musica country Route 91 Harvest, deixando 60 mortos e mais de 800 feridos. O ataque chocou o mundo pela brutalidade e pela falta de uma motivacao clara.

Paddock se hospedou no 32 andar do Mandalay Bay Hotel, em Las Vegas, e levou consigo um arsenal de armas – incluindo rifles semiautomaticos adaptados com bump stocks, dispositivos que aumentavam sua cadencia de tiro. Por volta das 22h05, ele quebrou as janelas do quarto e disparou contra mais de 20 mil pessoas que assistiam ao show do cantor Jason Aldean. O tiroteio durou aproximadamente 10 minutos e provocou caos na multidao, com pessoas sendo pisoteadas durante a fuga.

As equipes de seguranca levaram quase uma hora para encontrar a localizacao exata do atirador. Antes da abordagem, Paddock se suicidou, encerrando o ataque sem deixar explicacoes. No quarto, a policia encontrou 23 armas de fogo e cameras instaladas pelo criminoso para monitorar os corredores do hotel. Investigacoes do FBI nao conseguiram identificar uma motivacao clara para o crime. Paddock nao possuia antecedentes criminais, envolvimento politico ou conexoes com grupos extremistas.

O massacre reacendeu debates sobre o controle de armas nos EUA, resultando na proibicao dos bump stocks pelo governo americano. Tambem houve mudancas nos protocolos de seguranca em grandes eventos e hoteis, visando evitar novas tragedias.

Ate hoje, o Massacre de Las Vegas e lembrado como um dos episodios mais violentos da historia moderna dos Estados Unidos, deixando um legado de dor e questionamentos sobre a facilidade de acesso a armas de alto poder destrutivo.', 'https://g1.globo.com/mundo/noticia/veja-quem-e-stephen-paddock-o-atirador-de-las-vegas.ghtml', 'StephenPaddock.jpeg', 'Crime Hediondo', '2010', 2017, FALSE);

    --decadas de 2020
INSERT INTO news (title, description, text, link, image, category, decade, year, is_featured)
VALUES 
('Trapezista argentina e assassinada em Buzios',
 'Florencia Aranguren foi morta a facadas enquanto caminhava com seu cachorro em Buzios, RJ, em dezembro de 2023.',
 'A trapezista argentina Florencia Aranguren foi brutalmente assassinada a facadas durante um passeio com seu cachorro em uma trilha na cidade de Buzios, no Rio de Janeiro. O corpo foi encontrado com o cao ao seu lado. Carlos Jose, preso em flagrante, foi condenado a 33 anos de prisao.',
 'https://www.condorcontabilidade.com.br/nb2/rj/regiao-dos-lagos/noticia/202025/04/03/julgamento-marcado-acusado-de-matar-trapezista-argentina-em-buzios-enfrenta-o-tribunal-do-juri-no-dia-9-de-abril.ghtml',
 'Trapezistaargentina.jpeg',
 'Homicidio', '2020s', 2023, FALSE),

('Pai joga filho de ponte em Sao Gabriel (RS)',
 'Em marco de 2025, um pai arremessou o filho de cinco anos de uma ponte em um ato de vinganca contra a ex-companheira.',
 'O crime chocou a cidade de Sao Gabriel, no Rio Grande do Sul. Um homem jogou o proprio filho, de apenas cinco anos, de uma ponte como forma de vinganca contra a mae da crianca. Ele foi preso e confessou o homicidio.',
 'https://www.cnnbrasil.com.br/wp-content/uploads/sites/12/202025/03/cantor-afogado-pe-2-2.jpg?w=1115',
 'MeninoArremessado.jpeg',
 'Homicidio', '2020s', 2025, TRUE),

('Motorista de app tenta estuprar passageira em SP',
 'Um motorista de aplicativo foi preso apos tentar estuprar e roubar uma passageira de 21 anos na zona norte de Sao Paulo.',
 'O crime ocorreu no bairro da Casa Verde, zona norte de Sao Paulo, em marco de 2025. Um motorista de aplicativo tentou estuprar e roubar uma jovem de 21 anos. A vitima conseguiu escapar e acionou a policia. O agressor foi detido em flagrante.',
 'https://s2-g1.glbimg.com/JTYtBLWhlDV-pnM6l5rMDQd31mc=/1280x0/filters:format(jpeg)/https://thumbor.globoi.com/unsafe/fit-in/1280x72020/s03.video.glbimg.com/deo/vi/54/13/13491354',
 'MotoristadeApp.jpeg',
 'Violencia Sexual', '2020s', 2025, FALSE),

('Jovem e morta e concretada em BH',
 'Clara Maria, de 21 anos, foi encontrada morta e concretada em uma casa de Belo Horizonte em marco de 2025.',
 'Clara Maria, de 21 anos, desapareceu em Belo Horizonte e foi encontrada morta, com o corpo concretado em uma residencia. Os suspeitos, Thiago e Pimentel, foram presos apos confessarem o crime, que causou grande repercussao na capital mineira.',
 'https://www.cnnbrasil.com.br/wp-content/uploads/sites/12/202025/03/Clara-Maria.jpg?w=880',
 'ClaraMaria.jpeg',
 'Homicidio', '2020s', 2025, TRUE),

('Cantor e encontrado morto em rio de PE',
 'Em fevereiro de 2025, um cantor foi achado sem vida em um rio de Pernambuco. A policia apura as causas.',
 'O corpo de um cantor foi encontrado em um rio no interior de Pernambuco. Embora a morte tenha sido inicialmente tratada como afogamento acidental, a policia investiga se houve envolvimento de terceiros. O caso segue em apuracao.',
 'https://www.cnnbrasil.com.br/wp-content/uploads/sites/12/202025/03/cantor-afogado-pe-2-2.jpg?w=1115',
 'CantorAfogado.jpeg',
 'Morte Suspeita', '2020s', 2025, FALSE),

('Filho mata pai com tesoura em SC',
 'Em fevereiro de 2025, um jovem matou o pai com 22 golpes de tesoura em Sao Joao Batista, SC.',
 'Um homem de 23 anos foi preso apos matar o proprio pai, de 47, com diversos golpes de tesoura em Sao Joao Batista, Santa Catarina. A vitima, que era alcoolatra, foi encontrada com 22 perfuracoes. O filho se entregou a policia e confessou o crime.',
 'https://static.ndmais.com.br/202025/02/identificado-homem-morto-por-filho-a-tesouradas-sao-joao-batista-grande-florianopolis-elvis-marcos-da-silva-800x467.jpg',
 'Filhomatapaialcoolatra.jpeg',
 'Homicidio', '2020s', 2025, FALSE);

INSERT INTO podcasts (title, description, link, image, category, is_featured)
VALUES
('Crime Junkie', 'Podcast semanal dedicado a cobrir casos de crimes reais.', 'https://open.spotify.com/show/3DgfoleqaW61T2amZQKINx', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTC3zmZm2qANnrB1IJ3qbjpzcfJmfVYrYUaLQ&s', 'impactante', TRUE),
('Crimecast', 'Podcast sobre crimes reais, abordando historias conhecidas no Brasil e no mundo.', 'https://open.spotify.com/show/07MoJXc7KpasBvDSJVOMw8', 'https://cdn-images.dzcdn.net/images/talk/08fcb47cb1970a881f34258fc451b553/1900x1900-000000-80-0-0.jpg', 'investigacao', TRUE),
('Real Crime', 'Documentarios completos sobre crimes, gangsters, serial killers e as pessoas mais infames da historia.', 'https://open.spotify.com/show/0JLjqhHBRN8qMTGKikm97B', 'https://m.media-amazon.com/images/I/91O+l7tjmdL._AC_UF894,1000_QL80_.jpg', 'casos reais', FALSE),
('Profissionais criminais descrevendo crimes', 'Discussao sobre crimes reais no Brasil com especialistas.', 'https://www.youtube.com/watch?v=SCYsS6VgxPY', 'https://i.ytimg.com/vi/u6iCbtzIGM4/maxresdefault.jpg', 'famoso', TRUE),
('Crimes Brasileiros', 'Podcast sobre crimes brasileiros famosos.', 'https://www.youtube.com/watch?v=aPEYYaR8hVY', 'https://i.ytimg.com/vi/aPEYYaR8hVY/maxresdefault.jpg', 'impactante', FALSE),
('Telma Rocha', '2 horas ouvindo crimes reais contados pela fotografa Telma Rocha', 'https://www.youtube.com/live/PPWehNBYq_M?feature=shared', 'thelma.png', 'famoso', FALSE),
('Morte do TikTok', 'Ele foi pego pelo TikTok! Bruno Eustaquio ligou para a policia depois de encontrar a mae, Marcia Lanzane, morta. Porem, durante as investigacoes, os agentes descobriram uma dinamica chocante: a mulher havia sido assassinada pelo proprio filho, que, depois de cometer o crime, foi para a sala e ficou assistindo televisao.', 'https://youtu.be/XKJ7Zzmifig?feature=shared', 'https://i.ytimg.com/vi/1M6QBfFAq7I/maxresdefault.jpg', 'impactante', TRUE),
('Chacina da Candelaria', 'Em 1993, oito criancas e adolescentes em situacao de rua foram mortos brutalmente em frente a Igreja da Candelaria, no Rio de Janeiro, em um crime que chocou o pais e expos violencia policial.', 'https://www.youtube.com/watch?v=zf7Er2Nthto', 'chacinaC.png', 'crimes antigos', TRUE),
('Caso Suzane von Richthofen', 'O crime que chocou o Brasil: Suzane e os irmãos Cravinhos mataram os pais em 2002.', 'https://www.youtube.com/watch?v=XSBnl-3q8ks', 'susane.png', 'famoso', FALSE),
('Caso Eloá Cristina', 'O sequestro e assassinato da jovem Eloá Cristina em 2008 por seu ex-namorado foi transmitido ao vivo pela mídia.', 'https://www.youtube.com/watch?v=4dDfBT3kPqc', 'eloapod.png', 'casos reais', FALSE),
('Caso Pedrinho', 'O caso do menino Pedrinho, sequestrado em 2003 e reencontrado em 2019.', 'https://www.youtube.com/watch?v=HtcNWv_4zOE', 'pedrinho.png', 'investigacao', TRUE),
('Caso Isabella Nardoni', 'O assassinato de Isabella Nardoni, ocorrido em 2008, foi um dos crimes mais chocantes da história brasileira.', 'https://www.youtube.com/watch?v=PUeiy25UTH8', 'nardoni.png', 'investigacao', TRUE),
('Caso Champinha', 'O caso Champinha, envolvendo o assassinato brutal de Liana Friedenbach e Felipe Caffé em 2003.', 'https://www.youtube.com/watch?v=MUtQtyKjwnE', 'champinha.png', 'casos reais', TRUE),
('Caso Madeleine McCann', 'O desaparecimento de Madeleine McCann, uma menina britânica de 3 anos, ocorreu em 3 de maio de 2007, no resort Praia da Luz, Algarve, Portugal.', 'https://www.youtube.com/watch?v=5GBiggcsMyk', 'mc.png', 'casos reais', FALSE),
('Caso Onibus 174', 'O sequestro do ônibus 174, ocorrido em 12 de junho de 2000 no Rio de Janeiro, foi um dos episódios mais marcantes da crônica policial brasileira.', 'https://www.youtube.com/watch?v=FP8RBilap6Q', '174.png', 'investigacao', FALSE),
('Caso Chris Watts', 'O assassinato de Shanann Watts, grávida de 15 semanas, e suas filhas Bella (4 anos) e Celeste (3 anos), ocorrido em agosto de 2018, foi um dos crimes mais chocantes dos Estados Unidos.', 'https://www.youtube.com/watch?v=F7rA9ksL_eQ', 'chiris.png', 'investigacao', FALSE);

INSERT INTO podcasts (title, description, link, image, category, is_featured)
VALUES
('Doutora Luiza', 'Ela atuou em casos que pararam o Brasil! Luisa Muchon e uma experiente advogada criminalista, que ja trabalhou com casos de grande repercussao e conheceu de perto figuras emblematica do pais. Alem de ter sido advogada do casal Nardoni, foi a ultima pessoa a conversar com Farah Jorge Farah e representou diversos nomes associados a Operacao Lava Jato.', 'https://youtu.be/NhK_MjWjxsU?feature=shared', 'doutoraLuiza.png', 'famoso', TRUE),
('Caso Vitoria Regina - Detalhes da investigacao', 'Confira minha entrevista com o advogado da familia de Vitoria Regina de Sousa, morta entre o final de fevereiro e comeco de marco de 202025, em circunstancias, no minimo, estranhas. A policia colocou o vizinho da familia, Maicol Sales do Santos, como unico suspeito e autor de tudo.', 'https://youtu.be/-W78mbchJbw?feature=shared', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSYW7tHdUdbmvozHaVKUCb5hQcvrdzn4Ma8bQ&s', 'investigacao', TRUE),
('Crimes Reais: Ullisses Campbell e Beto Ribeiro', 'ULLISSES CAMPBELL e escritor, e BETO RIBEIRO e diretor e roteirista. Eles vao contar historias e destrinchar crimes reais, como o caso da Suzane Von Richthofen. Agora que Suzane foi solta da cadeia, o Vilela ja reforcou a seguranca do porao, ja que ele tem idade pra ser pai dela.', 'https://www.youtube.com/live/zU8Ahy3zL1c?feature=shared', 'podcast2.png', 'casos reais', TRUE),
('Crimes Reais: O caso mais pesado', 'TELMA ROCHA e fotografa pericial, e EDU TACHLITSKY e LEANDRO LOPES sao peritos criminais do Departamento de Homicidios e Protecao a Pessoa de Sao Paulo. Eles vao esclarecer muitas duvidas sobre os bastidores dos crimes mais conhecidos e tambem os mais curiosos. O Vilela que seu cuide, pois ele esta sempre em minoria no porao.', 'https://youtu.be/7x0UoLX4kmQ?feature=shared', 'https://i.ytimg.com/vi/7x0UoLX4kmQ/maxresdefault.jpg', 'crimes antigos', TRUE),
('Crimes Reais: Ricardo Salada, Telma Rocha e Rafael Heck', 'RICARDO SALADA, TELMA ROCHA E RAFAEL HECK sao peritos criminais. Eles trabalham no DHPP (Departamento de Homicidios e de Protecao a Pessoa) do estado de SP e vao bater um papo sobre crimes reais. Ja o Vilela presenciou varios crimes do passado.', 'https://www.youtube.com/live/17PwIYnL28Y?feature=shared', 'https://i.ytimg.com/vi/17PwIYnL28Y/maxresdefault.jpg', 'crimes antigos', TRUE),
('Telma Rocha e Andre Davila', 'Neste podcast Telma Rocha e Andre Davila abordam questoes cruciais relacionadas ao crime, a seguranca publica e aos desafios enfrentados pela sociedade contemporanea.', 'https://youtu.be/azFRrtdUnvE?feature=shared', 'https://i.ytimg.com/vi/azFRrtdUnvE/sddefault.jpg?v=6362b027', 'crimes antigos', TRUE),
('Crimes Reais: Ricardo Ventura e Ricardo Salada', 'RICARDO VENTURA e psicanalista e RICARDO SALADA e perito criminal. Hoje descobriremos mutas tecnicas de como pegar o mentiroso e o bandido com as calcas na mao. A Mari deveria assistir a essa live, pois e obvio que o Vilela vai pisar na bola.', 'https://www.youtube.com/live/rMT78xVz_Qc?feature=shared', 'https://i.ytimg.com/vi/rMT78xVz_Qc/maxresdefault.jpg', 'crimes antigos', TRUE),
('Caso Eloa Cristina - Sequestro e feminicidio ao vivo em SP', 'O sequestro e assassinato da jovem Eloa Cristina em 202008 por seu ex-namorado foi transmitido ao vivo pela midia, levantando debates sobre violencia contra a mulher e atuacao policial.', 'https://www.youtube.com/watch?v=wBJw-VEatrE', 'elo.png', 'famoso', TRUE),
('Caso Pedrinho - Sequestro e reencontro apos 16 anos em Brasilia', 'Pedrinho foi sequestrado ainda bebe e reencontrou sua familia biologica somente apos 16 anos. Este caso comoveu o Brasil e revelou complexidades juridicas e emocionais.', 'https://www.youtube.com/watch?v=HtcNWv_4zOE', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRPiXrPOseKza-Dz9zIrPYk4yKWrApRkIT0jg&s', 'casos reais', TRUE);

INSERT INTO podcasts (title, description, link, image, category, is_featured)
VALUES
('Crimes Reais: Ju Cassini e Beto',
'JU CASSINI e YouTuber e BETO RIBEIRO e diretor e roteirista. Eles vao bater um papo sobre crimes reais com historias assustadoras, bizarras e misteriosas. O Vilela ja se preparou e comprou mais fraldas geriatricas pra trocar nessa live.',
'https://www.youtube.com/live/n9YXRqNtows?feature=shared',
'https://i.ytimg.com/vi/n9YXRqNtows/maxresdefault.jpg',
'famoso', TRUE),

('Caso Familia Goncalves',
'Em uma noite comum de janeiro de 20202020, em Sao Bernardo do Campo, no Grande ABC de Sao Paulo, Flaviana Goncalves chegava em casa do trabalho quando encontrou sua familia rendida por tres ladroes. O Romoyuki, o marido, Juan, o filho adolescente, Anaflavia, a filha e a namorada de sua filha, Carina, todos estavam sob a mira dos assaltantes. Flaviana foi levada ao quarto para passar suas senhas de banco, quando foi morta ao lado do cacula e do esposo.',
'https://youtu.be/kcIpYBnwlBk?feature=shared',
'https://i.ytimg.com/vi/kcIpYBnwlBk/maxresdefault.jpg',
'crimes antigos', TRUE),

('Podcast: Rosangela - Melhores momentos',
'Melhores momentos com a Dra. Rosangela Monteiro sobre o caso da Milena Dantas Bereta Nistarda, que tinha acabado de sair da delegacia onde prestou queixa contra o marido, Marcelo Nistarda Antoniassi. Mas quis o destino que ele a encontrasse. Milena terminou sem vida e teve ainda seu coracao arrancado pelas maos daquele que jurou protege-la.',
'https://youtu.be/nreTvJi_Mz4?feature=shared',
'https://i.ytimg.com/vi/nreTvJi_Mz4/hqdefault.jpg',
'impactante', TRUE),

('Christian Costa',
'Ele e diretor do Centro de Estudos do Comportamento Criminal! O Dr. Christian Costa e um renomado profissional da area da psicologia criminal, exaltado pelo seu trabalho de unir ciencia e pratica para tratar de crimes e psicopatologias.',
'https://youtu.be/0UwkMabyB78?feature=shared',
'costa.png',
'impactante', TRUE),

('A Mulher da Casa Abandonada',
'Chico Felitti investiga o misterio de uma mulher que vive em uma mansao decadente em Higienopolis, SP. Ao longo da serie, revela-se que ela e foragida do FBI, acusada de manter uma mulher em regime de escravidao nos EUA. O podcast explora temas de racismo, privilegio e impunidade.',
'https://www1.folha.uol.com.br/podcasts/202022/06/a-mulher-da-casa-abandonada-ouca-o-podcast.shtml',
'mulher.png',
'impactante', TRUE);

 INSERT INTO videos (title, description, link, image, category, is_featured) VALUES 
 
('Caso Evandro', 'Serie documental sobre o desaparecimento de Evandro Ramos Caetano em 1992.', 'https://www.youtube.com/watch?v=XkoJiUI6jNg', 'evandro.jpg', 'Investigacao', TRUE),
    ('Caso Daniel Alves', 'Noticia sobre a absolvicao de Daniel Alves da acusacao de estupro.', 'https://www.youtube.com/watch?v=3Hs4beu3Pr8', 'danielalves.jpg', 'Recente', TRUE),
    ('Boate Kiss: Tragedia de Santa Maria', 'Documentario sobre o incendio na Boate Kiss que matou 242 pessoas.', 'https://www.youtube.com/watch?v=MCvD2tGSvSg', 'kiss.jpg', 'Impactante', FALSE),
    ('Pacote Anticrime', 'Analise das mudancas trazidas pelo Pacote Anticrime na legislacao penal.', 'https://www.youtube.com/watch?v=PBtEWKVzxjk', 'anticrime.jpg', 'Leis', FALSE),
    ('Suzane von Richthofen', 'Documentario sobre o assassinato dos pais de Suzane von Richthofen.', 'https://www.youtube.com/watch?v=Iv572FJpZSc', 'richthofen.jpg', 'Crime', TRUE),
    ('Operacao Lava Jato', 'Especial sobre os 10 anos da Operacao Lava Jato e seus desdobramentos.', 'https://www.youtube.com/watch?v=xaiPHbjRTmE', 'lavajato.jpg', 'Investigacao', TRUE),
    ('Caso Lazaro Barbosa', 'Cobertura da cacada policial a Lazaro Barbosa em 202021.', 'https://www.youtube.com/watch?v=R6OGs5YQvKU', 'lazarobarbosa.jpeg', 'Recente', TRUE),
    ('Joao de Deus: Condenacao', 'Noticia sobre a condenacao de Joao de Deus por crimes de estupro.', 'https://www.youtube.com/watch?v=8zFQn_Z1o-I', 'joaodedeus.jpg', 'Investigacao', FALSE),
    ('Caso Miguel', 'Reportagem sobre a morte do menino Miguel e a responsabilidade da patroa.', 'https://www.youtube.com/watch?v=9BijzzxvENA', 'miguel.jpg', 'Crime', TRUE),
    ('Chacina da Candelaria', 'Analise do massacre de oito jovens em frente a Igreja da Candelaria.', 'https://www.youtube.com/watch?v=SJHxESnm6Ys', 'candelaria.jpg', 'Impactante', FALSE),
    ('Caso Amarildo', 'Reportagem sobre o desaparecimento do pedreiro Amarildo na Rocinha.', 'https://www.youtube.com/watch?v=7ujN1Z717sY', 'amarildo.jpg', 'Investigacao', FALSE),
    ('Assassinato de Celso Daniel', 'Investigacao sobre o assassinato do prefeito Celso Daniel.', 'https://www.youtube.com/watch?v=zM1a1eVPO4Q', 'celsodaniel.jpg', 'Crime', TRUE);
    
 INSERT INTO videos (title, description, link, image, category, is_featured) VALUES 
('Caso Isabele Ramos', 'Cobertura sobre a morte da adolescente Isabele Ramos em Cuiaba.', 'https://www.youtube.com/watch?v=rt7W8zsSxDg', 'isabeleramos.jpg', 'Crime', FALSE),
    ('Caso Isabella Nardoni','Documentario detalhado sobre o famoso caso Isabella Nardoni, apresentando bastidores da investigacao policial e analises forenses.','https://youtu.be/oIMfGiqKdII?feature=shared', 'nardoni.jpg','Investigacao', TRUE),
    ('Caso de Marielle Franco', 'Entenda os detalhes do assassinato da vereadora Marielle Franco, um crime recente que mobilizou investigacoes federais.', 'https://youtu.be/7FBIXSKTlPo?feature=shared', 'mariellefranco.jpg', 'Recente', TRUE),
    ('Caso Henry Borel', 'Documentario sobre a morte do menino Henry Borel, um dos crimes mais recentes e comentados no Brasil.', 'https://youtu.be/YZQcbx9VHfg?feature=shared', 'henryborel.jpg', 'Recente', FALSE),
    ('Caso Daniel Correa', 'Analise completa do assassinato do jogador Daniel Correa, incluindo a investigacao e julgamento dos envolvidos.', 'https://youtu.be/e7njAbFZP2o?feature=shared', 'danielcorrea.jpg', 'Recente', FALSE),
    ('Caso Rafael Miguel', 'Confira os detalhes do assassinato de Rafael Miguel e seus pais, um crime recente que chocou o Brasil.', 'https://youtu.be/RwZ-A8niBNc?feature=shared', 'rafaelmiguel.jpg', 'Recente', FALSE),
    ('Caso Eloa', 'Relembre o caso Eloa, um dos sequestros mais longos e dramaticos da historia do Brasil, com grande repercussao nacional.', 'https://youtu.be/J0dpDynvp80?feature=shared', 'CasoEloa.jpeg', 'Impactante', TRUE),
    ('Caso Suzane Richthofen', 'Documentario sobre o impactante caso Suzane Richthofen, que chocou o Brasil pelo envolvimento da filha no assassinato dos proprios pais.', 'https://youtu.be/Qc0-WnFkTOI?feature=shared', 'Richthofen.jpeg', 'Impactante', TRUE),
    ('Caso Maniaco do Parque', 'A historia do Maniaco do Parque, um dos maiores serial killers do Brasil, cujos crimes impactaram a sociedade.', 'https://youtu.be/kfa4tuoQbHU?feature=shared', 'maniacoparque.jpg', 'Impactante', TRUE);

 INSERT INTO videos (title, description, link, image, category, is_featured) VALUES
('Caso Bernardo Boldrini', 'Conheca os detalhes do caso Bernardo Boldrini, o crime brutal que chocou o pais pela frieza dos envolvidos.', 'https://youtu.be/lIwdvGH5o3Y?feature=shared', 'bernardo.jpg', 'Impactante', FALSE),
    ('O que e o Codigo Penal Brasileiro?', 'Entenda o que e e como funciona o Codigo Penal Brasileiro, suas principais caracteristicas e importancia para o sistema juridico.', 'https://youtu.be/Vg6-jwQi3pg?feature=shared', 'codigopenal.jpg', 'Leis', TRUE),
    ('Lei Maria da Penha', 'Saiba tudo sobre a Lei Maria da Penha, uma das legislacoes mais importantes para o combate a violencia domestica no Brasil.', 'https://youtu.be/tuT__DRuG-U?feature=shared', 'mariapenha.png', 'Leis', TRUE),
    ('Entenda a Lei do Estupro no Brasil', 'Explicacao didatica sobre o que diz a lei sobre estupro no Brasil, incluindo penas e definicoes legais.', 'https://youtu.be/_e6_SxuCerM?feature=shared', 'leiestupro.jpg', 'Leis', TRUE),
    ('Como Funcionam as Leis no Brasil?', 'Veja uma explicacao geral sobre o processo de criacao, aprovacao e funcionamento das leis no Brasil.', 'https://youtu.be/pC-D6sSI904?feature=shared', 'constituicao.jpg', 'Leis', FALSE),
    ('Documentario - O que e Justica?', 'Documentario que explora o conceito de justica, trazendo diferentes visoes filosoficas, juridicas e sociais sobre o tema.', 'https://youtu.be/9_3PC-CLGzA?feature=shared', 'justica.jpg', 'Leis', FALSE),
    ('Caso Madeleine McCann', 'Acompanhe a investigacao do desaparecimento de Madeleine McCann, um dos casos mais misteriosos e debatidos no mundo, com detalhes das buscas e teorias.', 'https://youtu.be/Affj8j3ITBA?feature=shared', 'MadeleineMcCann.jpeg', 'Investigacao', FALSE),
    ('Caso de Daniella Perez', 'Entenda como foi o assassinato da atriz Daniella Perez, um dos crimes mais marcantes do Brasil na decada de 90.', 'https://youtu.be/8h2jWwSpIAg?feature=shared', 'danielaperez.jpg', 'Crime', FALSE),
    ('Chacina de Realengo', 'Tragedia ocorrida em uma escola municipal no Rio de Janeiro em 202011.', 'https://youtu.be/1z0E6MzLdrA?feature=shared', 'realengo.jpg', 'Crime', FALSE);



CREATE TABLE questions (
    id SERIAL PRIMARY KEY,
    question_text TEXT NOT NULL
);

CREATE TABLE alternatives (
    id SERIAL PRIMARY KEY,
    question_id INTEGER REFERENCES questions(id) ON DELETE CASCADE,
    alternative_text TEXT NOT NULL,
    is_correct BOOLEAN DEFAULT FALSE
);


INSERT INTO questions (id, question_text) VALUES
(1, 'Qual foi o principal erro apontado na conducao do caso Evandro, que chocou o Brasil nos anos 1990?'),
(2, 'Suzane von Richthofen foi condenada por:'),
(3, 'Qual prova foi essencial para a condenacao do casal Nardoni?'),
(4, 'Onde desapareceu Madeleine McCann?'),
(5, 'Qual era o perfil criminal de Jeffrey Dahmer?'),
(6, 'A Lei Maria da Penha foi criada com o objetivo de:'),
(7, 'O assassinato de George Floyd gerou:'),
(8, 'Qual foi a condenacao de Alexandre Nardoni?'),
(9, 'O erro mais criticado da policia no caso Eloa foi:'),
(10, 'Marielle Franco foi assassinada por motivos ligados a:'),
(11, 'Qual foi uma das inovacoes trazidas pela Lei Anticrime?'),
(12, 'Cesare Battisti foi:'),
(13, 'O goleiro Bruno foi condenado pelo assassinato de:'),
(14, 'O julgamento de O.J. Simpson ficou famoso por:'),
(15, 'Qual foi a principal causa das mortes na Boate Kiss?'),
(16, 'O assassinato de Joao Helio gerou discussao sobre:'),
(17, 'O Crime de Hanau (Alemanha, 20202020) teve como motivacao:'),
(18, 'Quantos presos morreram no massacre do Carandiru em 1992?'),
(19, 'A investigacao sobre a morte de JonBenet Ramsey foi criticada por:'),
(20, 'O que resultou na morte de jovens em um baile funk em Paraisopolis (202019)?');

INSERT INTO alternatives (question_id, alternative_text, is_correct) VALUES
(1, 'Prisoes sem mandado judicial', FALSE),
(1, 'Coleta ilegal de provas tecnicas', FALSE),
(1, 'Confissoes obtidas sob tortura', TRUE),
(1, 'Ausencia de julgamento publico', FALSE),

(2, 'Estelionato contra os pais', FALSE),
(2, 'Envolvimento em sequestro', FALSE),
(2, 'Participacao no assassinato dos pais', TRUE),
(2, 'Trafico de entorpecentes', FALSE),

(3, 'Mensagens de celular', FALSE),
(3, 'Pegadas no parapeito e sangue no carro', TRUE),
(3, 'Testemunho de um vizinho', FALSE),
(3, 'Bilhete de confissao', FALSE),

(4, 'Franca', FALSE),
(4, 'Alemanha', FALSE),
(4, 'Portugal', TRUE),
(4, 'Espanha', FALSE),

(5, 'Assassino em massa por motivacao politica', FALSE),
(5, 'Serial killer e canibal', TRUE),
(5, 'Lider de seita religiosa', FALSE),
(5, 'Ladrao de bancos reincidente', FALSE),

(6, 'Proteger criancas de abuso sexual', FALSE),
(6, 'Combater o feminicidio em locais publicos', FALSE),
(6, 'Prevenir e punir a violencia domestica contra a mulher', TRUE),
(6, 'Criminalizar o assedio moral no trabalho', FALSE),

(7, 'Reforma fiscal nos EUA', FALSE),
(7, 'Movimentos antirracistas globais', TRUE),
(7, 'Proibicao do uso de armas de fogo', FALSE),
(7, 'Reestruturacao da OTAN', FALSE),

(8, 'Absolvido por falta de provas', FALSE),
(8, '15 anos por homicidio culposo', FALSE),
(8, '31 anos por homicidio triplamente qualificado', TRUE),
(8, 'Prisao perpetua', FALSE),

(9, 'Nao emitir alerta nacional', FALSE),
(9, 'Atuar sem autorizacao judicial', FALSE),
(9, 'Permitir a entrada de Nayara no cativeiro', TRUE),
(9, 'Agir sem colete a prova de balas', FALSE),

(10, 'Disputa familiar', FALSE),
(10, 'Denuncias contra milicias', TRUE),
(10, 'Desacato a autoridade', FALSE),
(10, 'Fraude eleitoral', FALSE),

(11, 'Reducao de penas minimas', FALSE),
(11, 'Criacao do juiz de garantias', TRUE),
(11, 'Extincao da delacao premiada', FALSE),
(11, 'Revogacao da prisao temporaria', FALSE),

(12, 'Um militante ambiental italiano', FALSE),
(12, 'Um espiao da Guerra Fria', FALSE),
(12, 'Um ex-ativista italiano condenado por terrorismo', TRUE),
(12, 'Um diplomata refugiado', FALSE),

(13, 'Sua esposa', FALSE),
(13, 'Um torcedor', FALSE),
(13, 'Um tecnico de futebol', FALSE),
(13, 'Eliza Samudio, ex-companheira', TRUE),

(14, 'Ser televisionado mundialmente', TRUE),
(14, 'Envolver evidencias plantadas', FALSE),
(14, 'Ser julgado por tribunal militar', FALSE),
(14, 'Levar a pena de morte', FALSE),

(15, 'Falha estrutural do predio', FALSE),
(15, 'Briga generalizada com tiros', FALSE),
(15, 'Incendio causado por artefato pirotecnico', TRUE),
(15, 'Envenenamento coletivo', FALSE),

(16, 'Reducao da maioridade penal', TRUE),
(16, 'Pena de morte no Brasil', FALSE),
(16, 'Porte de arma para civis', FALSE),
(16, 'Limites da justica restaurativa', FALSE),

(17, 'Conflitos religiosos', FALSE),
(17, 'Terrorismo racial e xenofobia', TRUE),
(17, 'Roubo em massa de bancos', FALSE),
(17, 'Protesto contra vacinas', FALSE),

(18, '31', FALSE),
(18, '72', FALSE),
(18, '111', TRUE),
(18, '20201', FALSE),

(19, 'Julgamento sem juri', FALSE),
(19, 'Falta de coleta de provas iniciais', TRUE),
(19, 'Condenacao injusta dos pais', FALSE),
(19, 'Arquivamento imediato', FALSE),

(20, 'Desabamento do palco', FALSE),
(20, 'Ataque de faccao criminosa', FALSE),
(20, 'Acao policial mal conduzida', TRUE),
(20, 'Incendio criminoso', FALSE);