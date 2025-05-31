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
    ('ana_silva', 'Ana Silva', 'anasilva.jpeg'),
    ('joao_martins', 'João Martins', 'joaomartins.jpeg'),
    ('carla_oliveira', 'Carla Oliveira', 'carlaoliveira.jpeg'),
    ('alice01', 'Alice Silva', 'alice01.jpeg'),
    ('bob02', 'Bob Costa', 'bob02.jpeg'),
    ('carol03', 'Carol Mendes', 'carolmendes.jpeg'),
    ('david04', 'David Rocha', 'davidrocha'),
    ('eva05', 'Eva Lima', 'evalima.jpeg'),
    ('felipe06', 'Felipe Souza', 'felipesouza.jpeg'),
    ('gabriela07', 'Gabriela Oliveira', 'gabrielaoliveira.jpeg'),
    ('henrique08', 'Henrique Almeida', 'henriquealmeida.jpeg'),
    ('isabela09', 'Isabela Pereira', 'isabelapereira.jpeg'),
    ('joao10', 'João Santos', 'joaosantos.jpeg'),
    ('karla11', 'Karla Martins', 'karlamartins.jpeg'),
    ('luan12', 'Luan Costa', 'luancosta.jpeg'),
    ('mariana13', 'Mariana Rocha', 'marianarocha.jpeg'),
    ('natalia14', 'Natália Lima', 'natalialima.jpeg'),
    ('olga15', 'Olga Fernandes', 'olgafernandes.jpeg'),
    ('lucas_ferreira', 'Lucas Ferreira', 'lucasferreira.jpeg');

    INSERT INTO followers (follower_id, following_id) VALUES
    (1, 2),
    (1, 3),
    (1, 4),
    (1, 5),
    (1, 6),
    (2, 3),
    (2, 4),
    (2, 5),
    (2, 6),
    (3, 2),
    (3, 4),
    (3, 5),
    (3, 6),
    (2, 1),
    (3, 1),
    (4, 2);

    INSERT INTO posts (user_id, title, caption, media_url) VALUES
(1, 'Caso Evandro', 'O desaparecimento do menino Evandro chocou o Brasil nos anos 90.', 'evandro.jpg'),
(2, 'Chacina da Candelária', 'Tragédia que marcou o Rio de Janeiro em 1993.', 'candelaria.jpg'),
(3, 'Caso Isabella Nardoni', 'Uma investigação que parou o país em 2008.', 'nardoni.jpg'),
(4, 'Crimes da Rua Cuba', 'Um mistério sem solução que intriga até hoje.', 'cuba.jpg'),
(5, 'Maníaco do Parque', 'Francisco de Assis foi condenado por uma série de assassinatos brutais.', 'maniacoparque.jpg'),
(1, 'Caso Richthofen', 'Suzane planejou o assassinato dos próprios pais.', 'richthofen.jpg'),
(2, 'Caso Nardoni: Julgamento', 'Acompanhe os detalhes do julgamento mais marcante da década.', 'julgamento.jpg'),
(3, 'Caso Eloá', 'O sequestro e morte de Eloá teve repercussão nacional.', 'eloa.jpg'),
(4, 'Caso João Hélio', 'Um crime brutal que mobilizou o país por justiça.', 'joao_helio.jpg'),
(5, 'Assassinato de PC Farias', 'Um dos maiores mistérios políticos do Brasil.', 'pcfarias.jpg'),
(1, 'Caso Mércia Nakashima', 'Ciúmes e vingança em um dos crimes mais midiáticos.', 'nakashima.jpg'),
(2, 'Bruno e Eliza', 'O goleiro Bruno foi condenado pelo assassinato de Eliza Samudio.', 'brunoeliza.jpg'),
(3, 'Caso Daniela Perez', 'Crime passional que chocou o país na década de 90.', 'danielaperez.jpg'),
(4, 'Caso Bernardo Boldrini', 'O assassinato de uma criança pelo próprio pai e madrasta.', 'bernardo.jpg'),
(5, 'Chacina de Osasco', 'Execuções em série envolvendo PMs e ex-PMs.', 'osasco.jpg'),
(1, 'Caso Ana Lídia', 'Assassinato brutal de uma criança em Brasília (1973).', 'analidia.jpg'),
(2, 'Caso Madeleine McCann', 'Desaparecimento que teve repercussão internacional.', 'mccann.jpg'),
(3, 'O Monstro de Goiânia', 'Crime de serial killer que chocou o centro-oeste brasileiro.', 'goiania.jpg'),
(4, 'Assassinato de Ângela Diniz', 'Caso de feminicídio com grande repercussão nos anos 70.', 'angela.jpg'),
(5, 'Massacre de Realengo', 'Ataque a uma escola no Rio em 2011 deixou 12 mortos.', 'realengo.png');


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
    (1, 2, 'Uau, que trilha incrível!'),
    (2, 1, 'Que nascer do sol espetacular!'),
    (3, 5, 'Seu pet é muito fofo 🐶'),
    (4, 3, 'Café é vida!'),
    (5, 4, 'Qual o nome do livro?'),
    (6, 5, 'Essa noite estava linda mesmo.'),
    (7, 3, 'Onde fica esse lugar?'),
    (8, 8, 'Foto maravilhosa!'),
    (9, 9, 'Gostei do enquadramento.'),
    (10, 2, 'Curti demais essa vibe.'),
    (11, 3, 'A cor dessa paisagem tá surreal.'),
    (12, 4, 'Post incrível 👏'),
    (13, 5, 'Lugar dos sonhos!'),
    (14, 1, 'Quero ir aí um dia!'),
    (15, 2, 'Inspiração pura nessa imagem!');

    --decadas de 70
    INSERT INTO news (title, description, text, link, image, category, decade, year, is_featured)
    VALUES 

    ('Caryn Campbell, uma das vítimas de Ted Bundy, estava de férias com sua família em seu hotel quando Bundy a sequestrou.',
    'Campbell tinha 23 anos quando desapareceu do resort no Colorado. Ela foi vista pela última vez indo ao saguão buscar uma revista e nunca voltou.',
    'Caryn Campbell foi uma das vítimas de Ted Bundy, sequestrada em um resort no Colorado.',
    'https://www.reddit.com/r/serialkillers/comments/1794p7g/caryn_campbell_one_of_ted_bundys_victims_was_on/?tl=pt-br',
    'caryncampbell.jpeg',
    'Homicídio', '70', 1975, FALSE),

    ('Há 50 anos, Lynda Ann Healy foi sequestrada e assassinada por Ted Bundy. Ela tinha 21 anos e acredita-se que foi sua primeira vítima.',
    'Aos 21 anos, Lynda Ann Healey desapareceu em 1974. Sangue foi encontrado em seus lençóis, e sua camisola pendurada no armário.',
    'Lynda Ann Healy foi uma das primeiras vítimas de Ted Bundy, desaparecendo em 1974.',
    'https://aventurasnahistoria.com.br/noticias/vitrine/historia-as-vitimas-esquecidas-de-ted-bundy.phtml',
    'lyndaannhealy.jpeg',
    'Homicídio', '70', 1974, FALSE),

    ('Em memória de Kimberly Leach, 12, a última vítima de Ted Bundy: o mundo perdeu uma grande alma',
    'Kimberly Leach, 12 anos, desapareceu em 1978 em Lake City, Flórida. A polícia prendeu Ted Bundy, já procurado pelo FBI.',
    'Kimberly Leach foi a última vítima de Ted Bundy, desaparecendo em 1978.',
    'https://aventurasnahistoria.com.br/noticias/vitrine/historia-as-vitimas-esquecidas-de-ted-bundy.phtml',
    'KimberlyLeach.jpeg',
    'Homicídio', '70', 1978, TRUE),

    ('Quem ama não mata: o feminicídio de 1976 que ajudou a mudar a Justiça brasileira',
    'Em 2023, o caso da socialite Ângela Maria Fernandes Diniz, morta a tiros em 1976 pelo namorado Doca Street, foi citado no STF como marco contra o feminicídio.',
    'O caso Ângela Diniz foi um marco na luta contra o feminicídio no Brasil.',
    'https://g1.globo.com/rj/rio-de-janeiro/noticia/2023/09/16/quem-ama-nao-mata-o-feminicidio-de-1976-que-ajudou-a-mudar-a-justica-brasileira.ghtml',
    'angela-e-doca.jpeg',
    'Feminicídio', '70', 1976, TRUE),

    ('Caso Carlinhos',
    'Em 1973, Carlinhos foi sequestrado em casa no Rio de Janeiro. A família recebeu um pedido de resgate, mas o destino do menino permanece desconhecido.',
    'O caso Carlinhos é um dos desaparecimentos mais misteriosos do Brasil.',
    'https://oglobo.globo.com/rio/dez-crimes-que-chocaram-rio-de-janeiro-17845895',
    'Carlinhos.jpeg',
    'Assassinato', '70', 1973, FALSE);

    --decadas de 80
    INSERT INTO news (title, description, text, link, image, category, decade, year, is_featured)
    VALUES 
    ('1980: O ano que ficou marcado como a decada dos SERIAL KILLERS nos EUA',
    'Durante tres decadas da segunda metade do seculo 20, a America do Norte registrou um crescimento expressivo no numero de homicidios em serie, caracterizados por crimes semelhantes cometidos por um mesmo autor, os chamados serial killers.',
    'Esse aumento teve inicio nos anos 1960 e intensificou-se nas decadas seguintes, atingindo seu auge nos anos 1980, quando os casos se tornaram mais frequentes e notorios.',
    'https://www.bbc.com/portuguese/internacional-45363043',
    'SerialKillers.jpeg',
    'Criminologia', '80', 1980, TRUE),

    ('Um homem aparentemente inofensivo dos EUA: Ted Bundy',
    'Jeffrey Dahmer, o Canibal de Milwaukee, matou 17 homens e garotos entre 1977 e 1991. Nascido em 1960, cometeu o primeiro assassinato aos 17 anos.',
    'Atraia vitimas para casa, onde cometia atos horriveis e desmembrava os corpos. Antes da prisao, teve problemas com a lei e foi expulso do exercito.',
    'https://f5.folha.uol.com.br/cinema-e-series/2022/10/jeffrey-dahmer-por-que-serie-sobre-serial-killer-americano-causa-tanta-polemica.shtml',
    'JeffreyDahmer.jpg',
    'Homicidio Qualificado', '80', 1980, TRUE),

    ('O assassino em serie que fez com que os palhacos nos aterrorizassem: John Wayne Gacy',
    'John Wayne Gacy, nascido em 1942 nos suburbios de Chicago, teve uma infancia marcada por abusos. Trabalhou em funeraria, casou-se e virou gerente de restaurante, onde comecou seus crimes.',
    'Enriquecido com sua empresa, criou o palhaco Pogo para eventos infantis, ocultando sua verdadeira face de predador sexual e assassino.',
    'https://brasil.elpais.com/brasil/2019/06/28/actualidad/1561705341_083525.html',
    'JohnWayne.jpeg',
    'Serial Killers', '80', 1980, TRUE),

    ('Alemanha condena enfermeiro da morte que assassinou 85 pacientes',
    'Niels Hogel, enfermeiro alemao de 42 anos, foi condenado a prisao perpetua por matar 85 pacientes entre 2000 e 2005.',
    'A justica considerou sua culpa particularmente grave, anulando a chance de liberdade apos 15 anos. E considerado o maior assassino em massa da Alemanha desde a Segunda Guerra.',
    'https://brasil.elpais.com/brasil/2019/06/06/internacional/1559810905_905194.html',
    'NielsHogel.jpeg',
    'Homicidio em Serie', '80', 1980, TRUE),

    ('Assassinato de John Lennon: A Tragedia que Abalou o Mundo',
    'Em 8 de dezembro de 1980, o ex-Beatle John Lennon foi assassinado a tiros por Mark David Chapman na entrada do edificio Dakota, em Nova York.',
    'Chapman, fa obcecado, alegou ter sido inspirado pelo livro O Apanhador no Campo de Centeio. Lennon morreu a caminho do hospital, aos 40 anos.',
    'https://people.com/john-lennon-death-what-to-know-7511226',
    'John_Lennon.jpeg',
    'Assassinato', '80', 1980, TRUE);

    --decadas de 90
    INSERT INTO news (title, description, text, link, image, category, decade, year, is_featured)
    VALUES 
    ('Chacina de Ácari',
    'Caso ocorrido no Rio de Janeiro, envolvendo o desaparecimento de 11 jovens. Supostamente mortos por policiais, o caso evidenciou questões de violência policial e omissão estatal, gerando repercussão internacional e pedidos de justiça por parte das famílias das vítimas.',
    'A Chacina de Ácari é um dos casos mais emblemáticos de violência policial no Brasil.',
    'https://g1.globo.com/jornal-nacional/noticia/2024/12/04/chacina-de-acari-corte-interamericana-responsabiliza-brasil-pelo-desaparecimento-de-11-jovens-no-rio.ghtml',
    'ChacinadeÀcari.jpeg',
    'Chacina', '90', 1990, FALSE),

    ('Caso da menina Míriam',
    'O desaparecimento e a morte da menina Míriam Brandão chocaram o Brasil em 1992. O caso expôs a brutalidade e a violência contra crianças, mobilizando a opinião pública e gerando questionamentos sobre a segurança infantil.',
    'O caso Míriam Brandão trouxe à tona a necessidade de maior proteção às crianças no Brasil.',
    'https://www.em.com.br/app/noticia/gerais/2011/09/02/interna_gerais,248406/assassino-que-chocou-a-capital-em-1992-esta-proximo-da-liberdade.shtml',
    'MeninaMíriam.jpeg',
    'Homicídio', '90', 1992, FALSE),

    ('Caso Daniella Perez',
    'O assassinato da atriz Daniella Perez em 1992, cometido por um colega de elenco, gerou grande comoção nacional. O crime foi amplamente coberto pela mídia e desencadeou um debate sobre feminicídio.',
    'O caso Daniella Perez foi um marco na luta contra o feminicídio no Brasil.',
    'https://www.cnnbrasil.com.br/entretenimento/daniella-perez-assassinato-de-atriz-completa-32-anos-relembre-o-caso/L',
    'DanielaPerez.jpeg',
    'Feminicídio', '90', 1992, TRUE),

    ('Caso Maníaco do Parque',
    'Francisco de Assis Pereira, o Maníaco do Parque, aterrorizou São Paulo no final dos anos 1990 com uma série de assassinatos brutais. Ele atraía mulheres ao parque sob falsos pretextos e as assassinava.',
    'O caso Maníaco do Parque é um dos mais conhecidos envolvendo serial killers no Brasil.',
    'https://www.cnnbrasil.com.br/nacional/relembere-o-caso-do-maniaco-do-parque-tema-de-filme-que-estreia-hoje/',
    'ManíacodoParque.jpeg',
    'Assassinato em série', '90', 1998, TRUE),

    ('Caso atirador do shopping',
    'Em 1998, um atirador abriu fogo em um shopping center no Brasil, deixando vítimas e espalhando pânico entre os frequentadores. O caso trouxe à tona discussões sobre segurança em locais públicos e o controle de armas.',
    'O caso do atirador do shopping gerou debates sobre segurança pública e controle de armas no Brasil.',
    'https://www.cnnbrasil.com.br/nacional/atirador-do-shopping-morumbi-em-sp-deixa-prisao-apos-25-anos-entenda/',
    'AtiradordoShopping.jpeg',
    'Homicídio', '90', 1998, FALSE);

    -- INSERTS de noticias pesquisadas anos 2000

INSERT INTO news (title, description, text, link, image, category, decade, year, is_featured)
VALUES

('Caso Richthofen', 'Assassinato brutal dos pais de Suzane von Richthofen que chocou o pais em 2002.', 'O assassinato de Manfred e Marisia von Richthofen, pais de Suzane von Richthofen, ocorreu na madrugada de 31 de outubro de 2002, na casa da familia em Sao Paulo. O crime, cometido com extrema brutalidade, chocou o pais nao apenas pela violencia, mas pelo perfil social dos envolvidos. Suzane, entao com 18 anos, planejou e executou o assassinato com a ajuda de seu namorado, Daniel Cravinhos, e do irmao dele, Cristian Cravinhos.

Suzane vinha enfrentando resistencia dos pais em relacao ao seu namoro com Daniel. Para se livrar da interferencia e obter acesso a heranca familiar, estimada em cerca de 11 milhoes de reais, ela arquitetou o crime ao longo de semanas. No dia da execucao, levou o irmao, Andreas, de 15 anos, para um cybercafe, garantindo que ele nao testemunhasse o ato. Enquanto os pais dormiam, Daniel e Cristian os atacaram com barras de ferro, desferindo multiplos golpes. Manfred morreu instantaneamente, enquanto Marisia tentou se defender, mas tambem foi morta.

Para simular um assalto, os criminosos espalharam documentos e levaram dinheiro. Após o assassinato, Suzane passou a noite com Daniel em um motel e retornou pela manha com os irmaos Cravinhos para "descobrir" o crime junto a policia. No entanto, sua frieza e comportamento levantaram suspeitas. Em poucos dias, os tres confessaram e foram condenados em 2006 por homicidio triplamente qualificado. Suzane e Daniel receberam 39 anos e 6 meses de prisao, enquanto Cristian foi condenado a 38 anos e 6 meses.

O caso teve grande repercussao, inspirando livros, documentarios e filmes, como A Menina que Matou os Pais e O Menino que Matou Meus Pais. Em 2023, Suzane obteve liberdade condicional apos cumprir parte da pena, enquanto Cristian voltou a ser preso em 2018 por porte de armas e suborno. O crime gerou debates sobre valores familiares, justica criminal e reintegracao de condenados a sociedade.', 'https://www.estadao.com.br/brasil/suzane-von-richthofen-relembre-como-a-policia-desvendou-o-caso-e-como-estao-os-acusados-hoje-nprm/', 'https://oglobo.globo.com/epoca/brasil/serie-de-tv-inspirou-assassinos-dos-pais-de-suzane-von-richthofen-24195277', 'Crime hediondo', 'anos 2000', 2002, TRUE),


('Caso Friedenbach-Caffe', 'Crime barbaro contra casal de adolescentes que reacendeu o debate sobre maioridade penal no Brasil.', 'O assassinato de Liana Friedenbach e Felipe Caffe em novembro de 2003 foi um dos crimes mais chocantes da historia brasileira, mobilizando a opiniao publica e reacendendo debates sobre seguranca e legislacao penal. O casal, que namorava ha cerca de dois meses, decidiu viajar para acampar na zona rural de Embu-Guacu, Sao Paulo. Para isso, Liana mentiu para os pais, dizendo que participaria de uma excursao para Ilhabela, enquanto Felipe omitiu que estaria apenas com ela. No dia 31 de outubro, partiram para o sitio abandonado onde montaram acampamento.

No dia seguinte, ao caminharem pela regiao, cruzaram com Roberto Aparecido Alves Cardoso, conhecido como Champinha, de 16 anos, e Paulo Cesar da Silva Marques, o Pernambuco, de 32 anos. Os criminosos perceberam que o casal estava desprotegido e decidiram aborda-los. Na tarde de 1 de novembro, invadiram a barraca, armados, e os levaram para uma area isolada na mata. Mantidos em cativeiro, Felipe foi assassinado na manha do dia 2 de novembro com um tiro na nuca por Pernambuco, enquanto Liana foi violentada repetidamente por Champinha e outros cumplices por dias, antes de ser brutalmente morta.

O desaparecimento dos jovens mobilizou familiares e autoridades. O pai de Liana, Ari Friedenbach, intensificou as buscas com helicopteros e panfletagem. A policia identificou Champinha como suspeito e, apos sua captura, ele revelou os locais onde os corpos estavam. Felipe havia sido executado com um unico tiro, enquanto Liana apresentava multiplos ferimentos por arma branca.

Os criminosos foram julgados e condenados. Pernambuco recebeu pena de 110 anos de prisao, enquanto Antonio Caetano da Silva foi sentenciado a 124 anos. Agnaldo Pires recebeu 47 anos, e Antonio Matias de Barros foi condenado a seis anos. Champinha, por ser menor de idade, cumpriu tres anos na Fundacao CASA e, devido a avaliacoes psiquiatricas que indicaram transtorno de personalidade antissocial, foi transferido para uma unidade psiquiatrica onde permanece ate hoje.

O caso gerou forte impacto social e reacendeu debates sobre a maioridade penal no Brasil. Ari Friedenbach tornou-se um defensor de mudancas na legislacao para endurecer penas e garantir maior protecao aos jovens. A tragedia evidenciou fragilidades do sistema de seguranca e justica, impulsionando discussoes sobre reforma penal e medidas preventivas contra crimes violentos.', 'https://projetocolabora.com.br/ods16/caso-champinha-crime-perverso-fim-aventura-adolescentes-apaixonados/', 'https://veja.abril.com.br/coluna/radar/os-motivos-de-friedenbach/', 'Crime hediondo', 'anos 2000', 2003, FALSE),


('Caso Madeleine McCann', 'Desaparecimento de menina britanica em Portugal que virou um dos maiores misterios da decada.', 'O desaparecimento de Madeleine Beth McCann, uma menina britanica de 3 anos, ocorreu em 3 de maio de 2007, no resort Praia da Luz, Algarve, Portugal. O caso teve repercussao global imediata e, ate hoje, permanece cercado de misterio, investigacoes e inumeras teorias.

Madeleine estava de ferias com seus pais, Kate e Gerry McCann, medicos britanicos, e seus irmaos gemeos. A familia se hospedava no Ocean Club, e na noite do desaparecimento, os pais sairam para jantar com amigos em um restaurante proximo, deixando os filhos dormindo no apartamento. Eles faziam verificacoes periodicas, mas, por volta das 22h, Kate McCann descobriu que Madeleine havia sumido, com a janela aberta. O alerta foi dado, e buscas intensas comecaram imediatamente.

A policia portuguesa foi criticada por falhas na conducao inicial do caso, como o isolamento inadequado da cena do crime e a demora na coleta de provas. Ao longo das semanas, varias pistas surgiram, incluindo relatos de um homem ou uma mulher carregando uma crianca naquela noite, mas nenhuma levou ao paradeiro de Madeleine.

Em setembro de 2007, a policia portuguesa declarou os proprios pais como suspeitos, alegando que Madeleine teria morrido acidentalmente e sua morte foi encoberta. No entanto, sem provas conclusivas, o caso foi arquivado em julho de 2008, e o status de suspeitos dos McCann foi removido.

Em 2011, a Scotland Yard reabriu o caso com a Operacao Grange, investigando novas pistas. Em junho de 2020, as autoridades alemas apontaram um novo suspeito: Christian Bruckner, um criminoso sexual alemao que estava em Portugal na epoca do desaparecimento. Em 2022, a policia portuguesa o declarou arguido, mas ele continua negando envolvimento, e nao ha provas definitivas.

O caso ganhou enorme cobertura midiática e apoio de celebridades e lideres mundiais, como o Papa Bento XVI e o primeiro-ministro britanico Gordon Brown. A campanha "Find Madeleine" arrecadou milhoes em busca de respostas. Em 2019, a Netflix lancou o documentario The Disappearance of Madeleine McCann.

Ate hoje, Madeleine continua desaparecida, tornando esse caso um dos maiores misterios criminais da historia recente. Seus pais seguem na luta por respostas, mantendo viva a esperanca de reencontra-la.', 'https://www.cnnbrasil.com.br/tudo-sobre/caso-madeleine-mccann/', 'https://www.estadao.com.br/internacional/caso-madeleine-mccann-testemunha-chave-policia-ignorou-denuncia-nprei/', 'Crime de Sequestro', 'anos 2000', 2007, FALSE),


('Caso Onibus 174', 'Sequestro de onibus no Rio transmitido ao vivo, que terminou em tragedia e criticas a policia.', 'O sequestro do onibus 174, ocorrido em 12 de junho de 2000 no Rio de Janeiro, foi um dos episodios mais marcantes da cronica policial brasileira. O criminoso Sandro Barbosa do Nascimento, sobrevivente da Chacina da Candelaria, manteve refens dentro do veiculo por quase cinco horas, em um evento transmitido ao vivo para todo o pais.

Sandro, entao com 21 anos, entrou no onibus da linha 174 no bairro Jardim Botanico, armado com um revolver calibre 38. Pouco depois, um dos passageiros conseguiu alertar uma viatura policial, que interceptou o veiculo. O motorista e alguns passageiros conseguiram escapar, mas dez pessoas permaneceram como refens. Durante o sequestro, Sandro obrigou uma das vitimas a escrever frases ameacadoras nas janelas do onibus, como "Ele vai matar geral as seis horas".

A operacao policial foi caotica e transmitida ao vivo pelas principais emissoras. A presenca da imprensa intensificou a tensao, e Sandro usou as cameras para exibir suas ameacas. Apos horas de negociacao, ele desceu do onibus usando a refem Geisa Firmo Goncalves, uma professora de 21 anos, como escudo humano. No momento da acao, um policial do BOPE disparou, mas acertou Geisa, que foi baleada novamente por Sandro e morreu no local.

O sequestrador foi rendido e levado para uma viatura policial, onde morreu por asfixia, supostamente sufocado pelos agentes. O caso gerou grande repercussao e criticas a atuacao da policia, que falhou na contencao do criminoso e na protecao dos refens.

O episodio inspirou o documentario Onibus 174, dirigido por Jose Padilha, que explora a infancia de Sandro e as condicoes sociais que o levaram ao crime. O caso tambem levantou debates sobre violencia urbana, desigualdade social e a abordagem policial em situacoes de crise.', 'https://oglobo.globo.com/blogs/blog-do-acervo/post/2024/03/sequestro-do-onibus-174-horas-de-tensao-com-uma-tragedia-no-final.ghtml', 'https://www.metropoles.com/brasil/em-2000-brasil-assistia-ao-vivo-ao-terror-do-sequestro-do-onibus-174', 'Crime Hediondo', 'anos 2000', 2000, FALSE),


('Caso Isabella Nardoni', 'Assassinato de menina de cinco anos em Sao Paulo, com grande comoção nacional.', 'O assassinato de Isabella de Oliveira Nardoni, ocorrido em 29 de marco de 2008, foi um dos crimes mais chocantes da historia brasileira. A menina de cinco anos foi jogada do sexto andar de um predio na Vila Guilherme, Sao Paulo, e seu caso comoveu o pais pela brutalidade e pela suspeita de envolvimento de pessoas proximas.

Na noite do crime, Isabella estava com o pai, Alexandre Nardoni, e a madrasta, Anna Carolina Jatoba. Segundo o casal, ao chegarem ao apartamento, alguem teria invadido o imovel e jogado a crianca pela janela. No entanto, as investigacoes apontaram um cenario completamente diferente. Exames periciais indicaram que Isabella havia sido agredida antes da queda, com sinais de asfixia e lesoes compativeis com violencia dentro do apartamento.

A Policia Civil iniciou uma investigacao minuciosa, e em poucos dias, Alexandre e Anna Carolina se tornaram os principais suspeitos. A pericia detectou vestigios de sangue no apartamento e no carro da familia, alem de marcas de tentativa de limpeza da cena do crime. O laudo indicou que Isabella foi estrangulada antes de ser arremessada pela janela, tornando impossivel a tese de invasao por terceiros.

O julgamento, realizado em 2010, teve grande repercussao nacional. A defesa alegou que nao havia provas diretas contra o casal, mas a promotoria apresentou um conjunto robusto de evidencias periciais e testemunhais. No fim, Alexandre Nardoni foi condenado a 31 anos de prisao por homicidio triplamente qualificado, e Anna Carolina Jatoba recebeu 26 anos pelo mesmo crime.

O caso gerou uma onda de comoção e revolta no Brasil, levando a debates sobre violencia infantil e a eficacia da justica. Isabella tornou-se simbolo da luta por protecao as criancas, e sua historia continua sendo lembrada como um dos crimes mais impactantes do pais.

Ate hoje, a tragedia de Isabella Nardoni marca a memoria coletiva brasileira, evidenciando a importancia da justica e do combate a violencia domestica.', 'https://g1.globo.com/tudo-sobre/isabella-nardoni/', 'https://fotografia.folha.uol.com.br/galerias/1594787331937579-caso-isabella-nardoni', 'Crime Hediondo', 'anos 2008', 2000, FALSE);


-- INSERTS de notícias pesquisadas anos 2010

INSERT INTO news (title, description, text, link, image, category, decade, year, is_featured)
VALUES

('Caso Eliza Samudio', 'Feminicidio ligado ao goleiro Bruno que expos a violencia contra mulheres no meio esportivo.', 'O assassinato de Eliza Samudio, ocorrido em junho de 2010, gerou grande repercussao nacional, especialmente pelo envolvimento do goleiro Bruno Fernandes, entao jogador do Flamengo. O crime, marcado pela brutalidade e ocultacao de provas, levantou debates sobre violencia contra a mulher e impunidade.

Eliza e Bruno tiveram um relacionamento conturbado, do qual nasceu um filho. Em 2009, ela entrou com uma acao judicial para reconhecimento da paternidade, o que gerou conflitos. Em junho de 2010, ela desapareceu, e as investigacoes apontaram que Bruno ordenou seu sequestro no Rio de Janeiro. Eliza foi levada para um sitio em Minas Gerais, onde foi agredida e morta. Marcos Aparecido dos Santos, o Bola, um ex-policial militar, teria sido responsavel pela execucao e ocultacao do cadaver, que nunca foi encontrado.

A Policia Civil de Minas Gerais conduziu a investigacao, reunindo testemunhos que indicavam Bruno como mandante do crime. Em julho de 2010, ele foi preso e admitiu envolvimento indireto. O julgamento aconteceu em 2013, quando Bruno foi condenado a 22 anos e 3 meses de prisao por homicidio triplamente qualificado, sequestro e ocultacao de cadaver. Bola recebeu pena de 22 anos, e outros cumplices foram condenados a penas menores.

O caso teve forte impacto social, gerando debates sobre violencia de genero e poder de figuras publicas. Bruno tentou retomar a carreira no futebol apos a prisao, provocando indignacao e protestos da sociedade. Sua possivel reintegracao levantou questoes sobre a responsabilidade de clubes e patrocinadores diante de crimes violentos.

Ate hoje, o assassinato de Eliza Samudio permanece como um dos crimes mais marcantes do pais, evidenciando a necessidade de politicas mais rigidas contra o feminicidio e de maior protecao as vitimas de violencia domestica.', 'https://g1.globo.com/tudo-sobre/eliza-samudio/', 'https://noticias.uol.com.br/ultimas-noticias/efe/2017/06/21/canibal-de-montreal-se-casara-com-outro-preso-no-final-do-mes.htm', 'Crime Hediondo', 'anos 2010', 2010, TRUE),


('Caso Luka Magnotta', 'Assassino canadense que filmou e divulgou crime brutal na internet, gerando comocao mundial.', 'O assassinato de Jun Lin, um estudante chines de 33 anos, em maio de 2012, foi um dos crimes mais brutais e midiaticos da decada. Com requintes de crueldade e exibicao publica, o caso expos questoes sobre psicopatia, narcisismo e o impacto das redes sociais em crimes violentos.

Luka Rocco Magnotta, um ex-modelo e ator porno canadense, era obcecado por atencao e fama. Antes do crime, ele ja havia publicado videos matando gatos, o que chamou a atencao de internautas e ativistas. Em 2012, Magnotta assassinou e esquartejou Jun Lin em Montreal, filmando toda a acao e divulgando o video na internet com o titulo 1 Lunatic 1 Ice Pick. Como se nao bastasse, ele enviou partes do corpo da vitima para escolas e sedes de partidos politicos no Canada.

Apos cometer o crime, Magnotta fugiu para a Europa, dando inicio a uma cacada internacional. Internautas e autoridades rastrearam seus movimentos, e ele foi encontrado dias depois em Berlim, Alemanha, enquanto acessava sites de noticias sobre si mesmo em um cyber cafe. Sua prisao foi rapida e atraiu enorme atencao midiática.

No julgamento, ocorrido em 2014, a defesa tentou alegar insanidade, mas o juri rejeitou essa tese diante da premeditacao e crueldade do crime. Magnotta foi condenado a prisao perpetua, com possibilidade de liberdade condicional apos 25 anos.

O caso ganhou ainda mais notoriedade com o lancamento do documentario da Netflix Dont Fk With Cats, que detalha como internautas ajudaram na captura do criminoso. Alem da investigacao, o documentario levanta debates sobre os limites da exibicao de crimes na internet e o papel das redes sociais na construcao da identidade de psicopatas.

O assassinato de Jun Lin continua sendo lembrado como um dos mais macabros da era digital, evidenciando os perigos da busca desenfreada por atencao e notoriedade online.', 'https://noticias.uol.com.br/ultimas-noticias/efe/2017/06/21/canibal-de-montreal-se-casara-com-outro-preso-no-final-do-mes.htm', 'https://www.rfi.fr/br/americas/20130311-esquartejador-canadense-acusado-de-matar-o-namorado-sera-julgado-partir-desta-segu', 'Crime Hediondo', 'anos 2010', 2012, FALSE),


('Caso Chris Watts', 'Homem mata esposa gravida e filhas pequenas nos EUA em um dos crimes mais chocantes da decada.', 'O assassinato de Shanann Watts, gravida de 15 semanas, e suas filhas Bella (4 anos) e Celeste (3 anos), ocorrido em agosto de 2018, foi um dos crimes mais chocantes dos Estados Unidos. A brutalidade do ato e a frieza do autor, Chris Watts, marido e pai das vitimas, causaram enorme repercussao mundial. O contraste entre a imagem publica da familia nas redes sociais e a realidade sombria por tras do crime levantou questoes sobre relacionamentos abusivos e a ilusao da vida perfeita online.

Na manha de 13 de agosto de 2018, Shanann desapareceu junto com suas filhas em Frederick, Colorado. Inicialmente, Chris Watts se apresentou como um marido preocupado, pedindo ajuda para encontra-las. No entanto, as investigacoes revelaram inconsistencias em seu depoimento. Um teste de poligrafo apontou suas mentiras, e, pouco depois, ele confessou ter estrangulado sua esposa durante uma discussao e, em seguida, matado suas filhas. Ele levou os corpos ao seu local de trabalho, um campo de petroleo, onde enterrou Shanann em uma cova rasa e colocou Bella e Celeste dentro de tanques de oleo.

A motivacao para o crime foi revelada durante as investigacoes. Chris mantinha um caso extraconjugal e queria comecar uma nova vida com a amante. Inicialmente, alegou que matou Shanann em um acesso de raiva, mas as provas indicavam premeditacao. Em novembro de 2018, Chris foi condenado a cinco prisoes perpetuas sem possibilidade de liberdade condicional, alem de 84 anos adicionais por ocultacao de cadaver e interrupcao de gravidez.

O caso gerou grande repercussao e virou documentario da Netflix (American Murder: The Family Next Door), que detalhou a vida da familia atraves de videos e mensagens. A tragedia levantou debates sobre violencia domestica, feminicidio e a influencia das redes sociais na construcao de imagens irreais.

A historia de Chris Watts continua sendo lembrada como um alerta sobre os perigos de relacoes abusivas e sobre como uma fachada de felicidade pode esconder segredos sombrios.', 'https://g1.globo.com/mundo/noticia/2019/03/07/homem-que-matou-esposa-gravida-e-duas-filhas-nos-eua-revela-pela-primeira-vez-como-cometeu-crime.ghtml', 'https://s2-g1.glbimg.com/z-wrGH4Mf2M205byQAxvPkNKh-Y=/0x0:1700x1065/1008x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_59edd422c0c84a879bd37670ae4f538a/internal_photos/bs/2018/J/8/G8hTVPTjK9BFF3hdqHBg/ap18323689553525.jpg', 'Crime Hediondo', 'anos 2010', 2018, TRUE),


('Caso Stephen Paddock', 'Maior ataque a tiros da historia dos EUA, com 60 mortos durante festival em 2017.', 'O Massacre de Las Vegas, ocorrido em 1 de outubro de 2017, foi o ataque a tiros mais mortal da historia dos Estados Unidos. Stephen Paddock, um contador aposentado de 64 anos, abriu fogo contra uma multidao durante o festival de musica country Route 91 Harvest, deixando 60 mortos e mais de 800 feridos. O ataque chocou o mundo pela brutalidade e pela falta de uma motivacao clara.

Paddock se hospedou no 32 andar do Mandalay Bay Hotel, em Las Vegas, e levou consigo um arsenal de armas – incluindo rifles semiautomaticos adaptados com bump stocks, dispositivos que aumentavam sua cadencia de tiro. Por volta das 22h05, ele quebrou as janelas do quarto e disparou contra mais de 20 mil pessoas que assistiam ao show do cantor Jason Aldean. O tiroteio durou aproximadamente 10 minutos e provocou caos na multidao, com pessoas sendo pisoteadas durante a fuga.

As equipes de seguranca levaram quase uma hora para encontrar a localizacao exata do atirador. Antes da abordagem, Paddock se suicidou, encerrando o ataque sem deixar explicacoes. No quarto, a policia encontrou 23 armas de fogo e cameras instaladas pelo criminoso para monitorar os corredores do hotel. Investigacoes do FBI nao conseguiram identificar uma motivacao clara para o crime. Paddock nao possuia antecedentes criminais, envolvimento politico ou conexoes com grupos extremistas.

O massacre reacendeu debates sobre o controle de armas nos EUA, resultando na proibicao dos bump stocks pelo governo americano. Tambem houve mudancas nos protocolos de seguranca em grandes eventos e hoteis, visando evitar novas tragedias.

Ate hoje, o Massacre de Las Vegas e lembrado como um dos episodios mais violentos da historia moderna dos Estados Unidos, deixando um legado de dor e questionamentos sobre a facilidade de acesso a armas de alto poder destrutivo.', 'https://g1.globo.com/mundo/noticia/veja-quem-e-stephen-paddock-o-atirador-de-las-vegas.ghtml', 'https://www.bbc.com/portuguese/brasil-41467442', 'Crime Hediondo', 'anos 2010', 2017, FALSE);


    --decadas de 2020
    INSERT INTO news (title, description, text, link, image, category, decade, year, is_featured)
    VALUES 
    ('Caso da trapezista argentina',
    'Em dezembro de 2023, Florencia Aranguren foi brutalmente assassinada a facadas enquanto passeava com o cachorro em Búzios, RJ.',
    'Carlos José foi preso em flagrante e condenado a 33 anos de prisão. O corpo da trapezista foi encontrado em uma trilha e o cão permaneceu ao lado da vítima até a chegada das autoridades.',
    'https://www.condorcontabilidade.com.br/nb2/rj/regiao-dos-lagos/noticia/2025/04/03/julgamento-marcado-acusado-de-matar-trapezista-argentina-em-buzios-enfrenta-o-tribunal-do-juri-no-dia-9-de-abril.ghtml',
    'Trapezistaargentina.jpeg',
    'Homicídio', '2020s', 2023, FALSE),

    ('Caso do menino arremessado da ponte pelo pai',
    'Em março de 2025, um homem arremessou o próprio filho de cinco anos de uma ponte em São Gabriel, RS, em um ato de vingança contra a ex-esposa.',
    'Ele confessou o crime e está preso.',
    'https://www.cnnbrasil.com.br/wp-content/uploads/sites/12/2025/03/cantor-afogado-pe-2-2.jpg?w=1115',
    'MeninoArremessado.jpeg',
    'Homicídio', '2020s', 2025, FALSE),

    ('Caso do motorista de app em SP',
    'Em março de 2025, um motorista de aplicativo foi preso após tentar estuprar e roubar uma passageira de 21 anos no bairro da Casa Verde, zona norte de São Paulo.',
    'A vítima conseguiu fugir e o homem foi preso.',
    'https://s2-g1.glbimg.com/JTYtBLWhlDV-pnM6l5rMDQd31mc=/1280x0/filters:format(jpeg)/https://thumbor.globoi.com/unsafe/fit-in/1280x720/s03.video.glbimg.com/deo/vi/54/13/13491354',
    'MotoristadeApp.jpeg',
    'Violência Sexual', '2020s', 2025, FALSE),

    ('Caso Clara Maria em MG',
    'Em março de 2025, Clara Maria, de 21 anos, foi encontrada morta e concretada em uma casa em Belo Horizonte.',
    'Os suspeitos Thiago e Pimentel foram presos após confessarem o crime.',
    'https://www.cnnbrasil.com.br/wp-content/uploads/sites/12/2025/03/Clara-Maria.jpg?w=880',
    'Clara Maria.jpeg',
    'Homicídio', '2020s', 2025, FALSE),

    ('Caso do cantor morto afogado em PE',
    'Em fevereiro de 2025, um cantor foi encontrado morto após se afogar em um rio em Pernambuco.',
    'A polícia investiga as circunstâncias do afogamento e se houve envolvimento de terceiros.',
    'https://www.cnnbrasil.com.br/wp-content/uploads/sites/12/2025/03/cantor-afogado-pe-2-2.jpg?w=1115',
    'CantorAfogado.jpeg',
    'Morte Suspeita', '2020s', 2025, FALSE),

    ('Filho mata pai alcoólatra em SC',
    'Em fevereiro de 2025, um homem de 23 anos matou o pai de 47 anos a golpes de tesoura em São João Batista, SC.',
    'A vítima foi encontrada com 22 perfurações. O suspeito se entregou à polícia após o crime.',
    'https://static.ndmais.com.br/2025/02/identificado-homem-morto-por-filho-a-tesouradas-sao-joao-batista-grande-florianopolis-elvis-marcos-da-silva-800x467.jpg',
    'Filhomatapaialcoolatra.jpeg',
    'Homicídio', '2020s', 2025, FALSE);


INSERT INTO podcasts (title, description, link, image, category, is_featured)
VALUES 
('Crime Junkie', 'Podcast semanal dedicado a cobrir casos de crimes reais.', 'https://open.spotify.com/show/3DgfoleqaW61T2amZQKINx', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTC3zmZm2qANnrB1IJ3qbjpzcfJmfVYrYUaLQ&s', 'impactante', TRUE),
('Crimecast', 'Podcast sobre crimes reais, abordando historias conhecidas no Brasil e no mundo.', 'https://open.spotify.com/show/07MoJXc7KpasBvDSJVOMw8', 'https://cdn-images.dzcdn.net/images/talk/08fcb47cb1970a881f34258fc451b553/1900x1900-000000-80-0-0.jpg', 'investigacao', TRUE),
('Real Crime', 'Documentarios completos sobre crimes, gangsters, serial killers e as pessoas mais infames da historia.', 'https://open.spotify.com/show/0JLjqhHBRN8qMTGKikm97B', 'https://m.media-amazon.com/images/I/91O+l7tjmdL._AC_UF894,1000_QL80_.jpg', 'casos reais', FALSE),
('Crimes Reais: Telma Rocha, Edu Tachlitsky e Leandro Lopes', 'Discussao sobre crimes reais no Brasil com especialistas.', 'https://www.youtube.com/watch?v=SCYsS6VgxPY', 'https://i.ytimg.com/vi/u6iCbtzIGM4/maxresdefault.jpg', 'famoso', TRUE),
('Crimes Reais: Ricardo Salada e Jorge Lordello', 'Analise de casos criminais com especialistas.', 'https://www.youtube.com/watch?v=aPEYYaR8hVY', 'https://i.ytimg.com/vi/aPEYYaR8hVY/maxresdefault.jpg', 'impactante', FALSE),
('Crimes Reais: Telma Rocha', '2 horas ouvindo crimes reais contados pela fotografa Telma Rocha', 'https://www.youtube.com/live/PPWehNBYq_M?feature=shared', 'https://conteudo.imguol.com.br/c/noticias/69/2024/10/24/fotografa-tecnico-pericial-telma-rocha-do-dhpp-departamento-estadual-de-homicidios-e-de-protecao-a-pessoa-no-podcast-inteligencia-ltda-em-27-de-agosto-de-2024-1729808672617_v2_900x506.png', 'famoso', FALSE),
('Marcia Lanze descobre morte atraves do tik tok', 'Ele foi pego pelo TikTok! Bruno Eustaquio ligou para a policia depois de encontrar a mae, Marcia Lanzane, morta. Porem, durante as investigacoes, os agentes descobriram uma dinamica chocante: a mulher havia sido assassinada pelo proprio filho, que, depois de cometer o crime, foi para a sala e ficou assistindo televisao.', 'https://youtu.be/XKJ7Zzmifig?feature=shared', 'https://i.ytimg.com/vi/1M6QBfFAq7I/maxresdefault.jpg', 'impactante', TRUE),
('Chacina da Candelaria - Execucao das criancas de rua no RJ', 'Em 1993, oito criancas e adolescentes em situacao de rua foram mortos brutalmente em frente a Igreja da Candelaria, no Rio de Janeiro, em um crime que chocou o pais e expos violencia policial.', 'https://www.youtube.com/watch?v=zf7Er2Nthto', 'https://www.fflch.usp.br/sites/fflch.usp.br/files/2022-07/HnH_23.07.jpg', 'crimes antigos', TRUE);

INSERT INTO podcasts (title, description, link, image, category, is_featured)
VALUES 
('Doutora Luiza - ela atuou em lugares que mudaram o Brasil', 'Ela atuou em casos que pararam o Brasil! Luisa Muchon e uma experiente advogada criminalista, que ja trabalhou com casos de grande repercussao e conheceu de perto figuras emblematica do pais. Alem de ter sido advogada do casal Nardoni, foi a ultima pessoa a conversar com Farah Jorge Farah e representou diversos nomes associados a Operacao Lava Jato.', 'https://youtu.be/NhK_MjWjxsU?feature=shared', 'https://is3-ssl.mzstatic.com/image/thumb/Podcasts112/v4/5f/fd/21/5ffd2174-6076-f55b-27bc-2daf7a0e93ca/mza_7189227837507334208.jpg/1200x1200bb.jpg', 'famoso', TRUE),
('Caso Vitoria Regina - Detalhes da investigacao', 'Confira minha entrevista com o advogado da familia de Vitoria Regina de Sousa, morta entre o final de fevereiro e comeco de marco de 2025, em circunstancias, no minimo, estranhas. A policia colocou o vizinho da familia, Maicol Sales do Santos, como unico suspeito e autor de tudo.', 'https://youtu.be/-W78mbchJbw?feature=shared', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSYW7tHdUdbmvozHaVKUCb5hQcvrdzn4Ma8bQ&s', 'investigacao', TRUE),
('Crimes Reais: Ullisses Campbell e Beto Ribeiro', 'ULLISSES CAMPBELL e escritor, e BETO RIBEIRO e diretor e roteirista. Eles vao contar historias e destrinchar crimes reais, como o caso da Suzane Von Richthofen. Agora que Suzane foi solta da cadeia, o Vilela ja reforcou a seguranca do porao, ja que ele tem idade pra ser pai dela.', 'https://www.youtube.com/live/zU8Ahy3zL1c?feature=shared', 'https://i.ytimg.com/vi/zU8Ahy3zL1c/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLA0OXMP6xTmt11FYsC51hkilk9inA', 'casos reais', TRUE),
('Crimes Reais: O caso mais pesado', 'TELMA ROCHA e fotografa pericial, e EDU TACHLITSKY e LEANDRO LOPES sao peritos criminais do Departamento de Homicidios e Protecao a Pessoa de Sao Paulo. Eles vao esclarecer muitas duvidas sobre os bastidores dos crimes mais conhecidos e tambem os mais curiosos. O Vilela que seu cuide, pois ele esta sempre em minoria no porao.', 'https://youtu.be/7x0UoLX4kmQ?feature=shared', 'https://i.ytimg.com/vi/7x0UoLX4kmQ/maxresdefault.jpg', 'crimes antigos', TRUE),
('Crimes Reais: Ricardo Salada, Telma Rocha e Rafael Heck', 'RICARDO SALADA, TELMA ROCHA E RAFAEL HECK sao peritos criminais. Eles trabalham no DHPP (Departamento de Homicidios e de Protecao a Pessoa) do estado de SP e vao bater um papo sobre crimes reais. Ja o Vilela presenciou varios crimes do passado.', 'https://www.youtube.com/live/17PwIYnL28Y?feature=shared', 'https://i.ytimg.com/vi/17PwIYnL28Y/maxresdefault.jpg', 'crimes antigos', TRUE),
('Telma Rocha e Andre Davila', 'Neste podcast Telma Rocha e Andre Davila abordam questoes cruciais relacionadas ao crime, a seguranca publica e aos desafios enfrentados pela sociedade contemporanea.', 'https://youtu.be/azFRrtdUnvE?feature=shared', 'https://i.ytimg.com/vi/azFRrtdUnvE/sddefault.jpg?v=6362b027', 'crimes antigos', TRUE),
('Crimes Reais: Ricardo Ventura e Ricardo Salada', 'RICARDO VENTURA e psicanalista e RICARDO SALADA e perito criminal. Hoje descobriremos mutas tecnicas de como pegar o mentiroso e o bandido com as calcas na mao. A Mari deveria assistir a essa live, pois e obvio que o Vilela vai pisar na bola.', 'https://www.youtube.com/live/rMT78xVz_Qc?feature=shared', 'https://i.ytimg.com/vi/rMT78xVz_Qc/maxresdefault.jpg', 'crimes antigos', TRUE),
('Caso Eloa Cristina - Sequestro e feminicidio ao vivo em SP', 'O sequestro e assassinato da jovem Eloa Cristina em 2008 por seu ex-namorado foi transmitido ao vivo pela midia, levantando debates sobre violencia contra a mulher e atuacao policial.', 'https://www.youtube.com/watch?v=wBJw-VEatrE', 'https://rollingstone.com.br/media/_versions/2023/05/caso-eloa-linha-direta-globo-foto-reproducao_widemd.jpg', 'famoso', TRUE),
('Caso Pedrinho - Sequestro e reencontro apos 16 anos em Brasilia', 'Pedrinho foi sequestrado ainda bebe e reencontrou sua familia biologica somente apos 16 anos. Este caso comoveu o Brasil e revelou complexidades juridicas e emocionais.', 'https://www.youtube.com/watch?v=HtcNWv_4zOE', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRPiXrPOseKza-Dz9zIrPYk4yKWrApRkIT0jg&s', 'casos reais', TRUE);

INSERT INTO podcasts (title, description, link, image, category, is_featured)
VALUES 
('Crimes Reais: Ivan Mizanzuk', 
 'Ivan Mizanzuk e professor universitario, designer, escritor, produtor de podcasts e jornalista. Ele conta "historias reais de pessoas reais" no podcast Projeto Humanos. Ja o Vilela so contrata projetos de humanos para trabalharem com ele.', 
 'https://youtu.be/UywLajXBLw4?feature=shared', 
 'https://vejasp.abril.com.br/wp-content/uploads/2023/08/Ilana-Casoy-Erik-Almeida-Divulgac%CC%A7a%CC%83o.jpg.jpg?crop=1&resize=1212,909', 
 'casos reais', TRUE),

('Ela cuida das mentes mais perturbadas - Gabriela Cruz', 
 'Ela conhece a mente dos pedofilos! Gabriela Cruz e uma renomada psicologa especialista em sexualidade humana. Antes de atender em clinicas, ela trabalhou durante anos em penitenciarias, acompanhando individuos condenados por pedofilia e outros crimes sexuais.', 
 'https://youtu.be/mdwQUT0i5dc?feature=shared', 
 'https://i.ytimg.com/vi/mdwQUT0i5dc/maxresdefault.jpg', 
 'investigacao', TRUE),

('Crimes reais: Perita Rosangela Monteiro e Delegado Mauro Dias', 
 'Dra. Rosangela e psicologa e perita criminal, e MAURO DIAS e ex-delegado. Eles vao conversar sobre crimes reais e os processos de investigacao e pericia para desvendar os casos. O Vilela e expert em esconder que comeu todo o chocolate da casa que nem um CSI Sao Paulo resolveria o caso.', 
 'https://www.youtube.com/live/28WQA1o1CDQ?feature=shared', 
 'https://i.ytimg.com/vi/28WQA1o1CDQ/maxresdefault.jpg', 
 'investigacao', TRUE),

('Crimes Reais: Caso Nardoni', 
 'Discussao sobre o assassinato de Isabella Nardoni.', 
 'https://www.youtube.com/watch?v=1XyODZb7APk', 
 'https://f.i.uol.com.br/fotografia/2018/03/12/15209076785aa7359ecb363_1520907678_3x2_xl.jpg', 
 'casos reais', TRUE),

('Crimes Reais: Caso Marisia e Marcos Matsunaga', 
 'Investigacao sobre o assassinato de Marisia e Marcos Matsunaga.', 
 'https://www.youtube.com/watch?v=skj1q8v-f8k', 
 'https://s2-oglobo.glbimg.com/yqppgndr5hdBMscIOL-7ioLS2LM=/0x0:620x415/984x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_da025474c0c44edd99332dddb09cabe8/internal_photos/bs/2023/5/p/3jKTd5TzGIg9jBqCYRLA/63080943.jpg', 
 'investigacao', FALSE),

('Caso Mangue 937: Executadas no Mangue', 
 'Em 2 de marco de 2018, tres mulheres foram sequestradas, torturadas e decapitadas em um manguezal proximo ao Rio Ceara, em Fortaleza. O crime foi registrado em video e teve ampla repercussao nas redes sociais. O podcast investiga os detalhes do caso, os envolvidos e as consequencias legais.',
 'https://www.youtube.com/watch?v=UywLajXBLw4',
 'https://upload.wikimedia.org/wikipedia/pt/thumb/c/cc/As_3_v%C3%ADtimas_do_Caso_Mangue_937.jpg/320px-As_3_v%C3%ADtimas_do_Caso_Mangue_937.jpg',
 'famoso', TRUE),

('Jogada no lixo, vendida para homens, queimada vida', 
 'Ela nasceu Larissa Duque e hoje se tornou Heloisa. Tudo para fugir da mae narcisista que criou um enredo de vida e morte para a filha. Ela conseguiu mais que sobreviver, viver e vencer a progenitora que, logo ao dar a luz, jogou Heloisa no lixo. E esse foi so o comeco...', 
 'https://youtu.be/Kb0tZnF1IhU?feature=shared', 
 'https://s2-marieclaire.glbimg.com/1rLIfRAqEFgS2H8aepmgANIRAEw=/0x0:591x332/600x0/smart/filters:gifv():strip_icc()/i.s3.glbimg.com/v1/AUTH_51f0194726ca4cae994c33379977582d/internal_photos/bs/2024/g/9/NDBA7iTkGLEx2LkK6lsw/larissa-duque-pequena.png', 
 'investigacao', TRUE),

('Crimes Reais: Ju Cassini e Giovanna Alba', 
 'JU CASSINI e GIOVANNA ALBA sao YouTubers. Elas vao bater um papo sobre os crimes reais da atualidade. O Vilela tem tanto medo de violencia que dorme de capacete.', 
 'https://www.youtube.com/live/HnCFLkqkSHc?feature=shared', 
 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTiYQNlmkbbRztXKmmdhXXVIBlVEMeGEDstHg&s', 
 'casos reais', TRUE);


INSERT INTO podcasts (title, description, link, image, category, is_featured)
VALUES 

('Crimes Reais: Ju Cassini e Beto', 
 'JU CASSINI e YouTuber e BETO RIBEIRO e diretor e roteirista. Eles vao bater um papo sobre crimes reais com historias assustadoras, bizarras e misteriosas. O Vilela ja se preparou e comprou mais fraldas geriatricas pra trocar nessa live.', 
 'https://www.youtube.com/live/n9YXRqNtows?feature=shared', 
 'https://i.ytimg.com/vi/n9YXRqNtows/maxresdefault.jpg', 
 'famoso', TRUE),

('Caso Familia Goncalves', 
 'Em uma noite comum de janeiro de 2020, em Sao Bernardo do Campo, no Grande ABC de Sao Paulo, Flaviana Goncalves chegava em casa do trabalho quando encontrou sua familia rendida por tres ladroes. O Romoyuki, o marido, Juan, o filho adolescente, Anaflavia, a filha e a namorada de sua filha, Carina, todos estavam sob a mira dos assaltantes. Flaviana foi levada ao quarto para passar suas senhas de banco, quando foi morta ao lado do cacula e do esposo.', 
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
 'https://emtempo.com.br/wp-content/uploads/2023/11/b0aaf3e3-5012-44bb-ade6-6d1e45e3297c.jpg', 
 'impactante', TRUE),

('A Mulher da Casa Abandonada', 
 'Chico Felitti investiga o misterio de uma mulher que vive em uma mansao decadente em Higienopolis, SP. Ao longo da serie, revela-se que ela e foragida do FBI, acusada de manter uma mulher em regime de escravidao nos EUA. O podcast explora temas de racismo, privilegio e impunidade.', 
 'https://www1.folha.uol.com.br/podcasts/2022/06/a-mulher-da-casa-abandonada-ouca-o-podcast.shtml', 
 'https://www.cartacapital.com.br/wp-content/uploads/2022/07/A-mulher-da-casa-abandonada.jpg', 
 'impactante', TRUE);

    INSERT INTO videos (title, description, link, image, category, is_featured)
    VALUES 
    ('Caso Evandro', 'Serie documental sobre o desaparecimento de Evandro Ramos Caetano em 1992.', 'https://www.youtube.com/watch?v=XkoJiUI6jNg', 'https://i.ytimg.com/vi/XkoJiUI6jNg/maxresdefault.jpg', 'Investigacao', TRUE),
    ('Caso Daniel Alves', 'Noticia sobre a absolvicao de Daniel Alves da acusacao de estupro.', 'https://www.youtube.com/watch?v=3Hs4beu3Pr8', 'https://i.ytimg.com/vi/3Hs4beu3Pr8/maxresdefault.jpg', 'Recente', TRUE),
    ('Boate Kiss: Tragedia de Santa Maria', 'Documentario sobre o incendio na Boate Kiss que matou 242 pessoas.', 'https://www.youtube.com/watch?v=MCvD2tGSvSg', 'https://i.ytimg.com/vi/MCvD2tGSvSg/maxresdefault.jpg', 'Impactante', FALSE),
    ('Pacote Anticrime', 'Analise das mudancas trazidas pelo Pacote Anticrime na legislacao penal.', 'https://www.youtube.com/watch?v=PBtEWKVzxjk', 'https://i.ytimg.com/vi/PBtEWKVzxjk/maxresdefault.jpg', 'Leis', FALSE),
    ('Suzane von Richthofen', 'Documentario sobre o assassinato dos pais de Suzane von Richthofen.', 'https://www.youtube.com/watch?v=Iv572FJpZSc', 'https://i.ytimg.com/vi/Iv572FJpZSc/maxresdefault.jpg', 'Crime', TRUE),
    ('Operacao Lava Jato', 'Especial sobre os 10 anos da Operacao Lava Jato e seus desdobramentos.', 'https://www.youtube.com/watch?v=xaiPHbjRTmE', 'https://i.ytimg.com/vi/xaiPHbjRTmE/maxresdefault.jpg', 'Investigacao', TRUE),
    ('Caso Lazaro Barbosa', 'Cobertura da cacada policial a Lazaro Barbosa em 2021.', 'https://www.youtube.com/watch?v=R6OGs5YQvKU', 'https://i.ytimg.com/vi/R6OGs5YQvKU/maxresdefault.jpg', 'Recente', TRUE),
    ('Joao de Deus: Condenacao', 'Noticia sobre a condenacao de Joao de Deus por crimes de estupro.', 'https://www.youtube.com/watch?v=8zFQn_Z1o-I', 'https://i.ytimg.com/vi/8zFQn_Z1o-I/maxresdefault.jpg', 'Investigacao', FALSE),
    ('Caso Miguel', 'Reportagem sobre a morte do menino Miguel e a responsabilidade da patroa.', 'https://www.youtube.com/watch?v=9BijzzxvENA', 'https://i.ytimg.com/vi/9BijzzxvENA/maxresdefault.jpg', 'Crime', TRUE),
    ('Chacina da Candelaria', 'Analise do massacre de oito jovens em frente a Igreja da Candelaria.', 'https://www.youtube.com/watch?v=SJHxESnm6Ys', 'https://i.ytimg.com/vi/SJHxESnm6Ys/maxresdefault.jpg', 'Impactante', FALSE),
    ('Caso Amarildo', 'Reportagem sobre o desaparecimento do pedreiro Amarildo na Rocinha.', 'https://www.youtube.com/watch?v=7ujN1Z717sY', 'https://i.ytimg.com/vi/7ujN1Z717sY/maxresdefault.jpg', 'Investigacao', FALSE),
    ('Assassinato de Celso Daniel', 'Investigacao sobre o assassinato do prefeito Celso Daniel.', 'https://www.youtube.com/watch?v=zM1a1eVPO4Q', 'https://i.ytimg.com/vi/zM1a1eVPO4Q/maxresdefault.jpg', 'Crime', TRUE);

    INSERT INTO videos (title, description, link, image, category, is_featured)
    VALUES 
    ('Caso Isabele Ramos', 'Cobertura sobre a morte da adolescente Isabele Ramos em Cuiaba.', 'https://www.youtube.com/watch?v=rt7W8zsSxDg', 'https://i.ytimg.com/vi/rt7W8zsSxDg/maxresdefault.jpg', 'Crime', FALSE),
    ('Caso Isabella Nardoni','Documentario detalhado sobre o famoso caso Isabella Nardoni, apresentando bastidores da investigacao policial e analises forenses.','https://youtu.be/oIMfGiqKdII?feature=shared', 'https://s2-g1.glbimg.com/VaNENbf6ghC8-p9xOqyDRJivniU=/323x0:1000x450/984x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_59edd422c0c84a879bd37670ae4f538a/internal_photos/bs/2024/u/i/LMzJvPQciWhqG1bNrPtw/ana-carolina-oliveira-isabella-nardoni-e-alexandre-nardoni.jpg','Investigacao', TRUE),
    ('Caso de Marielle Franco', 'Entenda os detalhes do assassinato da vereadora Marielle Franco, um crime recente que mobilizou investigacoes federais.', 'https://youtu.be/7FBIXSKTlPo?feature=shared', 'https://s01.video.glbimg.com/640x360/6585500.jpg', 'Recente', TRUE),
    ('Caso Henry Borel', 'Documentario sobre a morte do menino Henry Borel, um dos crimes mais recentes e comentados no Brasil.', 'https://youtu.be/YZQcbx9VHfg?feature=shared', 'https://assets.brasildefato.com.br/2024/09/image_processing20210412-10498-1yhvipb.jpeg', 'Recente', FALSE),
    ('Caso Daniel Correa', 'Analise completa do assassinato do jogador Daniel Correa, incluindo a investigacao e julgamento dos envolvidos.', 'https://youtu.be/e7njAbFZP2o?feature=shared', 'https://s2-oglobo.glbimg.com/J-FB_Ygbn-TLRTg3tp9Z2Lx-QxM=/0x0:7169x2555/888x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_da025474c0c44edd99332dddb09cabe8/internal_photos/bs/2024/q/k/luztrlS7eOwGMITiP2sA/arte-43-.png', 'Recente', FALSE),
    ('Caso Rafael Miguel', 'Confira os detalhes do assassinato de Rafael Miguel e seus pais, um crime recente que chocou o Brasil.', 'https://youtu.be/RwZ-A8niBNc?feature=shared', 'https://s2-g1.glbimg.com/PEBjkyz6fqx3sHJmuztD3ICDxGI=/696x390/smart/filters:cover():strip_icc()/i.s3.glbimg.com/v1/AUTH_59edd422c0c84a879bd37670ae4f538a/internal_photos/bs/2022/V/B/9UOff0QIq2A5gu5zpE6g/paulo-cupertino-e-rafael-miguel.jpg', 'Recente', FALSE),
    ('Caso Eloa', 'Relembre o caso Eloa, um dos sequestros mais longos e dramaticos da historia do Brasil, com grande repercussao nacional.', 'https://youtu.be/J0dpDynvp80?feature=shared', 'https://s2-g1.glbimg.com/CxloZ9okEVV5tI8NOAg15-tpPNo=/0x0:1022x592/984x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_59edd422c0c84a879bd37670ae4f538a/internal_photos/bs/2023/1/f/U7V2JoQ9qejv1IZa3yog/linha-direta-eloa.jpg', 'Impactante', TRUE),
    ('Caso Suzane Richthofen', 'Documentario sobre o impactante caso Suzane Richthofen, que chocou o Brasil pelo envolvimento da filha no assassinato dos proprios pais.', 'https://youtu.be/Qc0-WnFkTOI?feature=shared', 'https://aventurasnahistoria.com.br/media/uploads/curiosidades/suzane2.jpg', 'Impactante', TRUE),
    ('Caso Maniaco do Parque', 'A historia do Maniaco do Parque, um dos maiores serial killers do Brasil, cujos crimes impactaram a sociedade.', 'https://youtu.be/kfa4tuoQbHU?feature=shared', 'https://cj.estrategia.com/portal/wp-content/uploads/2024/11/02151420/formato-foto-do-site-rolling-5_unh8c604_widelg.png', 'Impactante', TRUE);

    INSERT INTO videos (title, description, link, image, category, is_featured)
    VALUES 
    ('Caso Bernardo Boldrini', 'Conheca os detalhes do caso Bernardo Boldrini, o crime brutal que chocou o pais pela frieza dos envolvidos.', 'https://youtu.be/lIwdvGH5o3Y?feature=shared', 'https://s2-g1.glbimg.com/XNquO1qbF_WpMtlChgaPdyKczKY=/1920x0/filters:format(jpeg)/https://i.s3.glbimg.com/v1/AUTH_59edd422c0c84a879bd37670ae4f538a/internal_photos/bs/2025/g/M/pDkhOZQziS5Q6vYeTSBw/g1-2025-04-22t202310.436.png', 'Impactante', FALSE),
    ('O que e o Codigo Penal Brasileiro?', 'Entenda o que e e como funciona o Codigo Penal Brasileiro, suas principais caracteristicas e importancia para o sistema juridico.', 'https://youtu.be/Vg6-jwQi3pg?feature=shared', 'https://i.pinimg.com/originals/09/98/40/099840c9970991f99851580ab620c10a.jpg', 'Leis', TRUE),
    ('Lei Maria da Penha', 'Saiba tudo sobre a Lei Maria da Penha, uma das legislacoes mais importantes para o combate a violencia domestica no Brasil.', 'https://youtu.be/tuT__DRuG-U?feature=shared', 'https://images01.brasildefato.com.br/d358d429e3a96b1a1474080a9238ec0c.jpeg', 'Leis', TRUE),
    ('Entenda a Lei do Estupro no Brasil', 'Explicacao didatica sobre o que diz a lei sobre estupro no Brasil, incluindo penas e definicoes legais.', 'https://youtu.be/_e6_SxuCerM?feature=shared', 'https://revistapesquisa.fapesp.br/wp-content/uploads/2022/09/016-025_capa-estupro_320-2-1140-abre2.jpg', 'Leis', TRUE),
    ('Como Funcionam as Leis no Brasil?', 'Veja uma explicacao geral sobre o processo de criacao, aprovacao e funcionamento das leis no Brasil.', 'https://youtu.be/pC-D6sSI904?feature=shared', 'https://ekccopwh4gz.exactdn.com/wp-content/uploads/2018/02/leis-do-brasil-300x200.jpg?lossy=1&ssl=1', 'Leis', FALSE),
    ('Documentario - O que e Justica?', 'Documentario que explora o conceito de justica, trazendo diferentes visoes filosoficas, juridicas e sociais sobre o tema.', 'https://youtu.be/9_3PC-CLGzA?feature=shared', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTS83oXXezuPxcMlMaVBXmlPQEozuVeWHslJQ&s', 'Leis', FALSE),
    ('Caso Madeleine McCann', 'Acompanhe a investigacao do desaparecimento de Madeleine McCann, um dos casos mais misteriosos e debatidos no mundo, com detalhes das buscas e teorias.', 'https://youtu.be/Affj8j3ITBA?feature=shared', 'https://s2-g1.glbimg.com/Rk3yebs1Y1pTIXCBkzCRA4u2hiU=/0x0:640x360/984x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_59edd422c0c84a879bd37670ae4f538a/internal_photos/bs/2022/A/Q/e5VE99R42ACuQcSPo5bA/thumbnail-image001-1-.jpg', 'Investigacao', FALSE),
    ('Caso de Daniella Perez', 'Entenda como foi o assassinato da atriz Daniella Perez, um dos crimes mais marcantes do Brasil na decada de 90.', 'https://youtu.be/8h2jWwSpIAg?feature=shared', 'https://s2.glbimg.com/-6DSugb9dLeUTy_Y4yOjACJRk94=/600x0/filters:quality(70)/i.s3.glbimg.com/v1/AUTH_da025474c0c44edd99332dddb09cabe8/internal_photos/bs/2022/E/L/FdCKeyTmaQxLHI5atsHA/61507276-rio-de-janeiro-rj-11-11-1992-televisao-rj-tv-globo-novela-de-corpo-e-alma-g.jpg', 'Crime', FALSE),
    ('Chacina de Realengo', 'Tragedia ocorrida em uma escola municipal no Rio de Janeiro em 2011.', 'https://youtu.be/1z0E6MzLdrA?feature=shared', 'https://ichef.bbci.co.uk/ace/ws/640/cpsprodpb/5EAC/production/_117863242_b01b7ab3-f0e8-41a6-8010-408afc54da7e.jpg.webp', 'Crime', FALSE);

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
        ('Luiz Gabriel Lopes Carvalho', 'Desenvolvedor (a)', 'https://github.com/juguarnieri/site-ingles/blob/main/img/luiz.jpg?raw=true', 1),
        ('Carlos Eduardo Ferraz Augusto', 'Desenvolvedor (a)', 'https://avatars.githubusercontent.com/u/158209729?s=400&u=ea58c944f794b2851f01abda7ad25341d06255dc&v=4', 1);


        ALTER TABLE likes ADD CONSTRAINT unique_user_post UNIQUE (user_id, post_id);



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
(1, 'Qual foi o principal erro apontado na condução do caso Evandro, que chocou o Brasil nos anos 1990?'),
(2, 'Suzane von Richthofen foi condenada por:'),
(3, 'Qual prova foi essencial para a condenação do casal Nardoni?'),
(4, 'Onde desapareceu Madeleine McCann?'),
(5, 'Qual era o perfil criminal de Jeffrey Dahmer?'),
(6, 'A Lei Maria da Penha foi criada com o objetivo de:'),
(7, 'O assassinato de George Floyd gerou:'),
(8, 'Qual foi a condenação de Alexandre Nardoni?'),
(9, 'O erro mais criticado da polícia no caso Eloá foi:'),
(10, 'Marielle Franco foi assassinada por motivos ligados a:'),
(11, 'Qual foi uma das inovações trazidas pela Lei Anticrime?'),
(12, 'Cesare Battisti foi:'),
(13, 'O goleiro Bruno foi condenado pelo assassinato de:'),
(14, 'O julgamento de O.J. Simpson ficou famoso por:'),
(15, 'Qual foi a principal causa das mortes na Boate Kiss?'),
(16, 'O assassinato de João Hélio gerou discussão sobre:'),
(17, 'O Crime de Hanau (Alemanha, 2020) teve como motivação:'),
(18, 'Quantos presos morreram no massacre do Carandiru em 1992?'),
(19, 'A investigação sobre a morte de JonBenét Ramsey foi criticada por:'),
(20, 'O que resultou na morte de jovens em um baile funk em Paraisópolis (2019)?');

INSERT INTO alternatives (question_id, alternative_text, is_correct) VALUES
(1, 'Prisões sem mandado judicial', FALSE),
(1, 'Coleta ilegal de provas técnicas', FALSE),
(1, 'Confissões obtidas sob tortura', TRUE),
(1, 'Ausência de julgamento público', FALSE),

(2, 'Estelionato contra os pais', FALSE),
(2, 'Envolvimento em sequestro', FALSE),
(2, 'Participação no assassinato dos pais', TRUE),
(2, 'Tráfico de entorpecentes', FALSE),

(3, 'Mensagens de celular', FALSE),
(3, 'Pegadas no parapeito e sangue no carro', TRUE),
(3, 'Testemunho de um vizinho', FALSE),
(3, 'Bilhete de confissão', FALSE),

(4, 'França', FALSE),
(4, 'Alemanha', FALSE),
(4, 'Portugal', TRUE),
(4, 'Espanha', FALSE),

(5, 'Assassino em massa por motivação política', FALSE),
(5, 'Serial killer e canibal', TRUE),
(5, 'Líder de seita religiosa', FALSE),
(5, 'Ladrão de bancos reincidente', FALSE),

(6, 'Proteger crianças de abuso sexual', FALSE),
(6, 'Combater o feminicídio em locais públicos', FALSE),
(6, 'Prevenir e punir a violência doméstica contra a mulher', TRUE),
(6, 'Criminalizar o assédio moral no trabalho', FALSE),

(7, 'Reforma fiscal nos EUA', FALSE),
(7, 'Movimentos antirracistas globais', TRUE),
(7, 'Proibição do uso de armas de fogo', FALSE),
(7, 'Reestruturação da OTAN', FALSE),

(8, 'Absolvido por falta de provas', FALSE),
(8, '15 anos por homicídio culposo', FALSE),
(8, '31 anos por homicídio triplamente qualificado', TRUE),
(8, 'Prisão perpétua', FALSE),

(9, 'Não emitir alerta nacional', FALSE),
(9, 'Atuar sem autorização judicial', FALSE),
(9, 'Permitir a entrada de Nayara no cativeiro', TRUE),
(9, 'Agir sem colete à prova de balas', FALSE),

(10, 'Disputa familiar', FALSE),
(10, 'Denúncias contra milícias', TRUE),
(10, 'Desacato a autoridade', FALSE),
(10, 'Fraude eleitoral', FALSE),

(11, 'Redução de penas mínimas', FALSE),
(11, 'Criação do juiz de garantias', TRUE),
(11, 'Extinção da delação premiada', FALSE),
(11, 'Revogação da prisão temporária', FALSE),

(12, 'Um militante ambiental italiano', FALSE),
(12, 'Um espião da Guerra Fria', FALSE),
(12, 'Um ex-ativista italiano condenado por terrorismo', TRUE),
(12, 'Um diplomata refugiado', FALSE),

(13, 'Sua esposa', FALSE),
(13, 'Um torcedor', FALSE),
(13, 'Um técnico de futebol', FALSE),
(13, 'Eliza Samudio, ex-companheira', TRUE),

(14, 'Ser televisionado mundialmente', TRUE),
(14, 'Envolver evidências plantadas', FALSE),
(14, 'Ser julgado por tribunal militar', FALSE),
(14, 'Levar à pena de morte', FALSE),

(15, 'Falha estrutural do prédio', FALSE),
(15, 'Briga generalizada com tiros', FALSE),
(15, 'Incêndio causado por artefato pirotécnico', TRUE),
(15, 'Envenenamento coletivo', FALSE),

(16, 'Redução da maioridade penal', TRUE),
(16, 'Pena de morte no Brasil', FALSE),
(16, 'Porte de arma para civis', FALSE),
(16, 'Limites da justiça restaurativa', FALSE),

(17, 'Conflitos religiosos', FALSE),
(17, 'Terrorismo racial e xenofobia', TRUE),
(17, 'Roubo em massa de bancos', FALSE),
(17, 'Protesto contra vacinas', FALSE),

(18, '31', FALSE),
(18, '72', FALSE),
(18, '111', TRUE),
(18, '201', FALSE),

(19, 'Julgamento sem júri', FALSE),
(19, 'Falta de coleta de provas iniciais', TRUE),
(19, 'Condenação injusta dos pais', FALSE),
(19, 'Arquivamento imediato', FALSE),

(20, 'Desabamento do palco', FALSE),
(20, 'Ataque de facção criminosa', FALSE),
(20, 'Ação policial mal conduzida', TRUE),
(20, 'Curto-circuito elétrico', FALSE);
