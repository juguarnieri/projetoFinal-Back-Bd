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
(1, 'Meu primeiro post!', 'Curtindo o dia na praia 🌊', '/uploads/praia.jpeg'),
(2, 'Trabalho novo!', 'Começando um novo desafio 🚀', '/uploads/desafio.jpeg'),
(3, 'Look do dia', 'Pronta pra sair ✨', '/uploads/sair.jpeg'),
(1, 'Amanhecer na praia', 'Começando o dia com essa vista maravilhosa!', '/uploads/amanhecer.jpeg'),
(2, 'Trilha na montanha', 'Desafio superado! A vista lá de cima é incrível.', '/uploads/montanha.jpeg'),
(3, 'Café da manhã', 'Nada melhor que um café quentinho pela manhã.', 'https://pixabay.com/get/ea33b70b2efb1c22d2524518b7484f91e17ee3d21cac104496f0c07fa4e1b0_640.jpg'),
(4, 'Leitura do dia', 'Começando o dia com uma boa leitura.', 'https://pixabay.com/get/ea33b70b2efb1c22d2524518b7484f91e17ee3d21cac104496f0c07fa4e1b0_640.jpg'),
(5, 'Meu pet', 'Apresento o Max, meu fiel amigo!', 'https://pixabay.com/get/ea33b70b2efb1c22d2524518b7484f91e17ee3d21cac104496f0c07fa4e1b0_640.jpg'),
(1, 'Cachorro fofo', 'Olha esse doguinho 🐶', 'https://example.com/foto4.jpg');

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
 '/uploads/caryn campbell.jpeg',
 'Homicídio', '70', 1975, FALSE),

('Há 50 anos, Lynda Ann Healy foi sequestrada e assassinada por Ted Bundy. Ela tinha 21 anos e acredita-se que foi sua primeira vítima.',
 'Aos 21 anos, Lynda Ann Healey desapareceu em 1974. Sangue foi encontrado em seus lençóis, e sua camisola pendurada no armário.',
 'Lynda Ann Healy foi uma das primeiras vítimas de Ted Bundy, desaparecendo em 1974.',
 'https://aventurasnahistoria.com.br/noticias/vitrine/historia-as-vitimas-esquecidas-de-ted-bundy.phtml',
 '/uploads/lynda ann healy.jpeg',
 'Homicídio', '70', 1974, FALSE),

('Em memória de Kimberly Leach, 12, a última vítima de Ted Bundy: o mundo perdeu uma grande alma',
 'Kimberly Leach, 12 anos, desapareceu em 1978 em Lake City, Flórida. A polícia prendeu Ted Bundy, já procurado pelo FBI.',
 'Kimberly Leach foi a última vítima de Ted Bundy, desaparecendo em 1978.',
 'https://aventurasnahistoria.com.br/noticias/vitrine/historia-as-vitimas-esquecidas-de-ted-bundy.phtml',
 '/uploads/Kimberly Leach.jpeg',
 'Homicídio', '70', 1978, TRUE),

('Quem ama não mata: o feminicídio de 1976 que ajudou a mudar a Justiça brasileira',
 'Em 2023, o caso da socialite Ângela Maria Fernandes Diniz, morta a tiros em 1976 pelo namorado Doca Street, foi citado no STF como marco contra o feminicídio.',
 'O caso Ângela Diniz foi um marco na luta contra o feminicídio no Brasil.',
 'https://g1.globo.com/rj/rio-de-janeiro/noticia/2023/09/16/quem-ama-nao-mata-o-feminicidio-de-1976-que-ajudou-a-mudar-a-justica-brasileira.ghtml',
 '/uploads/angela-e-doca.jpeg',
 'Feminicídio', '70', 1976, TRUE),

('Caso Carlinhos',
 'Em 1973, Carlinhos foi sequestrado em casa no Rio de Janeiro. A família recebeu um pedido de resgate, mas o destino do menino permanece desconhecido.',
 'O caso Carlinhos é um dos desaparecimentos mais misteriosos do Brasil.',
 'https://oglobo.globo.com/rio/dez-crimes-que-chocaram-rio-de-janeiro-17845895',
 '/uploads/Carlinhos.jpeg',
 'Assassinato', '70', 1973, FALSE);

--decadas de 80
INSERT INTO news (title, description, text, link, image, category, decade, year, is_featured)
VALUES 
('1980: O ano que ficou marcado como a década dos SERIAL KILLERS nos EUA',
 'Durante três décadas da segunda metade do século 20, a América do Norte registrou um crescimento expressivo no número de homicídios em série, caracterizados por crimes semelhantes cometidos por um mesmo autor, os chamados serial killers.',
 'Esse aumento teve início nos anos 1960 e intensificou-se nas décadas seguintes, atingindo seu auge nos anos 1980, quando os casos se tornaram mais frequentes e notórios.',
 'https://www.bbc.com/portuguese/internacional-45363043',
 '/uploads/Serial Killers.jpeg',
 'Criminologia', '80', 1980, TRUE),

('Um homem aparentemente inofensivo dos EUA: Ted Bundy',
 'Jeffrey Dahmer, o Canibal de Milwaukee, matou 17 homens e garotos entre 1977 e 1991. Nascido em 1960, cometeu o primeiro assassinato aos 17 anos.',
 'Atraía vítimas para casa, onde cometia atos horríveis e desmembrava os corpos. Antes da prisão, teve problemas com a lei e foi expulso do exército.',
 'https://f5.folha.uol.com.br/cinema-e-series/2022/10/jeffrey-dahmer-por-que-serie-sobre-serial-killer-americano-causa-tanta-polemica.shtml',
 '/uploads/Jeffrey Dahmer.jpg',
 'Homicídio Qualificado', '80', 1980, TRUE),

('O assassino em série que fez com que os palhaços nos aterrorizassem: John Wayne Gacy',
 'John Wayne Gacy, nascido em 1942 nos subúrbios de Chicago, teve uma infância marcada por abusos. Trabalhou em funerária, casou-se e virou gerente de restaurante, onde começou seus crimes.',
 'Enriquecido com sua empresa, criou o palhaço Pogo para eventos infantis, ocultando sua verdadeira face de predador sexual e assassino.',
 'https://brasil.elpais.com/brasil/2019/06/28/actualidad/1561705341_083525.html',
 '/uploads/John Wayne.jpeg',
 'Serial Killers', '80', 1980, TRUE),

('Alemanha condena “enfermeiro da morte” que assassinou 85 pacientes',
 'Niels Högel, enfermeiro alemão de 42 anos, foi condenado à prisão perpétua por matar 85 pacientes entre 2000 e 2005.',
 'A justiça considerou sua culpa "particularmente grave", anulando a chance de liberdade após 15 anos. É considerado o maior assassino em massa da Alemanha desde a Segunda Guerra.',
 'https://brasil.elpais.com/brasil/2019/06/06/internacional/1559810905_905194.html',
 '/uploads/Niels Hogel.jpeg',
 'Homicídio em Série', '80', 1980, TRUE),

('Assassinato de John Lennon: A Tragédia que Abalou o Mundo',
 'Em 8 de dezembro de 1980, o ex-Beatle John Lennon foi assassinado a tiros por Mark David Chapman na entrada do edifício Dakota, em Nova York.',
 'Chapman, fã obcecado, alegou ter sido inspirado pelo livro "O Apanhador no Campo de Centeio". Lennon morreu a caminho do hospital, aos 40 anos.',
 'https://people.com/john-lennon-death-what-to-know-7511226',
 '/uploads/John Lennon.jpeg',
 'Assassinato', '80', 1980, TRUE);

--decadas de 90
INSERT INTO news (title, description, text, link, image, category, decade, year, is_featured)
VALUES 
 ('Chacina de Ácari',
 'Caso ocorrido no Rio de Janeiro, envolvendo o desaparecimento de 11 jovens. Supostamente mortos por policiais, o caso evidenciou questões de violência policial e omissão estatal, gerando repercussão internacional e pedidos de justiça por parte das famílias das vítimas.',
 'A Chacina de Ácari é um dos casos mais emblemáticos de violência policial no Brasil.',
 'https://g1.globo.com/jornal-nacional/noticia/2024/12/04/chacina-de-acari-corte-interamericana-responsabiliza-brasil-pelo-desaparecimento-de-11-jovens-no-rio.ghtml',
 '/uploads/Chacina de Àcari.jpeg',
 'Chacina', '90', 1990, FALSE),

('Caso da menina Míriam',
 'O desaparecimento e a morte da menina Míriam Brandão chocaram o Brasil em 1992. O caso expôs a brutalidade e a violência contra crianças, mobilizando a opinião pública e gerando questionamentos sobre a segurança infantil.',
 'O caso Míriam Brandão trouxe à tona a necessidade de maior proteção às crianças no Brasil.',
 'https://www.em.com.br/app/noticia/gerais/2011/09/02/interna_gerais,248406/assassino-que-chocou-a-capital-em-1992-esta-proximo-da-liberdade.shtml',
 '/uploads/Menina Míriam.jpeg',
 'Homicídio', '90', 1992, FALSE),

('Caso Daniella Perez',
 'O assassinato da atriz Daniella Perez em 1992, cometido por um colega de elenco, gerou grande comoção nacional. O crime foi amplamente coberto pela mídia e desencadeou um debate sobre feminicídio.',
 'O caso Daniella Perez foi um marco na luta contra o feminicídio no Brasil.',
 'https://www.cnnbrasil.com.br/entretenimento/daniella-perez-assassinato-de-atriz-completa-32-anos-relembre-o-caso/L',
 '/uploads/Daniela Perez.jpeg',
 'Feminicídio', '90', 1992, TRUE),

('Caso Maníaco do Parque',
 'Francisco de Assis Pereira, o Maníaco do Parque, aterrorizou São Paulo no final dos anos 1990 com uma série de assassinatos brutais. Ele atraía mulheres ao parque sob falsos pretextos e as assassinava.',
 'O caso Maníaco do Parque é um dos mais conhecidos envolvendo serial killers no Brasil.',
 'https://www.cnnbrasil.com.br/nacional/relembere-o-caso-do-maniaco-do-parque-tema-de-filme-que-estreia-hoje/',
 '/uploads/Maníaco do Parque.jpeg',
 'Assassinato em série', '90', 1998, TRUE),

('Caso atirador do shopping',
 'Em 1998, um atirador abriu fogo em um shopping center no Brasil, deixando vítimas e espalhando pânico entre os frequentadores. O caso trouxe à tona discussões sobre segurança em locais públicos e o controle de armas.',
 'O caso do atirador do shopping gerou debates sobre segurança pública e controle de armas no Brasil.',
 'https://www.cnnbrasil.com.br/nacional/atirador-do-shopping-morumbi-em-sp-deixa-prisao-apos-25-anos-entenda/',
 '/uploads/Atirador do Shopping.jpeg',
 'Homicídio', '90', 1998, FALSE);

--decadas de 2000
INSERT INTO news (title, description, text, link, image, category, decade, year, is_featured)
VALUES 
 ('Caso Richthofen: o assassinato que chocou o Brasil',
 'O assassinato de Manfred e Marísia von Richthofen, pais de Suzane von Richthofen, ocorreu na madrugada de 31 de outubro de 2002. Suzane planejou o crime junto com Daniel e Cristian Cravinhos para acessar a herança familiar.',
 'Os pais foram mortos a golpes de barra de ferro. Os três foram condenados por homicídio triplamente qualificado.',
 'https://www.estadao.com.br/brasil/suzane-von-richthofen-relembre-como-a-policia-desvendou-o-caso-e-como-estao-os-acusados-hoje-nprm/',
 '/uploads/Richthofen.jpeg',
 'Crime Hediondo', '2000', 2002, TRUE),

('Caso Friedenbach-Caffé: o crime brutal que chocou o Brasil',
 'Em novembro de 2003, Liana Friedenbach e Felipe Caffé foram sequestrados por Champinha e seu grupo em Embu-Guaçu.',
 'Felipe foi executado com um tiro na nuca, enquanto Liana foi violentada e morta dias depois. O caso causou comoção nacional e gerou debates sobre maioridade penal.',
 'https://projetocolabora.com.br/ods16/caso-champinha-crime-perverso-fim-aventura-adolescentes-apaixonados/',
 '/uploads/Friedenbach.jpeg',
 'Crime Hediondo', '2000', 2003, FALSE),

('Caso Madeleine McCann: o desaparecimento que mobilizou o mundo',
 'Madeleine McCann desapareceu em 3 de maio de 2007 no resort Praia da Luz, Portugal, enquanto seus pais jantavam.',
 'A polícia portuguesa foi criticada por falhas na investigação. Em 2020, um suspeito alemão foi identificado, mas o paradeiro da menina ainda é um mistério.',
 'https://www.cnnbrasil.com.br/tudo-sobre/caso-madeleine-mccann/',
 '/uploads/Madeleine McCann.jpeg',
 'Crime de Sequestro', '2000', 2007, FALSE),

('Caso Ônibus 174: o sequestro que parou o Brasil',
 'Em 12 de junho de 2000, Sandro Barbosa do Nascimento sequestrou um ônibus no Rio de Janeiro, mantendo reféns por quase cinco horas.',
 'O episódio foi transmitido ao vivo e terminou com a morte da refém Geísa Firmo Gonçalves, atingida por disparos durante a ação policial.',
 'https://oglobo.globo.com/blogs/blog-do-acervo/post/2024/03/sequestro-do-onibus-174-horas-de-tensao-com-uma-tragedia-no-final.ghtml',
 '/uploads/Onibus 174.jpeg',
 'Crime Hediondo', '2000', 2000, FALSE),

('Caso Isabella Nardoni: o assassinato que comoveu o Brasil',
 'Em 29 de março de 2008, Isabella Nardoni, de cinco anos, foi jogada do sexto andar de um prédio em São Paulo.',
 'As investigações apontaram para o pai, Alexandre Nardoni, e a madrasta, Anna Carolina Jatobá, como responsáveis pelo crime. Ambos foram condenados por homicídio triplamente qualificado.',
 'https://g1.globo.com/tudo-sobre/isabella-nardoni/',
 '/uploads/Caso_Isabella_Nardoni.jpeg',
 'Crime Hediondo', '2000', 2008, FALSE),

('Caso Eloá',
 'Em 13 de outubro de 2008, Lindemberg Alves sequestrou sua ex-namorada, Eloá, e a amiga Nayara, após o fim do relacionamento.',
 'Após quase 100 horas de cativeiro, a polícia invadiu o apartamento. Nayara foi libertada ferida, mas Eloá foi baleada e teve a morte cerebral confirmada em 18 de outubro.',
 'https://rollingstone.com.br/noticia/caso-eloa-producoes-para-entender-a-historia-que-chocou-o-pais/',
 '/uploads/Caso Eloá.jpeg',
 'Sequestro e Homicídio', '2000', 2008, TRUE);

--decadas de 2010
INSERT INTO news (title, description, text, link, image, category, decade, year, is_featured)
VALUES 
('Caso Eliza Samudio',
 'O assassinato de Eliza Samudio, em 2010, envolveu o goleiro Bruno Fernandes, então astro do Flamengo.',
 'Eliza foi sequestrada e morta por ordem de Bruno após pedir reconhecimento de paternidade. O crime teve grande repercussão, gerando debates sobre violência doméstica e impunidade. Bruno foi condenado a 22 anos e tentou retomar a carreira após a prisão.',
 'https://g1.globo.com/tudo-sobre/eliza-samudio/',
 '/uploads/Eliza Samúdio.jpeg',
 'Crime Hediondo', '2000', 2010, TRUE),

('Caso Luka Magnotta',
 'O assassinato de Jun Lin, em 2012, foi um dos crimes mais brutais da era digital.',
 'Luka Magnotta matou, esquartejou e enviou partes do corpo da vítima a escolas e partidos políticos no Canadá. O crime foi filmado e divulgado na internet, chocando o mundo. Magnotta foi capturado na Alemanha e condenado à prisão perpétua.',
 'https://noticias.uol.com.br/ultimas-noticias/efe/2017/06/21/canibal-de-montreal-se-casara-com-outro-preso-no-final-do-mes.htm',
 '/uploads/Luka Magnnota.jpeg',
 'Crime Hediondo', '2010', 2012, FALSE),

('Caso Chris Watts',
 'Em 2018, Chris Watts matou a esposa grávida e as duas filhas pequenas em Colorado, EUA.',
 'Ele enterrou a esposa em uma cova rasa e jogou os corpos das filhas em tanques de óleo. O crime chocou pela frieza e pelo contraste entre a imagem de família perfeita nas redes sociais e a realidade sombria do assassinato.',
 'https://g1.globo.com/mundo/noticia/2019/03/07/homem-que-matou-esposa-gravida-e-duas-filhas-nos-eua-revela-pela-primeira-vez-como-cometeu-crime.ghtml',
 '/uploads/Chris Whatts.jpeg',
 'Crime Hediondo', '2010', 2018, TRUE),

('Caso Stephen Paddock',
 'Em outubro de 2017, Stephen Paddock abriu fogo contra uma multidão em um festival de música country em Las Vegas, matando 60 pessoas e ferindo mais de 800.',
 'O ataque, o mais letal da história dos EUA, foi realizado do 32º andar do Mandalay Bay Hotel. Paddock se suicidou antes da abordagem policial e nunca foi encontrada uma motivação clara.',
 'https://g1.globo.com/mundo/noticia/veja-quem-e-stephen-paddock-o-atirador-de-las-vegas.ghtml',
 '/uploads/Stephen Paddock.jpeg',
 'Crime Hediondo', '2010', 2017, FALSE);

--decadas de 2020
INSERT INTO news (title, description, text, link, image, category, decade, year, is_featured)
VALUES 
('Caso da trapezista argentina',
 'Em dezembro de 2023, Florencia Aranguren foi brutalmente assassinada a facadas enquanto passeava com o cachorro em Búzios, RJ.',
 'Carlos José foi preso em flagrante e condenado a 33 anos de prisão. O corpo da trapezista foi encontrado em uma trilha e o cão permaneceu ao lado da vítima até a chegada das autoridades.',
 'https://www.condorcontabilidade.com.br/nb2/rj/regiao-dos-lagos/noticia/2025/04/03/julgamento-marcado-acusado-de-matar-trapezista-argentina-em-buzios-enfrenta-o-tribunal-do-juri-no-dia-9-de-abril.ghtml',
 '/uploads/Trapezista argentina.jpeg',
 'Homicídio', '2020s', 2023, FALSE),

('Caso do menino arremessado da ponte pelo pai',
 'Em março de 2025, um homem arremessou o próprio filho de cinco anos de uma ponte em São Gabriel, RS, em um ato de vingança contra a ex-esposa.',
 'Ele confessou o crime e está preso.',
 'https://www.cnnbrasil.com.br/wp-content/uploads/sites/12/2025/03/cantor-afogado-pe-2-2.jpg?w=1115',
 '/uploads/Menino Arremessado.jpeg',
 'Homicídio', '2020s', 2025, FALSE),

('Caso do motorista de app em SP',
 'Em março de 2025, um motorista de aplicativo foi preso após tentar estuprar e roubar uma passageira de 21 anos no bairro da Casa Verde, zona norte de São Paulo.',
 'A vítima conseguiu fugir e o homem foi preso.',
 'https://s2-g1.glbimg.com/JTYtBLWhlDV-pnM6l5rMDQd31mc=/1280x0/filters:format(jpeg)/https://thumbor.globoi.com/unsafe/fit-in/1280x720/s03.video.glbimg.com/deo/vi/54/13/13491354',
 '/uploads/Motorista de App.jpeg',
 'Violência Sexual', '2020s', 2025, FALSE),

('Caso Clara Maria em MG',
 'Em março de 2025, Clara Maria, de 21 anos, foi encontrada morta e concretada em uma casa em Belo Horizonte.',
 'Os suspeitos Thiago e Pimentel foram presos após confessarem o crime.',
 'https://www.cnnbrasil.com.br/wp-content/uploads/sites/12/2025/03/Clara-Maria.jpg?w=880',
 '/uploads/Clara Maria.jpeg',
 'Homicídio', '2020s', 2025, FALSE),

('Caso do cantor morto afogado em PE',
'Em fevereiro de 2025, um cantor foi encontrado morto após se afogar em um rio em Pernambuco.',
 'A polícia investiga as circunstâncias do afogamento e se houve envolvimento de terceiros.',
 'https://www.cnnbrasil.com.br/wp-content/uploads/sites/12/2025/03/cantor-afogado-pe-2-2.jpg?w=1115',
 '/uploads/Cantor Afogado.jpeg',
 'Morte Suspeita', '2020s', 2025, FALSE),

('Filho mata pai alcoólatra em SC',
 'Em fevereiro de 2025, um homem de 23 anos matou o pai de 47 anos a golpes de tesoura em São João Batista, SC.',
 'A vítima foi encontrada com 22 perfurações. O suspeito se entregou à polícia após o crime.',
 'https://static.ndmais.com.br/2025/02/identificado-homem-morto-por-filho-a-tesouradas-sao-joao-batista-grande-florianopolis-elvis-marcos-da-silva-800x467.jpg',
 '/uploads/Filho mata pai alcoolatra.jpeg',
 'Homicídio', '2020s', 2025, FALSE);


INSERT INTO podcasts (title, description, link, image, category, is_featured)
VALUES 
('Crimes Reais: Ivan Mizanzuk', 'Ivan Mizanzuk e  professor universitario, designer, escritor, produtor de podcasts e jornalista. Ele conta "historias reais de pessoas reais" no podcast Projeto Humanos. Ja o Vilela so contrata projetos de humanos para trabalharem com ele.', 'https://youtu.be/UywLajXBLw4?feature=shared', 'https://vejasp.abril.com.br/wp-content/uploads/2023/08/Ilana-Casoy-Erik-Almeida-Divulgac%CC%A7a%CC%83o.jpg.jpg?crop=1&resize=1212,909', 'casos reais', TRUE),
('Ela cuida das mentes mais pertubadas - Gabriela Cruz', 'Ela conhece a mente dos ped0filos! Gabriela Cruz e uma renomada psicologa especialista em sexualidade humana. Antes de atender em clinicas, ela trabalhou durante anos em penitenciarias, acompanhando individuos condenados por ped0filia e outros cr1mes s3xuais', 'https://youtu.be/mdwQUT0i5dc?feature=shared', 'https://i.ytimg.com/vi/mdwQUT0i5dc/maxresdefault.jpg', 'investigacao', TRUE),
('Crimes reais: Perita Rosangela Monteiro e Delegado Mauro Dias', 'Dra. Rosangela  e psicologa e perita criminal, e MAURO DIAS e ex-delegado. Eles vao conversar sobre crimes reais e os processos de investigacao e pericia para desvendar os casos. O Vilela e expert em esconder que comeu todo o chocolate da casa que nem um CSI Sao Paulo resolveria o caso.', 'https://www.youtube.com/live/28WQA1o1CDQ?feature=shared', 'https://i.ytimg.com/vi/28WQA1o1CDQ/maxresdefault.jpg', 'investigacao', TRUE),
('Crimes Reais: Caso Nardoni', 'Discussao sobre o assassinato de Isabella Nardoni.', 'https://www.youtube.com/watch?v=1XyODZb7APk', 'https://f.i.uol.com.br/fotografia/2018/03/12/15209076785aa7359ecb363_1520907678_3x2_xl.jpg', 'famoso', TRUE),
('Crimes Reais: Caso Marisia e Marcos Matsunaga', 'Investigacao sobre o assassinato de Marisia e Marcos Matsunaga.', 'https://www.youtube.com/watch?v=skj1q8v-f8k', 'https://s2-oglobo.glbimg.com/yqppgndr5hdBMscIOL-7ioLS2LM=/0x0:620x415/984x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_da025474c0c44edd99332dddb09cabe8/internal_photos/bs/2023/5/p/3jKTd5TzGIg9jBqCYRLA/63080943.jpg', 'investigacao', FALSE),
('Crime Junkie', 'Podcast semanal dedicado a cobrir casos de crimes reais.', 'https://open.spotify.com/show/3DgfoleqaW61T2amZQKINx', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTC3zmZm2qANnrB1IJ3qbjpzcfJmfVYrYUaLQ&s', 'impactante', TRUE);

INSERT INTO podcasts (title, description, link, image, category,  is_featured) 
VALUES
('Crimes Reais: Telma Rocha, Edu Tachlitsky e Leandro Lopes', 'Discussao sobre crimes reais no Brasil com especialistas.', 'https://www.youtube.com/watch?v=SCYsS6VgxPY', 'https://i.ytimg.com/vi/u6iCbtzIGM4/maxresdefault.jpg', 'famoso', TRUE),
('Crimes Reais: Ricardo Salada e Jorge Lordello', 'Analise de casos criminais com especialistas.', 'https://www.youtube.com/watch?v=aPEYYaR8hVY', 'https://i.ytimg.com/vi/aPEYYaR8hVY/maxresdefault.jpg', 'impactante', FALSE),
('Crimes Reais: Telma Rocha', '2 horas ouvindo crimes reais contados pela fotografa Telma Rocha', 'https://www.youtube.com/live/PPWehNBYq_M?feature=shared', 'https://conteudo.imguol.com.br/c/noticias/69/2024/10/24/fotografa-tecnico-pericial-telma-rocha-do-dhpp-departamento-estadual-de-homicidios-e-de-protecao-a-pessoa-no-podcast-inteligencia-ltda-em-27-de-agosto-de-2024-1729808672617_v2_900x506.png', 'famoso', FALSE),
('Podcast: Rosangela - Melhores momentos', 'Melhores momentos com a Dra. Rosangela Monteiro sobre o caso da Milena Dantas Bereta Nistarda, que tinha acabado de sair da delegacia onde prestou queixa contra o marido, Marcelo Nistarda Antoniassi. Mas quis o destino que ele a encontrasse. Milena terminou sem vida e teve ainda seu coracao arr4ncad0 pelas maos daquele que jurou protege-la.', 'https://youtu.be/nreTvJi_Mz4?feature=shared', 'https://i.ytimg.com/vi/nreTvJi_Mz4/hqdefault.jpg', 'impactante', TRUE),
('Christian Costa', 'Ele e diretor do Centro de Estudos do Comportamento Cr1min4l! O Dr. Christian Costa e um renomado profissional da area da psicologia cr1min4l, exaltado pelo seu trabalho de unir ciencia e pratica para tratar de cr1mes e psicopatologias.', 'https://youtu.be/0UwkMabyB78?feature=shared', 'https://emtempo.com.br/wp-content/uploads/2023/11/b0aaf3e3-5012-44bb-ade6-6d1e45e3297c.jpg', 'impactante', TRUE);


INSERT INTO podcasts (title, description, link, image, category,  is_featured) 
VALUES
('Marcia Lanze descobre morte atraves do tik tok', 'Ele foi pego pelo TikTok! Bruno Eustaquio ligou para a policia depois de encontrar a mae, Marcia Lanzane, m0rta. Porem, durante as investigacoes, os agentes descobriram uma dinamica chocante: a mulher havia sido ass4ssin4da pelo proprio filho, que, depois de cometer o cr1me, foi para a sala e ficou assistindo televisao.', 'https://youtu.be/XKJ7Zzmifig?feature=shared', 'https://i.ytimg.com/vi/1M6QBfFAq7I/maxresdefault.jpg', 'impactante', TRUE),
('Doutora Luiza - ela atuou em lugares que mudaram o Brasil', 'Ela atuou em casos que pararam o Brasil! Luisa Muchon e uma experiente advogada criminalista, que ja trabalhou com casos de grande repercussao e conheceu de perto figuras emblematica do pais. Alem de ter sido advogada do casal Nardoni, foi a ultima pessoa a conversar com Farah Jorge Farah e representou diversos nomes associados a Operacao Lava Jato.', 'https://youtu.be/NhK_MjWjxsU?feature=shared', 'https://is3-ssl.mzstatic.com/image/thumb/Podcasts112/v4/5f/fd/21/5ffd2174-6076-f55b-27bc-2daf7a0e93ca/mza_7189227837507334208.jpg/1200x1200bb.jpg', 'impactante', TRUE),
('Caso Vitoria Regina - Detalhes da investigacao', 'Confira minha entrevista com o advogado da familia de Vitoria Regina de Sousa, morta entre o final de fevereiro e comeco de marco de 2025, em circunstancias, no minimo, estranhas. A policia colocou o vizinho da familia, Maicol Sales do Santos, como unico suspeito e autor de tudo.', 'https://youtu.be/-W78mbchJbw?feature=shared', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSYW7tHdUdbmvozHaVKUCb5hQcvrdzn4Ma8bQ&s', 'investigacao', TRUE),
('Jogada no lixo, vendida p/ homens, queimada vida', 'Ela nasceu Larissa Duque e hoje se tornou Heloisa. Tudo para fugir da mae narcisista que criou um enredo de vida e m0rte para a filha. Ela consegiu mais que sobreviver, viver e vencer a progenitora que, logo ao dar a luz, jogou Heloisa no lixo. E esse foi so o comeco...', 'https://youtu.be/Kb0tZnF1IhU?feature=shared', 'https://s2-marieclaire.glbimg.com/1rLIfRAqEFgS2H8aepmgANIRAEw=/0x0:591x332/600x0/smart/filters:gifv():strip_icc()/i.s3.glbimg.com/v1/AUTH_51f0194726ca4cae994c33379977582d/internal_photos/bs/2024/g/9/NDBA7iTkGLEx2LkK6lsw/larissa-duque-pequena.png', 'investigacao', TRUE),
('Crimes Reais: Ullisses Campbell e Beto Ribeiro', 'ULLISSES CAMPBELL e escritor, e BETO RIBEIRO e diretor e roteirista. Eles vao contar historias e destrinchar crimes reais, como o caso da Suzane Von Richthofen. Agora que Suzane foi solta da cadeia, o Vilela ja reforcou a seguranca do porao, ja que ele tem idade pra ser pai dela.', 'https://www.youtube.com/live/zU8Ahy3zL1c?feature=shared', 'https://i.ytimg.com/vi/zU8Ahy3zL1c/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLA0OXMP6xTmt11FYsC51hkilk9inA', 'casos reais', TRUE),
('Crimes Reais: Ju Cassini e Giovanna Alba', 'JU CASSINI e GIOVANNA ALBA sao YouTubers. Elas vao bater um papo sobre os crimes reais da atualidade. O Vilela tem tanto medo de violencia que dorme de capacete.', 'https://www.youtube.com/live/HnCFLkqkSHc?feature=shared', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTiYQNlmkbbRztXKmmdhXXVIBlVEMeGEDstHg&s', 'casos reais', TRUE),
('Crimes Reais: Ju Cassini e Beto', 'JU CASSINI e YouTuber e BETO RIBEIRO e diretor e roteirista. Eles vao bater um papo sobre crimes reais com historias assustadoras, bizarras e misteriosas. O Vilela ja se preparou e comprou mais fraldas geriatricas pra trocar nessa live.', 'https://www.youtube.com/live/n9YXRqNtows?feature=shared', 'https://i.ytimg.com/vi/n9YXRqNtows/maxresdefault.jpg', 'casos reais', TRUE),
('Crimes Reais: O caso mais pesado', 'TELMA ROCHA e fotografa pericial, e EDU TACHLITSKY e LEANDRO LOPES sao peritos criminais do Departamento de Homicidios e Protecao a Pessoa de Sao Paulo. Eles vao esclarecer muitas duvidas sobre os bastidores dos crimes mais conhecidos e tambem os mais curiosos. O Vilela que seu cuide, pois ele esta sempre em minoria no porao.', 'https://youtu.be/7x0UoLX4kmQ?feature=shared', 'https://i.ytimg.com/vi/7x0UoLX4kmQ/maxresdefault.jpg', 'crimes antigos', TRUE),
('Crimes Reais: Ricardo Salada, Telma Rocha e Rafael Heck', 'RICARDO SALADA, TELMA ROCHA E RAFAEL HECK sao peritos criminais. Eles trabalham no DHPP (Departamento de Homicidios e de Protecao a Pessoa) do estado de SP e vao bater um papo sobre crimes reais. Ja o Vilela presenciou varios crimes do passado.', 'https://www.youtube.com/live/17PwIYnL28Y?feature=shared', 'https://i.ytimg.com/vi/17PwIYnL28Y/maxresdefault.jpg', 'crimes antigos', TRUE),
('Telma Rocha e Andre DAvila', 'Neste podcast Telma Rocha e Andre DAvila abordam questoes cruciais relacionadas ao crime, a seguranca publica e aos desafios enfrentados pela sociedade contemporanea.', 'https://youtu.be/azFRrtdUnvE?feature=shared', 'https://i.ytimg.com/vi/azFRrtdUnvE/sddefault.jpg?v=6362b027', 'crimes antigos', TRUE),
('Crimes Reais: Ricardo Ventura e Ricardo Salada', 'RICARDO VENTURA e psicanalista e RICARDO SALADA e perito criminal. Hoje descobriremos mutas tecnicas de como pegar o mentiroso e o bandido com as calcas na mao. A Mari deveria assistir a essa live, pois e obvio que o Vilela vai pisar na bola.', 'https://www.youtube.com/live/rMT78xVz_Qc?feature=shared', 'https://i.ytimg.com/vi/rMT78xVz_Qc/maxresdefault.jpg', 'crimes antigos', TRUE),
('Caso Familia Goncalves', 'Em uma noite comum de janeiro de 2020, em Sao Bernardo do Campo, no Grande ABC de Sao Paulo, Flaviana Goncalves chegava em casa do trabalho quando encontrou sua familia rendida por tres ladroes. O Romoyuki, o marido, Juan, o filho adolescente, Anaflavia, a filha e a namorada de sua filha, Carina, todos estavam sob a mira dos assaltantes. Flaviana foi levada ao quarto para passar suas senhas de banco, quando foi morta ao lado do cacula e do esposo.', 'https://youtu.be/kcIpYBnwlBk?feature=shared', 'https://i.ytimg.com/vi/kcIpYBnwlBk/maxresdefault.jpg', 'crimes antigos', TRUE);



INSERT INTO videos (title, description, link, image, category, is_featured)
VALUES 
('Caso Evandro: Documentario Completo', 'Serie documental sobre o desaparecimento de Evandro Ramos Caetano em 1992.', 'https://www.youtube.com/watch?v=XkoJiUI6jNg', 'https://i.ytimg.com/vi/XkoJiUI6jNg/maxresdefault.jpg', 'investigacao', TRUE),
('Daniel Alves: Absolvicao na Espanha', 'Noticia sobre a absolvicao de Daniel Alves da acusacao de estupro.', 'https://www.youtube.com/watch?v=3Hs4beu3Pr8', 'https://i.ytimg.com/vi/3Hs4beu3Pr8/maxresdefault.jpg', 'recente', TRUE),
('Boate Kiss: A Tragedia de Santa Maria', 'Documentario sobre o incendio na Boate Kiss que matou 242 pessoas.', 'https://www.youtube.com/watch?v=MCvD2tGSvSg', 'https://i.ytimg.com/vi/MCvD2tGSvSg/maxresdefault.jpg', 'impactante', FALSE),
('Pacote Anticrime: Analise Juridica', 'Analise das mudancas trazidas pelo Pacote Anticrime na legislacao penal.', 'https://www.youtube.com/watch?v=PBtEWKVzxjk', 'https://i.ytimg.com/vi/PBtEWKVzxjk/maxresdefault.jpg', 'leis', FALSE),
('Suzane von Richthofen: O Crime', 'Documentario sobre o assassinato dos pais de Suzane von Richthofen.', 'https://www.youtube.com/watch?v=Iv572FJpZSc', 'https://i.ytimg.com/vi/Iv572FJpZSc/maxresdefault.jpg', 'crime', TRUE),
('Operacao Lava Jato: 10 Anos', 'Especial sobre os 10 anos da Operacao Lava Jato e seus desdobramentos.', 'https://www.youtube.com/watch?v=xaiPHbjRTmE', 'https://i.ytimg.com/vi/xaiPHbjRTmE/maxresdefault.jpg', 'investigacao', TRUE),
('Caso Lazaro Barbosa: A Cacada', 'Cobertura da cacada policial a Lazaro Barbosa em 2021.', 'https://www.youtube.com/watch?v=R6OGs5YQvKU', 'https://i.ytimg.com/vi/R6OGs5YQvKU/maxresdefault.jpg', 'recente', TRUE),
('Joao de Deus: Condenacao', 'Noticia sobre a condenacao de Joao de Deus por crimes de estupro.', 'https://www.youtube.com/watch?v=8zFQn_Z1o-I', 'https://i.ytimg.com/vi/8zFQn_Z1o-I/maxresdefault.jpg', 'investigacao', FALSE),
('Caso Miguel: Negligencia Fatal', 'Reportagem sobre a morte do menino Miguel e a responsabilidade da patroa.', 'https://www.youtube.com/watch?v=9BijzzxvENA', 'https://i.ytimg.com/vi/9BijzzxvENA/maxresdefault.jpg', 'crime', TRUE),
('Chacina da Candelaria: 30 Anos', 'Analise do massacre de oito jovens em frente a Igreja da Candelaria.', 'https://www.youtube.com/watch?v=SJHxESnm6Ys', 'https://i.ytimg.com/vi/SJHxESnm6Ys/maxresdefault.jpg', 'impactante', FALSE),
('Caso Amarildo: Desaparecimento', 'Reportagem sobre o desaparecimento do pedreiro Amarildo na Rocinha.', 'https://www.youtube.com/watch?v=7ujN1Z717sY', 'https://i.ytimg.com/vi/7ujN1Z717sY/maxresdefault.jpg', 'investigacao', FALSE),
('Assassinato de Celso Daniel', 'Investigacao sobre o assassinato do prefeito Celso Daniel.', 'https://www.youtube.com/watch?v=zM1a1eVPO4Q', 'https://i.ytimg.com/vi/zM1a1eVPO4Q/maxresdefault.jpg', 'crime', TRUE);

INSERT INTO videos (title, description, link, image, category, is_featured)
VALUES 
('Caso Isabele Ramos: Tragedia em Cuiaba', 'Cobertura sobre a morte da adolescente Isabele Ramos em Cuiaba.', 'https://www.youtube.com/watch?v=rt7W8zsSxDg', 'https://i.ytimg.com/vi/rt7W8zsSxDg/maxresdefault.jpg', 'crime', FALSE),
('Investigacao Criminal: O Caso Isabella Nardoni','Documentario detalhado sobre o famoso caso Isabella Nardoni, apresentando bastidores da investigacao policial e analises forenses.','https://youtu.be/oIMfGiqKdII?feature=shared', 'https://s2-g1.glbimg.com/VaNENbf6ghC8-p9xOqyDRJivniU=/323x0:1000x450/984x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_59edd422c0c84a879bd37670ae4f538a/internal_photos/bs/2024/u/i/LMzJvPQciWhqG1bNrPtw/ana-carolina-oliveira-isabella-nardoni-e-alexandre-nardoni.jpg','investigacao', TRUE),
('O Assassinato de Marielle Franco: Misterios e Investigacoes', 'Entenda os detalhes do assassinato da vereadora Marielle Franco, um crime recente que mobilizou investigacoes federais.', 'https://youtu.be/7FBIXSKTlPo?feature=shared', 'https://s01.video.glbimg.com/640x360/6585500.jpg', 'recente', TRUE),
('Caso Henry Borel: O que aconteceu?', 'Documentario sobre a morte do menino Henry Borel, um dos crimes mais recentes e comentados no Brasil.', 'https://youtu.be/YZQcbx9VHfg?feature=shared', 'https://assets.brasildefato.com.br/2024/09/image_processing20210412-10498-1yhvipb.jpeg', 'recente', FALSE),
('Caso Daniel Correa: O jogador assassinado', 'Analise completa do assassinato do jogador Daniel Correa, incluindo a investigacao e julgamento dos envolvidos.', 'https://youtu.be/e7njAbFZP2o?feature=shared', 'https://s2-oglobo.glbimg.com/J-FB_Ygbn-TLRTg3tp9Z2Lx-QxM=/0x0:7169x2555/888x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_da025474c0c44edd99332dddb09cabe8/internal_photos/bs/2024/q/k/luztrlS7eOwGMITiP2sA/arte-43-.png', 'recente', FALSE),
('Caso Rafael Miguel: A Tragedia do Ator Mirim', 'Confira os detalhes do assassinato de Rafael Miguel e seus pais, um crime recente que chocou o Brasil.', 'https://youtu.be/RwZ-A8niBNc?feature=shared', 'https://s2-g1.glbimg.com/PEBjkyz6fqx3sHJmuztD3ICDxGI=/696x390/smart/filters:cover():strip_icc()/i.s3.glbimg.com/v1/AUTH_59edd422c0c84a879bd37670ae4f538a/internal_photos/bs/2022/V/B/9UOff0QIq2A5gu5zpE6g/paulo-cupertino-e-rafael-miguel.jpg', 'recente', FALSE),
('Caso Eloa: O Sequestro que Chocou o Pais', 'Relembre o caso Eloa, um dos sequestros mais longos e dramaticos da historia do Brasil, com grande repercussao nacional.', 'https://youtu.be/J0dpDynvp80?feature=shared', 'https://s2-g1.glbimg.com/CxloZ9okEVV5tI8NOAg15-tpPNo=/0x0:1022x592/984x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_59edd422c0c84a879bd37670ae4f538a/internal_photos/bs/2023/1/f/U7V2JoQ9qejv1IZa3yog/linha-direta-eloa.jpg', 'impactante', TRUE),
('Caso Suzane Richthofen: O Assassinato dos Pais', 'Documentario sobre o impactante caso Suzane Richthofen, que chocou o Brasil pelo envolvimento da filha no assassinato dos proprios pais.', 'https://youtu.be/Qc0-WnFkTOI?feature=shared', 'https://aventurasnahistoria.com.br/media/uploads/curiosidades/suzane2.jpg', 'impactante', TRUE),
('Caso Maniaco do Parque: O Serial Killer que Assustou Sao Paulo', 'A historia do Maniaco do Parque, um dos maiores serial killers do Brasil, cujos crimes impactaram a sociedade.', 'https://youtu.be/kfa4tuoQbHU?feature=shared', 'https://cj.estrategia.com/portal/wp-content/uploads/2024/11/02151420/formato-foto-do-site-rolling-5_unh8c604_widelg.png', 'impactante', TRUE);

INSERT INTO videos (title, description, link, image, category, is_featured)
VALUES 
('Caso Bernardo Boldrini: O Menino Que Comoveu o Brasil', 'Conheca os detalhes do caso Bernardo Boldrini, o crime brutal que chocou o pais pela frieza dos envolvidos.', 'https://youtu.be/lIwdvGH5o3Y?feature=shared', 'https://s2-g1.glbimg.com/XNquO1qbF_WpMtlChgaPdyKczKY=/1920x0/filters:format(jpeg)/https://i.s3.glbimg.com/v1/AUTH_59edd422c0c84a879bd37670ae4f538a/internal_photos/bs/2025/g/M/pDkhOZQziS5Q6vYeTSBw/g1-2025-04-22t202310.436.png', 'impactante', FALSE),
('O que e o Codigo Penal Brasileiro?', 'Entenda o que e e como funciona o Codigo Penal Brasileiro, suas principais caracteristicas e importancia para o sistema juridico.', 'https://youtu.be/Vg6-jwQi3pg?feature=shared', 'https://i.pinimg.com/originals/09/98/40/099840c9970991f99851580ab620c10a.jpg', 'leis', TRUE),
('Lei Maria da Penha: Protecao as Mulheres', 'Saiba tudo sobre a Lei Maria da Penha, uma das legislacoes mais importantes para o combate a violencia domestica no Brasil.', 'https://youtu.be/tuT__DRuG-U?feature=shared', 'https://images01.brasildefato.com.br/d358d429e3a96b1a1474080a9238ec0c.jpeg', 'leis', TRUE),
('Entenda a Lei do Estupro no Brasil', 'Explicacao didatica sobre o que diz a lei sobre estupro no Brasil, incluindo penas e definicoes legais.', 'https://youtu.be/_e6_SxuCerM?feature=shared', 'https://revistapesquisa.fapesp.br/wp-content/uploads/2022/09/016-025_capa-estupro_320-2-1140-abre2.jpg', 'leis', TRUE),
('Como Funcionam as Leis no Brasil?', 'Veja uma explicacao geral sobre o processo de criacao, aprovacao e funcionamento das leis no Brasil.', 'https://youtu.be/pC-D6sSI904?feature=shared', 'https://ekccopwh4gz.exactdn.com/wp-content/uploads/2018/02/leis-do-brasil-300x200.jpg?lossy=1&ssl=1', 'leis', FALSE),
('Documentario - O que e Justica?', 'Documentario que explora o conceito de justica, trazendo diferentes visoes filosoficas, juridicas e sociais sobre o tema.', 'https://youtu.be/9_3PC-CLGzA?feature=shared', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTS83oXXezuPxcMlMaVBXmlPQEozuVeWHslJQ&s', 'leis', FALSE),
('Investigaca: Caso Madeleine McCann', 'Acompanhe a investigacao do desaparecimento de Madeleine McCann, um dos casos mais misteriosos e debatidos no mundo, com detalhes das buscas e teorias.', 'https://youtu.be/Affj8j3ITBA?feature=shared', 'https://s2-g1.glbimg.com/Rk3yebs1Y1pTIXCBkzCRA4u2hiU=/0x0:640x360/984x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_59edd422c0c84a879bd37670ae4f538a/internal_photos/bs/2022/A/Q/e5VE99R42ACuQcSPo5bA/thumbnail-image001-1-.jpg', 'investigacao', FALSE),
('O Misterio do Crime de Daniella Perez', 'Entenda como foi o assassinato da atriz Daniella Perez, um dos crimes mais marcantes do Brasil na decada de 90.', 'https://youtu.be/8h2jWwSpIAg?feature=shared', 'https://s2.glbimg.com/-6DSugb9dLeUTy_Y4yOjACJRk94=/600x0/filters:quality(70)/i.s3.glbimg.com/v1/AUTH_da025474c0c44edd99332dddb09cabe8/internal_photos/bs/2022/E/L/FdCKeyTmaQxLHI5atsHA/61507276-rio-de-janeiro-rj-11-11-1992-televisao-rj-tv-globo-novela-de-corpo-e-alma-g.jpg', 'crime', FALSE),
('Chacina de Realengo', 'Tragedia ocorrida em uma escola municipal no Rio de Janeiro em 2011.', 'https://youtu.be/1z0E6MzLdrA?feature=shared', 'https://ichef.bbci.co.uk/ace/ws/640/cpsprodpb/5EAC/production/_117863242_b01b7ab3-f0e8-41a6-8010-408afc54da7e.jpg.webp', 'crime', FALSE);

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
