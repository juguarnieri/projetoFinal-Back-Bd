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
('ana_silva', 'Ana Silva', '/uploads/anasilva.jpeg'),
('joao_martins', 'João Martins', '/uploads/joaomartins.jpeg'),
('carla_oliveira', 'Carla Oliveira', '/uploads/carlaoliveira.jpeg'),
('alice01', 'Alice Silva', '/uploads/alice01.jpeg'),
('bob02', 'Bob Costa', '/uploads/bob02.jpeg'),
('carol03', 'Carol Mendes', '/uploads/carolmendes.jpeg'),
('david04', 'David Rocha', '/uploads/davidrocha'),
('eva05', 'Eva Lima', '/uploads/evalima.jpeg'),
('felipe06', 'Felipe Souza', '/uploads/felipesouza.jpeg'),
('gabriela07', 'Gabriela Oliveira', '/uploads/gabrielaoliveira.jpeg'),
('henrique08', 'Henrique Almeida', '/uploads/henriquealmeida.jpeg'),
('isabela09', 'Isabela Pereira', '/uploads/isabelapereira.jpeg'),
('joao10', 'João Santos', '/uploads/joaosantos.jpeg'),
('karla11', 'Karla Martins', '/uploads/karlamartins.jpeg'),
('luan12', 'Luan Costa', '/uploads/luancosta.jpeg'),
('mariana13', 'Mariana Rocha', '/uploads/marianarocha.jpeg'),
('natalia14', 'Natália Lima', '/uploads/natalialima.jpeg'),
('olga15', 'Olga Fernandes', '/uploads/olgafernandes.jpeg'),
('lucas_ferreira', 'Lucas Ferreira', '/uploads/lucasferreira.jpeg');

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


INSERT INTO news (title, description, text, link, image, category, decade, year, is_featured)
VALUES 
('Caryn Campbell, uma das vítimas de Ted Bundy, estava de férias com sua família em seu hotel quando Bundy a sequestrou.', 'Campbell tinha 23 anos quando desapareceu do resort no Colorado. Ela foi vista pela última vez indo ao saguão buscar uma revista e nunca voltou. Bundy provavelmente usou uma história falsa para atraí-la. Seu corpo foi descoberto pouco antes de sua namorada visitá-lo.', 'https://www.reddit.com/r/serialkillers/comments/1794p7g/caryn_campbell_one_of_ted_bundys_victims_was_on/?tl=pt-br', 'https://preview.redd.it/pp26p25s4kub1.jpg?width=640&crop=smart&auto=webp&s=d41e9de0739c1a10aba95b9ec0301af1dfda45d7', 'Homicídio', '70', 1975, FALSE),

('Há 50 anos, Lynda Ann Healy foi sequestrada e assassinada por Ted Bundy. Ela tinha 21 anos e acredita-se que foi sua primeira vítima.', 'Aos 21 anos, Lynda Ann Healey desapareceu em 1974. Sangue foi encontrado em seus lençóis, e sua camisola pendurada no armário. Ela ficou 14 meses desaparecida até que ossos foram encontrados em Taylor Mountain, perto de sua casa.', 'https://aventurasnahistoria.com.br/noticias/vitrine/historia-as-vitimas-esquecidas-de-ted-bundy.phtml', 'https://m.media-amazon.com/images/M/MV5BYTc1YTdkMGMtYmE4MC00OWY4LTk2ODMtYzNlMjgzN2Q1OTYwXkEyXkFqcGc@._V1_.jpg', 'Homicídio', '70', 1974, FALSE),

('Em memória de Kimberly Leach, 12, a última vítima de Ted Bundy:  mundo perdeu uma grande alma', 'Kimberly Leach, 12 anos, desapareceu em 1978 em Lake City, Flórida. A polícia prendeu Ted Bundy, já procurado pelo FBI. Dois meses depois, seu corpo foi encontrado em um galpão atrás do Suwannee River State Park.', 'https://aventurasnahistoria.com.br/noticias/vitrine/historia-as-vitimas-esquecidas-de-ted-bundy.phtml', 'https://s.abcnews.com/images/US/ted-bundy-victim-kimberly-leach-gty-jc-190212_hpEmbed_8x9_992.jpg', 'Homicídio', '70', 1978, TRUE),

('Quem ama não mata: o feminicídio de 1976 que ajudou a mudar a Justiça brasileira', 'Em 2023, o caso da socialite Ângela Maria Fernandes Diniz, morta a tiros em 1976 pelo namorado Doca Street, foi citado no STF como marco contra o feminicídio e violência doméstica no Brasil.', 'https://g1.globo.com/rj/rio-de-janeiro/noticia/2023/09/16/quem-ama-nao-mata-o-feminicidio-de-1976-que-ajudou-a-mudar-a-justica-brasileira.ghtml', 'https://s2-g1.glbimg.com/EAoaCfzNqe--luX2gMijvbzxe-k=/0x0:538x303/984x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_59edd422c0c84a879bd37670ae4f538a/internal_photos/bs/2023/X/9/BBiLQcQZ6P4dU9f51QPw/angela-1-credito-arquivo-do-processo-judicial.jpg', 'Feminicídio', '70', 1976, TRUE),

('Caso Carlinhos', 'Em 1973, Carlinhos foi sequestrado em casa no Rio de Janeiro. A família recebeu um pedido de resgate, mas o destino do menino permanece desconhecido. O caso teve investigações controversas e suspeitas sobre o envolvimento do pai, que foram inconclusivas.', 'https://oglobo.globo.com/rio/dez-crimes-que-chocaram-rio-de-janeiro-17845895', 'https://s2-oglobo.glbimg.com/uiRGc_uaXEtQ5oMA8XHXJJaNCwk=/0x0:648x581/888x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_da025474c0c44edd99332dddb09cabe8/internal_photos/bs/2024/c/l/dIuV18SemrqJeh7b8gPg/captura-de-tela-2024-04-06-204447.jpg', 'Assassinato', '70', 1973, FALSE);


('1980 o ano que ficou marcado como a décadas dos SERIAL KILLERS nos EUA:', 'Durante três décadas da segunda metade do século 20, a América do Norte registrou um crescimento expressivo no número de homicídios em série, caracterizados por crimes semelhantes cometidos por um mesmo autor, os chamados serial killers. Esse aumento teve início nos anos 1960 e intensificou-se nas décadas seguintes, atingindo seu auge nos anos 1980, quando os casos se tornaram mais frequentes e notórios.', 'https://www.bbc.com/portuguese/internacional-45363043', 'Criminologia', '80', 1980, TRUE),

('Um homem aparentemente inofensivo dos EUA: Ted Bundy', 'Jeffrey Dahmer, o Canibal de Milwaukee, matou 17 homens e garotos entre 1977 e 1991. Nascido em 1960, cometeu o primeiro assassinato aos 17 anos. Atraía vítimas para casa, onde cometia atos horríveis e desmembrava os corpos. Antes da prisão, teve problemas com a lei e foi expulso do exército. A série "Dahmer: Um canibal americano", de Ryan Murphy, estreia na Netflix.', 'https://f5.folha.uol.com.br/cinema-e-series/2022/10/jeffrey-dahmer-por-que-serie-sobre-serial-killer-americano-causa-tanta-polemica.shtml', 'Homicídio-qualificado', '80', 1980, TRUE),

('O assassino em série que fez com que os palhaços nos aterrorizaram: John Wayne Gacy', 'John Wayne Gacy, nascido em 1942 nos subúrbios de Chicago, teve uma infância marcada por abusos. Trabalhou em funerária, casou-se e virou gerente de restaurante, onde começou seus crimes. Em 1967, foi preso por abuso de menor, mas saiu após 16 meses. Enriquecido com sua empresa, criou o palhaço Pogo para eventos infantis, ocultando sua verdadeira face de predador sexual e assassino.', 'https://brasil.elpais.com/brasil/2019/06/28/actualidad/1561705341_083525.html', 'Serial Killers', '80', 1980, TRUE),

('Alemanha condena ‘enfermeiro da morte’ que assassinou 85 pacientes', 'Niels Högel, enfermeiro alemão de 42 anos, foi condenado à prisão perpétua por matar 85 pacientes entre 2000 e 2005. A justiça considerou sua culpa "particularmente grave", anulando a chance de liberdade após 15 anos. Preso há 10 anos, Högel já havia sido condenado antes. É considerado o maior assassino em massa da Alemanha desde a Segunda Guerra.', 'https://brasil.elpais.com/brasil/2019/06/06/internacional/1559810905_905194.html#?rel=mas', 'Homicídio em série', '80', 1980, TRUE),

('Assassinato de John Lennon: A Tragédia que Abalou o Mundo', 'Em 8 de dezembro de 1980, o ex-Beatle John Lennon foi assassinado a tiros por Mark David Chapman na entrada do edifício Dakota, em Nova York. Chapman, fã obcecado, alegou ter sido inspirado pelo livro "O Apanhador no Campo de Centeio". Lennon morreu a caminho do hospital, aos 40 anos.', 'https://people.com/john-lennon-death-what-to-know-7511226?utm_source=chatgpt.com', 'Assassinato', 80, 1980, TRUE)

('Chacina de Ácari', 'Caso ocorrido no Rio de Janeiro, envolvendo o desaparecimento de 11 jovens. Supostamente mortos por policiais, o caso evidenciou questões de violência policial e omissão estatal, gerando repercussão internacional e pedidos de justiça por parte das famílias das vítimas.', 'https://g1.globo.com/jornal-nacional/noticia/2024/12/04/chacina-de-acari-corte-interamericana-responsabiliza-brasil-pelo-desaparecimento-de-11-jovens-no-rio.ghtml', 'https://pbs.twimg.com/media/FYnV_70X0AANwOs.jpg', 'Chacina', '90', 1990, FALSE),

('Caso da menina Míriam', 'O desaparecimento e a morte da menina Míriam Brandão chocaram o Brasil em 1992. O caso expôs a brutalidade e a violência contra crianças, mobilizando a opinião pública e gerando questionamentos sobre a segurança infantil, além de deixar marcas profundas na memória coletiva.', 'https://www.em.com.br/app/noticia/gerais/2011/09/02/interna_gerais,248406/assassino-que-chocou-a-capital-em-1992-esta-proximo-da-liberdade.shtml', 'https://img.r7.com/images/r7-estudio-1990-a-decada-do-crime-24112022154352302?&no_crop=true', 'Homicídio', '90', 1992, FALSE),

('Caso Daniella Perez', 'O assassinato da atriz Daniella Perez em 1992, cometido por um colega de elenco, gerou grande comoção nacional. O crime foi amplamente coberto pela mídia e desencadeou um debate sobre feminicídio, culminando em mudanças legislativas significativas e homenagens à memória da jovem atriz.', 'https://www.cnnbrasil.com.br/entretenimento/daniella-perez-assassinato-de-atriz-completa-32-anos-relembre-o-caso/L', 'https://s2-oglobo.glbimg.com/cW6BerL4pb_WXtZd550OYmPyIBU=/0x0:5545x3372/924x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_da025474c0c44edd99332dddb09cabe8/internal_photos/bs/2022/E/L/FdCKeyTmaQxLHI5atsHA/61507276-rio-de-janeiro-rj-11-11-1992-televisao-rj-tv-globo-novela-de-corpo-e-alma-g.jpg', 'Feminicídio', '90', 1992, TRUE),

('Caso Maníaco do Parque', 'Francisco de Assis Pereira, o Maníaco do Parque, aterrorizou São Paulo no final dos anos 1990 com uma série de assassinatos brutais. Ele atraía mulheres ao parque sob falsos pretextos e as assassinava, chocando o país e desencadeando uma caçada policial que revelou seu histórico de crimes e abusos.', 'https://www.cnnbrasil.com.br/nacional/relembere-o-caso-do-maniaco-do-parque-tema-de-filme-que-estreia-hoje/', 'https://img.r7.com/images/r7-estudio-1990-a-decada-do-crime-24112022154355697?&no_crop=true', 'Assassinato em série', '90', 1998, TRUE),

('Caso atirador do shopping', 'Em 1998, um atirador abriu fogo em um shopping center no Brasil, deixando vítimas e espalhando pânico entre os frequentadores. O caso trouxe à tona discussões sobre segurança em locais públicos e o controle de armas, além de gerar investigações para entender as motivações do agressor.', 'https://www.cnnbrasil.com.br/nacional/atirador-do-shopping-morumbi-em-sp-deixa-prisao-apos-25-anos-entenda/', 'https://img.r7.com/images/r7-estudio-1990-a-decada-do-crime-24112022154353116?dimensions=780x340', 'Homicídio', '90', 1998, FALSE),

('Caso Richthofen: o assassinato que chocou o Brasil', 'O assassinato de Manfred e Marísia von Richthofen, pais de Suzane von Richthofen, ocorreu na madrugada de 31 de outubro de 2002. Suzane planejou o crime junto com Daniel e Cristian Cravinhos para acessar a herança familiar. Os pais foram mortos a golpes de barra de ferro. Os três foram condenados por homicídio triplamente qualificado.', 'https://www.estadao.com.br/brasil/suzane-von-richthofen-relembre-como-a-policia-desvendou-o-caso-e-como-estao-os-acusados-hoje-nprm/?srsltid=AfmBOoqZBMPPJO2h4wZQ08-8KSyoDpJJrukW4eAlbP5AU80rc2e4U3Ps', 'https://www.google.com/url?sa=i&url=https%3A%2F%2Foglobo.globo.com%2Fepoca%2Fbrasil%2Fserie-de-tv-inspirou-assassinos-dos-pais-de-suzane-von-richthofen-24195277&psig=AOvVaw1cAvLHikOltyJTWYH1qSio&ust=1746815382263000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCICa2-LAlI0DFQAAAAAdAAAAABAU', 'Crime hediondo', '2000', 2002, TRUE),

('Caso Friedenbach-Caffé: o crime brutal que chocou o Brasil', 'Em novembro de 2003, Liana Friedenbach e Felipe Caffé foram sequestrados por Champinha e seu grupo em Embu-Guaçu. Felipe foi executado com um tiro na nuca, enquanto Liana foi violentada e morta dias depois. O caso causou comoção nacional e gerou debates sobre maioridade penal e violência juvenil no Brasil.', 'https://projetocolabora.com.br/ods16/caso-champinha-crime-perverso-fim-aventura-adolescentes-apaixonados/', 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fveja.abril.com.br%2Fcoluna%2Fradar%2Fos-motivos-de-friedenbach%2F&psig=AOvVaw3TqFflUPctiweo8Yt4wOJz&ust=1746812657040000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCIiBvMy2lI0DFQAAAAAdAAAAABAE', 'Crime hediondo', '2000', 2003, FALSE),

('Caso Madeleine McCann: o desaparecimento que mobilizou o mundo', 'Madeleine McCann desapareceu em 3 de maio de 2007 no resort Praia da Luz, Portugal, enquanto seus pais jantavam. A polícia portuguesa foi criticada por falhas na investigação. Em 2020, um suspeito alemão foi identificado, mas o paradeiro da menina ainda é um mistério. O caso segue sem solução e é um dos mais midiáticos da história.', 'https://www.cnnbrasil.com.br/tudo-sobre/caso-madeleine-mccann/','https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.estadao.com.br%2Finternacional%2Fcaso-madeleine-mccann-testemunha-chave-policia-ignorou-denuncia-nprei%2F&psig=AOvVaw3kuRqBRGAK7xK1NWd7-31f&ust=1746815955934000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCPjy9P3ClI0DFQAAAAAdAAAAABAE', 'Crime de Sequestro', '2000', 2007, FALSE),

('Caso Ônibus 174: o sequestro que parou o Brasil', 'Em 12 de junho de 2000, Sandro Barbosa do Nascimento sequestrou um ônibus no Rio de Janeiro, mantendo reféns por quase cinco horas. O episódio foi transmitido ao vivo e terminou com a morte da refém Geísa Firmo Gonçalves, atingida por disparos durante a ação policial. Sandro foi capturado, mas morreu asfixiado na viatura. O caso gerou críticas à atuação da polícia.', 'https://oglobo.globo.com/blogs/blog-do-acervo/post/2024/03/sequestro-do-onibus-174-horas-de-tensao-com-uma-tragedia-no-final.ghtml', 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.metropoles.com%2Fbrasil%2Fem-2000-brasil-assistia-ao-vivo-ao-terror-do-sequestro-do-onibus-174&psig=AOvVaw1rzpVZKeQczLDJzrR286dA&ust=1746816417243000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCKCzwt_ElI0DFQAAAAAdAAAAABAc', 'Crime Hediondo', '2000', 2000, FALSE),

('Caso Isabella Nardoni: o assassinato que comoveu o Brasil', 'Em 29 de março de 2008, Isabella Nardoni, de cinco anos, foi jogada do sexto andar de um prédio em São Paulo. As investigações apontaram para o pai, Alexandre Nardoni, e a madrasta, Anna Carolina Jatobá, como responsáveis pelo crime. Ambos foram condenados por homicídio triplamente qualificado, e o caso gerou grande comoção nacional e debates sobre violência infantil.', 'https://g1.globo.com/tudo-sobre/isabella-nardoni/', 'https://www.google.com/url?sa=i&url=https%3A%2F%2Ffotografia.folha.uol.com.br%2Fgalerias%2F1594787331937579-caso-isabella-nardoni&psig=AOvVaw1Vx6Plto7LMX9G4Wl8QN-T&ust=1746816729925000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCKjJhuTFlI0DFQAAAAAdAAAAABAQ', 'Crime Hediondo', '2000', 2008, FALSE),

(' Caso Eliza Samudio: o assassinato que abalou o mundo do futebol', 'O assassinato de Eliza Samudio, em 2010, envolveu o goleiro Bruno Fernandes, então astro do Flamengo. Eliza foi sequestrada e morta por ordem de Bruno após pedir reconhecimento de paternidade. O crime teve grande repercussão, gerando debates sobre violência doméstica e impunidade. Bruno foi condenado a 22 anos e tentou retomar a carreira após a prisão.', 'https://g1.globo.com/tudo-sobre/eliza-samudio/', 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.terra.com.br%2Fnos%2Fcaso-eliza-samudio-mostra-sequencia-de-violencias-contra-mulheres-que-podem-culminar-no-feminicidio%2Cbc07da706ecd9218d15015d395480e26q41lbiem.html&psig=AOvVaw0Q8Ci_lYM1EAGhzJFnngSr&ust=1746817806764000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCODj0ujJlI0DFQAAAAAdAAAAABAQ', 'Crime Hediondo', '2000', 2010, TRUE),

('Caso Luka Magnotta: o assassino que chocou o mundo pela internet', 'O assassinato de Jun Lin, em 2012, foi um dos crimes mais brutais da era digital. Luka Magnotta matou, esquartejou e enviou partes do corpo da vítima a escolas e partidos políticos no Canadá. O crime foi filmado e divulgado na internet, chocando o mundo. Magnotta foi capturado na Alemanha e condenado à prisão perpétua.', 'https://noticias.uol.com.br/ultimas-noticias/efe/2017/06/21/canibal-de-montreal-se-casara-com-outro-preso-no-final-do-mes.htm', 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.rfi.fr%2Fbr%2Famericas%2F20130311-esquartejador-canadense-acusado-de-matar-o-namorado-sera-julgado-partir-desta-segu&psig=AOvVaw0Q61nucOq5Zk5DMiUXYSqM&ust=1746818123387000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCKDcyP7KlI0DFQAAAAAdAAAAABAE', 'Crime Hediondo', '2010', 2012, FALSE),

(' Caso Chris Watts – O assassinato da família perfeita', 'Em 2018, Chris Watts matou a esposa grávida e as duas filhas pequenas em Colorado, EUA. Ele enterrou a esposa em uma cova rasa e jogou os corpos das filhas em tanques de óleo. O crime chocou pela frieza e pelo contraste entre a imagem de família perfeita nas redes sociais e a realidade sombria do assassinato.', 'https://g1.globo.com/mundo/noticia/2019/03/07/homem-que-matou-esposa-gravida-e-duas-filhas-nos-eua-revela-pela-primeira-vez-como-cometeu-crime.ghtml', 'https://s2-g1.glbimg.com/z-wrGH4Mf2M205byQAxvPkNKh-Y=/0x0:1700x1065/1008x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_59edd422c0c84a879bd37670ae4f538a/internal_photos/bs/2018/J/8/G8hTVPTjK9BFF3hdqHBg/ap18323689553525.jpg', 'Crime Hediondo', '2010', 2018, TRUE),

('Caso Stephen Paddock – O Massacre de Las Vegas', 'Em outubro de 2017, Stephen Paddock abriu fogo contra uma multidão em um festival de música country em Las Vegas, matando 60 pessoas e ferindo mais de 800. O ataque, o mais letal da história dos EUA, foi realizado do 32º andar do Mandalay Bay Hotel. Paddock se suicidou antes da abordagem policial e nunca foi encontrada uma motivação clara.', 'https://g1.globo.com/mundo/noticia/veja-quem-e-stephen-paddock-o-atirador-de-las-vegas.ghtml', 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.bbc.com%2Fportuguese%2Fbrasil-41467442&psig=AOvVaw38yRNrEAQW2vGujlcwdbJv&ust=1746818529641000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCKj727vMlI0DFQAAAAAdAAAAABAE', 'Crime Hediondo', '2010', 2017, FALSE),

('Família encontrada carbonizada no ABC: o que se sabe e o que falta saber', 'Na madrugada de 28 de janeiro, três membros de uma família foram encontrados carbonizados em um carro em chamas no ABC Paulista. As vítimas, empresários e seu filho, foram torturados e mortos. A polícia investiga cinco suspeitos, incluindo a filha mais velha do casal e sua namorada, ambas presas.', 'https://g1.globo.com/sp/sao-paulo/noticia/2020/02/05/familia-encontrada-carbonizada-no-abc-o-que-se-sabe-e-o-que-falta-saber.ghtml', 'https://s2-g1.glbimg.com/swOzblxH-ySGR9zsG1N9gDwtv2E=/1280x0/filters:format(jpeg)/https://s04.video.glbimg.com/x720/8288631.jpg', 'Homicídio', '2020', 2020, TRUE),

('Caso Miguel: como foi a morte do menino que caiu do 9º andar de prédio no Recife', 'Miguel Otávio, 5 anos, morreu após cair do 9º andar de um prédio em Recife. Ele estava sob os cuidados da patroa de sua mãe. A patroa foi presa por homicídio culposo e liberada após pagar fiança. A mãe viu Miguel com dificuldades para respirar e recebeu imagens das câmeras, revoltando-se com o ocorrido.', 'https://g1.globo.com/sp/sao-paulo/noticia/2020/02/05/familia-encontrada-carbonizada-no-abc-o-que-se-sabe-e-o-que-falta-saber.ghtml','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQELjHpSeuAS6NriHi0tm6_DbnNh-92Ev04Bg&s','Homicídio', '2020', 2020, TRUE),

('Caso Isabele: amiga que matou adolescente de 14 anos em MT é indiciada junto com namorado, pai e sogro', 'Isabele, 14 anos, morreu após ser atingida por um tiro disparado por sua amiga, também de 14 anos. A amiga foi indiciada por homicídio doloso. O namorado da amiga e o pai dele respondem por porte ilegal de arma e omissão na guarda das armas, que foram usadas para o disparo fatal.', 'https://g1.globo.com/mt/mato-grosso/noticia/2020/09/02/investigacao-policial-sobre-morte-de-adolescente-em-cuiaba-responsabiliza-amiga-que-disparou-namorado-dela-e-indicia-pai-e-sogro.ghtml', 'https://s2-g1.glbimg.com/L-Ke8jsj94siAI-WKauZ4BX-L1k=/0x0:412x448/984x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_59edd422c0c84a879bd37670ae4f538a/internal_photos/bs/2020/3/I/xAfxa6SOaSjmcWUieAQQ/whatsapp-image-2020-07-13-at-08.03.01.jpeg', 'Homicídio', '2020', 2020, FALSE),

('Menina de 10 anos estuprada pelo tio no Espírito Santo tem gravidez interrompida', 'A menina de 10 anos, vítima de estupro pelo tio desde os 6 anos, teve a gravidez interrompida em hospital de referência em Pernambuco, com autorização judicial. O tio está foragido, indiciado por estupro de vulnerável e ameaça. O MP investiga tentativas de pressão contra a família para impedir o aborto.', 'https://g1.globo.com/pe/pernambuco/noticia/2020/08/17/menina-de-10-anos-estuprada-pelo-tio-no-es-tem-gravidez-interrompida.ghtml', 'https://s02.video.glbimg.com/640x360/8783097.jpg', 'Estrupo de vulnerável', '2020', 2020, TRUE),

('Polícia procura por homem que matou a facadas a ex-mulher e a ex-sogra em festa de aniversário na Zona Leste de SP', 'Luís Felipe Oliveira é procurado após matar a ex-mulher Nathalia e a ex-sogra Priscila em uma festa na Zona Leste de SP. Ele também feriu outras pessoas. Luís não aceitava o fim do relacionamento. O carro usado na fuga foi encontrado, mas a arma do crime ainda não.', 'https://g1.globo.com/sp/sao-paulo/noticia/2020/10/13/policia-procura-por-homem-que-matou-a-facadas-a-ex-mulher-e-a-ex-sogra-em-festa-de-aniversario-na-zona-leste-de-sp.ghtml', 'https://s2-g1.glbimg.com/xkZSnzYaNqHO7CTfmEOuJh3yPAc=/696x390/smart/filters:cover():strip_icc()/s04.video.glbimg.com/x720/8937735.jpg', 'Feminicídio', '2020', 2020, FALSE),

('Elize Matsunaga: O crime e o castigo da mulher que matou e esquartejou o marido', 'Em 19 de maio de 2012, Elize Matsunaga matou seu marido, Marcos Kitano Matsunaga, após uma discussão sobre suas traições. Após o assassinato, Elize esquartejou o corpo e o colocou em malas de viagem, abandonando-o em uma rodovia. O crime foi descoberto quando o corpo foi encontrado e identificado em 23 de maio. O casal tinha uma relação conturbada e Elize agiu após desconfiar de mais traições.', 'https://oglobo.globo.com/blogs/blog-do-acervo/post/2023/02/elize-matsunaga-o-crime-e-o-castigo-da-mulher-que-matou-e-esquartejou-o-marido.ghtml', 'Feminicídio', 'anos 2010', 2010, TRUE),

('Isabela Nardoni: Alexandre Condenado por matar a filha, Nardoni é liberado para passar fim de ano na praia', 'Em março de 2008, Isabella Nardoni caiu da janela do 6º andar de um prédio em São Paulo, estando sob os cuidados do pai, Alexandre Nardoni, e da madrasta, Anna Carolina Jatobá. A investigação revelou que a menina foi agredida pela madrasta e jogada pela janela pelo pai. Ambos foram condenados em 2010: Alexandre a 31 anos e Anna a 26 anos e oito meses de prisão.', 'Em março de 2008, Isabella Nardoni caiu da janela do 6º andar de um prédio em São Paulo, estando sob os cuidados do pai, Alexandre Nardoni, e da madrasta, Anna Carolina Jatobá. A investigação revelou que a menina foi agredida pela madrasta e jogada pela janela pelo pai. Ambos foram condenados em 2010: Alexandre a 31 anos e Anna a 26 anos e oito meses de prisão.', 'Homicídio familiar.', 'anos 2000', 2008, TRUE),

('Caso Eloá', 'Em 13 de outubro de 2008, Lindemberg Alves sequestrou sua ex-namorada, Eloá, e a amiga Nayara, após o fim do relacionamento. Após quase 100 horas de cativeiro, a polícia invadiu o apartamento. Nayara foi libertada ferida, mas Eloá foi baleada na cabeça e na virilha, e teve a morte cerebral confirmada em 18 de outubro. O sequestrador foi capturado após a operação policial.', 'https://rollingstone.com.br/noticia/caso-eloa-producoes-para-entender-a-historia-que-chocou-o-pais/#google_vignette', 'Sequestro e Homicídio', 'anos 2000', 2008, TRUE),

('Ônibus 174', 'Em 12 de junho de 2000, Sandro Barbosa Nascimento sequestrou passageiros do ônibus 174 no Rio de Janeiro. A ação, transmitida ao vivo, durou mais de quatro horas e terminou com a morte de uma passageira, Geísa Firmo Gonçalves, e do sequestrador. Durante a abordagem, um policial do Bope disparou acidentalmente contra Geísa, que foi morta junto com o sequestrador minutos depois.', 'Em 12 de junho de 2000, Sandro Barbosa Nascimento sequestrou passageiros do ônibus 174 no Rio de Janeiro. A ação, transmitida ao vivo, durou mais de quatro horas e terminou com a morte de uma passageira, Geísa Firmo Gonçalves, e do sequestrador. Durante a abordagem, um policial do Bope disparou acidentalmente contra Geísa, que foi morta junto com o sequestrador minutos depois.', 'Sequestro', 'anos 2000', 2000, TRUE),


('Mulher que matou 5 filhos é inocentada nos EUA', 'A americana Andrea Yates, que matou seus cinco filhos afogando-os em 2001, escapou da prisão perpétua em um segundo julgamento em 2006, após um júri aceitar que ela sofria de problemas mentais. Em 2002, ela foi condenada à prisão perpétua, mas alegou não estar mentalmente apta na época do crime. Ela foi enviada para um hospital psiquiátrico até ser considerada sã.', 'https://www.bbc.com/portuguese/noticias/story/2006/07/060726_yates_novojulgamentopu', 'Infanticídio', 'anos 2000', 2001, TRUE),

('A Dália Negra', 'A "Dália Negra", Elizabeth Short, uma aspirante a atriz de 23 anos, foi brutalmente assassinada e seu corpo encontrado em 15 de janeiro de 1947, em Los Angeles. A investigação revelou que ela passou seus últimos meses na zona sul da cidade, mas o crime nunca foi resolvido. A história ganhou fama mundial, sendo retratada em livros, filmes e games.', 'https://super.abril.com.br/mundo-estranho/o-que-foi-o-crime-da-dalia-negra/', 'Assassinato', 'anos 1940', 1947, TRUE),

('Há 129 anos, o caso Lizzie Borden escandalizava os Estados Unidos', 'https://aventurasnahistoria.com.br/noticias/reportagem/historia-crime-caso-lizzie-borden-assassinato.phtml', 'Duplo homicídio', 'anos 1890', 1892, TRUE),

('Deadpool Killer', 'Wade Wilson foi condenado à pena de morte pelo assassinato de Kristine Melton e Diane Ruiz em outubro de 2019, em Cape Coral, Flórida. Ele atacou também sua ex-namorada, Melissa Montanez. Em junho, um júri o considerou culpado de homicídios em primeiro grau e premeditados. Em 27 de junho, o juiz sentenciou Wilson à morte, após votação de jurados a favor da pena capital. As famílias das vítimas comemoraram a sentença.',  'https://aventurasnahistoria.com.br/noticias/historia-hoje/deadpool-killer-quem-saos-vitimas-do-homem-condenado-pena-de-morte.phtml', 'Homicídio duplo', 'anos 2010', 2019, TRUE),

('Caso do comerciante Igor Peretto', 'O caso do assassinato do comerciante Igor Peretto ocorreu em 31 de agosto de 2024. A vítima foi morta a facadas por Mário Vitorino, que teria sido incentivado por Rafaela Costa e Marcelly, esposa e irmã da vítima. As mulheres foram presas em 6 de setembro e Mário foi capturado em 15 de setembro, escondido na casa de um parente.', 'https://s2-g1.glbimg.com/JvhWoIpsq_9psv4aLok2MHcJYrA=/0x0:1200x800/984x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_59edd422c0c84a879bd37670ae4f538a/internal_photos/bs/2024/g/E/Ew0xjMQzCdBxGupwVeyw/crime-igor.jpg', 'https://s2-g1.glbimg.com/tDtHqbi2ATdsnc_Y_dgejmi1sYI=/0x0:1200x800/984x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_59edd422c0c84a879bd37670ae4f538a/internal_photos/bs/2024/X/S/icFN1mQA2nFYPPsesJeg/mario-marcelly-faca.jpg', 'Homicídio', '2020s', 2024, TRUE),

('Caso da trapezista argentina', 'Em dezembro de 2023, Florencia Aranguren foi brutalmente assassinada a facadas enquanto passeava com o cachorro em Búzios, RJ. Carlos José foi preso em flagrante e condenado a 33 anos de prisão. O corpo da trapezista foi encontrado em uma trilha e o cão permaneceu ao lado da vítima até a chegada das autoridades.', 'https://www.condorcontabilidade.com.br/nb2/rj/regiao-dos-lagos/noticia/2025/04/03/julgamento-marcado-acusado-de-matar-trapezista-argentina-em-buzios-enfrenta-o-tribunal-do-juri-no-dia-9-de-abril.ghtml', 'https://www.condorcontabilidade.com.br/nb2/rj/regiao-dos-lagos/noticia/2025/04/03/julgamento-marcado-acusado-de-matar-trapezista-argentina-em-buzios-enfrenta-o-tribunal-do-juri-no-dia-9-de-abril.ghtml', 'Homicídio', '2020s', 2023, FALSE),

('Caso do menino arremessado da ponte pelo pai', 'Em março de 2025, um homem arremessou o próprio filho de cinco anos de uma ponte em São Gabriel, RS, em um ato de vingança contra a ex-esposa. Ele confessou o crime e está preso.', 'https://www.cnnbrasil.com.br/wp-content/uploads/sites/12/2025/03/cantor-afogado-pe-2-2.jpg?w=1115', 'https://www.cnnbrasil.com.br/wp-content/uploads/sites/12/2025/03/cantor-afogado-pe-2-2.jpg?w=1115', 'Homicídio', '2020s', 2025, FALSE),

('Caso do motorista de app em SP', 'Em março de 2025, um motorista de aplicativo foi preso após tentar estuprar e roubar uma passageira de 21 anos no bairro da Casa Verde, zona norte de São Paulo. A vítima conseguiu fugir e o homem foi preso.', 'https://s2-g1.glbimg.com/JTYtBLWhlDV-pnM6l5rMDQd31mc=/1280x0/filters:format(jpeg)/https://thumbor.globoi.com/unsafe/fit-in/1280x720/s03.video.glbimg.com/deo/vi/54/13/13491354', 'https://s2-g1.glbimg.com/JTYtBLWhlDV-pnM6l5rMDQd31mc=/1280x0/filters:format(jpeg)/https://thumbor.globoi.com/unsafe/fit-in/1280x720/s03.video.glbimg.com/deo/vi/54/13/13491354', 'Violência Sexual', '2020s', 2025, FALSE),

('Caso Clara Maria em MG', 'Em março de 2025, Clara Maria, de 21 anos, foi encontrada morta e concretada em uma casa em Belo Horizonte. Os suspeitos Thiago e Pimentel foram presos após confessarem o crime.', 'https://www.cnnbrasil.com.br/wp-content/uploads/sites/12/2025/03/Clara-Maria.jpg?w=880', 'https://s2-g1.glbimg.com/rhQd61z61dAkd5T2vboR-uWX7B8=/0x0:1022x592/600x0/smart/filters:gifv():strip_icc()/i.s3.glbimg.com/v1/AUTH_59edd422c0c84a879bd37670ae4f538a/internal_photos/bs/2025/m/D/C8rfRRQRGhT0NFJMBGUQ/suspeitos-clara-maria.jpg', 'Homicídio', '2020s', 2025, FALSE),

('Caso do cantor morto afogado em PE', 'Em fevereiro de 2025, um cantor foi encontrado morto após se afogar em um rio em Pernambuco. A polícia investiga as circunstâncias do afogamento e se houve envolvimento de terceiros.', 'https://www.cnnbrasil.com.br/wp-content/uploads/sites/12/2025/03/cantor-afogado-pe-2-2.jpg?w=1115', 'https://www.cnnbrasil.com.br/wp-content/uploads/sites/12/2025/03/cantor-afogado-pe-2-2.jpg?w=1115', 'Morte Suspeita', '2020s', 2025, FALSE),

('Filho mata pai alcoólatra em SC', 'Em fevereiro de 2025, um homem de 23 anos matou o pai de 47 anos a golpes de tesoura em São João Batista, SC. A vítima foi encontrada com 22 perfurações. O suspeito se entregou à polícia após o crime.', 'https://static.ndmais.com.br/2025/02/identificado-homem-morto-por-filho-a-tesouradas-sao-joao-batista-grande-florianopolis-elvis-marcos-da-silva-800x467.jpg', 'https://static.ndmais.com.br/2025/01/adalberto-fugitivo-presidio-florianopolis-550x310.png', 'Homicídio', '2020s', 2025, FALSE),


INSERT INTO podcasts (title, description, link, image, category, is_featured)
VALUES 
('O Maníaco do Parque: Ullisses Campbel', 'Ullisses é escritor, e ele  vai contar histórias do livro que escreveu sobre o Maníaco do Parque, e como ele ludibriava as vítimas com sua moto. O Vilela nunca faria algo parecido, pois ele anda de patinete elétrico.', 'https://www.youtube.com/live/m_JMZDlVK9k?feature=shared', 'https://www.cnnbrasil.com.br/wp-content/uploads/sites/12/2021/06/42316_FDE772628350F296.jpg?w=1200&h=900&crop=1', 'famoso', TRUE),
('Ilana Casoy', 'Ilana Casoy é escritora e expert em serial killers. Ilana tem como tema principal de seus livros os crimes de serial killers e assassinatos marcados pela perversidade, como os Nardoni e a Richthofen. O Vilela pensou em chamar a Richthofen para um papo, mas ela só estaria disponível no Dia das Mães.', 'https://www.youtube.com/live/YWaIk5BM3So?feature=shared', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQSZoSgadoZHW4HQo_85eXKaM55ms5fj_mvUg&s', 'antigo', TRUE),
('Crimes Reais: Ivan Mizanzuk', 'Ivan Mizanzuk é  professor universitário, designer, escritor, produtor de podcasts e jornalista. Ele conta “histórias reais de pessoas reais” no podcast Projeto Humanos. Já o Vilela só contrata projetos de humanos para trabalharem com ele.', 'https://youtu.be/UywLajXBLw4?feature=shared', 'https://vejasp.abril.com.br/wp-content/uploads/2023/08/Ilana-Casoy-Erik-Almeida-Divulgac%CC%A7a%CC%83o.jpg.jpg?crop=1&resize=1212,909', 'reais', TRUE),
('Ela cuida das mentes mais pertubadas - Gabriela Cruz', 'Ela conhece a mente dos ped0filos! Gabriela Cruz é uma renomada psicóloga especialista em sexualidade humana. Antes de atender em clínicas, ela trabalhou durante anos em penitenciárias, acompanhando indivíduos condenados por ped0filia e outros cr1mes s3xuais', 'https://youtu.be/mdwQUT0i5dc?feature=shared', 'https://i.ytimg.com/vi/mdwQUT0i5dc/maxresdefault.jpg', 'investigacao', TRUE),
('Crimes reais: Perita Rosangela Monteiro e Delegado Mauro Dias', 'Dra. Rosangela  é psicóloga e perita criminal, e MAURO DIAS é ex-delegado. Eles vão conversar sobre crimes reais e os processos de investigação e perícia para desvendar os casos. O Vilela é expert em esconder que comeu todo o chocolate da casa que nem um CSI São Paulo resolveria o caso.', 'https://www.youtube.com/live/28WQA1o1CDQ?feature=shared', 'https://i.ytimg.com/vi/28WQA1o1CDQ/maxresdefault.jpg', 'investigação', TRUE),
('Crimes Reais: Caso Nardoni', 'Discussão sobre o assassinato de Isabella Nardoni.', 'https://www.youtube.com/watch?v=1XyODZb7APk', 'https://f.i.uol.com.br/fotografia/2018/03/12/15209076785aa7359ecb363_1520907678_3x2_xl.jpg', 'famoso', TRUE);

INSERT INTO podcasts (title, description, link, image, category, is_featured)
VALUES
('Crimes Reais: Caso Marísia e Marcos Matsunaga', 'Investigação sobre o assassinato de Marísia e Marcos Matsunaga.', 'https://www.youtube.com/watch?v=skj1q8v-f8k', 'https://s2-oglobo.glbimg.com/yqppgndr5hdBMscIOL-7ioLS2LM=/0x0:620x415/984x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_da025474c0c44edd99332dddb09cabe8/internal_photos/bs/2023/5/p/3jKTd5TzGIg9jBqCYRLA/63080943.jpg', 'investigacao', FALSE),
('Crime Junkie', 'Podcast semanal dedicado a cobrir casos de crimes reais.', 'https://open.spotify.com/show/3DgfoleqaW61T2amZQKINx', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTC3zmZm2qANnrB1IJ3qbjpzcfJmfVYrYUaLQ&s', 'impactante', TRUE),
('Most Notorious! A True Crime History Podcast', 'Histórias reais de crimes, criminosos, tragédias e desastres ao longo da história.', 'https://open.spotify.com/show/1JeYsvYZI4OxGTC9TJljLV', 'https://i.scdn.co/image/ab6765630000ba8a70b77a43012ee744d13a66a5', 'reais', FALSE),
('Crimecast', 'Podcast sobre crimes reais, abordando histórias conhecidas no Brasil e no mundo.', 'https://open.spotify.com/show/07MoJXc7KpasBvDSJVOMw8', 'https://cdn-images.dzcdn.net/images/talk/08fcb47cb1970a881f34258fc451b553/1900x1900-000000-80-0-0.jpg', 'investigacao', TRUE),
('Real Crime', 'Documentários completos sobre crimes, gangsters, serial killers e as pessoas mais infames da história.', 'https://open.spotify.com/show/0JLjqhHBRN8qMTGKikm97B', 'https://m.media-amazon.com/images/I/91O+l7tjmdL._AC_UF894,1000_QL80_.jpg', 'investigacao', FALSE),
('Crimes Reais: Telma Rocha, Edu Tachlitsky e Leandro Lopes', 'Discussão sobre crimes reais no Brasil com especialistas.', 'https://www.youtube.com/watch?v=SCYsS6VgxPY', 'https://i.ytimg.com/vi/u6iCbtzIGM4/maxresdefault.jpg', 'famoso', TRUE),
('Crimes Reais: Ricardo Salada e Jorge Lordello', 'Análise de casos criminais com especialistas.', 'https://www.youtube.com/watch?v=aPEYYaR8hVY', 'https://i.ytimg.com/vi/aPEYYaR8hVY/maxresdefault.jpg', 'impactante', FALSE),
('Podcat: Rosangela - Melhores momentos', 'Melhores momentos com a Dra. Rosângela Monteiro sobre o caso da Milena Dantas Bereta Nistarda, que tinha acabado de sair da delegacia onde prestou queixa contra o marido, Marcelo Nistarda Antoniassi. Mas quis o destino que ele a encontrasse. Milena terminou sem vida e teve ainda seu coração arr4ncad0 pelas mãos daquele que jurou protegê-la.', 'https://youtu.be/nreTvJi_Mz4?feature=shared', 'https://i.ytimg.com/vi/nreTvJi_Mz4/hqdefault.jpg', 'impactante', TRUE );

INSERT INTO podcasts (title, description, link, image, category, is_featured)
VALUES
('Christian Costa', 'Ele é diretor do Centro de Estudos do Comportamento Cr1min4l! O Dr. Christian Costa é um renomado profissional da área da psicologia cr1min4l, exaltado pelo seu trabalho de unir ciência e prática para tratar de cr1mes e psicopatologias.', 'https://youtu.be/0UwkMabyB78?feature=shared', 'https://emtempo.com.br/wp-content/uploads/2023/11/b0aaf3e3-5012-44bb-ade6-6d1e45e3297c.jpg', 'impactante', TRUE ),
('Márcia Lanze descobre morte através do tik tok', 'Ele foi pego pelo TikTok! Bruno Eustáquio ligou para a polícia depois de encontrar a mãe, Márcia Lanzane, m0rta. Porém, durante as investigações, os agentes descobriram uma dinâmica chocante: a mulher havia sido ass4ssin4da pelo próprio filho, que, depois de cometer o cr1me, foi para a sala e ficou assistindo televisão.', 'https://youtu.be/XKJ7Zzmifig?feature=shared', 'https://i.ytimg.com/vi/1M6QBfFAq7I/maxresdefault.jpg', 'impactante', TRUE ),
('Doutora Luíza - ela atuou em lugares que mudaram o Brasil', 'Ela atuou em casos que pararam o Brasil! Luísa Muchon é uma experiente advogada criminalista, que já trabalhou com casos de grande repercussão e conheceu de perto figuras emblemáticas do país. Além de ter sido advogada do casal Nardoni, foi a última pessoa a conversar com Farah Jorge Farah e representou diversos nomes associados à Operação Lava Jato.', 'https://youtu.be/NhK_MjWjxsU?feature=shared', 'https://is3-ssl.mzstatic.com/image/thumb/Podcasts112/v4/5f/fd/21/5ffd2174-6076-f55b-27bc-2daf7a0e93ca/mza_7189227837507334208.jpg/1200x1200bb.jpg', 'impactante', TRUE ),
('Caso Vitória Regina - Detalhes da investigação', 'Confira minha entrevista com o advogado da família de Vitória Regina de Sousa, morta entre o final de fevereiro e começo de março de 2025, em circunstâncias, no mínimo, estranhas. A polícia colocou o vizinho da família, Maicol Sales do Santos, como único suspeito e autor de tudo.', 'https://youtu.be/-W78mbchJbw?feature=shared', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSYW7tHdUdbmvozHaVKUCb5hQcvrdzn4Ma8bQ&s', 'investigação', TRUE),
('Jogada no lixo, vendida p/ homens, queimada vida', 'Ela nasceu Larissa Duque e hoje se tornou Heloisa. Tudo para fugir da mãe narcisista que criou um enredo de vida e m0rte para a filha. Ela consegiu mais que sobreviver, viver e vencer a progenitora que, logo ao dar a luz, jogou Heloisa no lixo. E esse foi só o começo... ', 'https://youtu.be/Kb0tZnF1IhU?feature=shared', 'https://s2-marieclaire.glbimg.com/1rLIfRAqEFgS2H8aepmgANIRAEw=/0x0:591x332/600x0/smart/filters:gifv():strip_icc()/i.s3.glbimg.com/v1/AUTH_51f0194726ca4cae994c33379977582d/internal_photos/bs/2024/g/9/NDBA7iTkGLEx2LkK6lsw/larissa-duque-pequena.png', 'investigação', TRUE),
('Crimes Reais: Ullisses Campbell e Beto Ribeiro', 'ULLISSES CAMPBELL é escritor, e BETO RIBEIRO é diretor e roteirista. Eles vão contar histórias e destrinchar crimes reais, como o caso da Suzane Von Richthofen. Agora que Suzane foi solta da cadeia, o Vilela já reforçou a segurança do porão, já que ele tem idade pra ser pai dela.', 'https://www.youtube.com/live/zU8Ahy3zL1c?feature=shared', 'https://i.ytimg.com/vi/zU8Ahy3zL1c/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLA0OXMP6xTmt11FYsC51hkilk9inA', 'casos reais', TRUE),
('Crimes Reais: Ju Cassini e Giovanna Alba', 'JU CASSINI e GIOVANNA ALBA são YouTubers. Elas vão bater um papo sobre os crimes reais da atualidade. O Vilela tem tanto medo de violência que dorme de capacete.', 'https://www.youtube.com/live/HnCFLkqkSHc?feature=shared', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTiYQNlmkbbRztXKmmdhXXVIBlVEMeGEDstHg&s', 'casos reais', TRUE),
('Crimes Reais: Ju Cassini e Beto', 'JU CASSINI é YouTuber e BETO RIBEIRO é diretor e roteirista. Eles vão bater um papo sobre crimes reais com histórias assustadoras, bizarras e misteriosas. O Vilela já se preparou e comprou mais fraldas geriátricas pra trocar nessa live.', 'https://www.youtube.com/live/n9YXRqNtows?feature=shared', 'https://i.ytimg.com/vi/n9YXRqNtows/maxresdefault.jpg', 'casos reais', TRUE),
('Crimes Reais: O caso mais pesado', 'TELMA ROCHA é fotógrafa pericial, e EDU TACHLITSKY e LEANDRO LOPES são peritos criminais do Departamento de Homicídios e Proteção à Pessoa de São Paulo. Eles vão esclarecer muitas dúvidas sobre os bastidores dos crimes mais conhecidos e também os mais curiosos. O Vilela que seu cuide, pois ele está sempre em minoria no porão.', 'https://youtu.be/7x0UoLX4kmQ?feature=shared', 'https://i.ytimg.com/vi/7x0UoLX4kmQ/maxresdefault.jpg', 'crimes antigos', TRUE),
('Crimes Reais: Ricardo Salada, Telma Rocha e Rafael Heck', 'RICARDO SALADA, TELMA ROCHA E RAFAEL HECK são peritos criminais. Eles trabalham no DHPP (Departamento de Homicídios e de Proteção à Pessoa) do estado de SP e vão bater um papo sobre crimes reais. Já o Vilela presenciou vários crimes do passado.', 'https://www.youtube.com/live/17PwIYnL28Y?feature=shared', 'https://i.ytimg.com/vi/17PwIYnL28Y/maxresdefault.jpg', 'crimes antigos', TRUE),
('Telma Rocha e André DÁvila', 'Neste podcast Telma Rocha e André DÁvila abordam questões cruciais relacionadas ao crime, à segurança pública e aos desafios enfrentados pela sociedade contemporânea.', 'https://youtu.be/azFRrtdUnvE?feature=shared', 'https://i.ytimg.com/vi/azFRrtdUnvE/sddefault.jpg?v=6362b027', 'crimes antigos', TRUE),
('Crimes Reais: Ricardo Ventura e Ricardo Salada ', 'RICARDO VENTURA é psicanalista e RICARDO SALADA é perito criminal. Hoje descobriremos mutas técnicas de como pegar o mentiroso e o bandido com as calças na mão. A Mari deveria assistir a essa live, pois é óbvio que o Vilela vai pisar na bola.', 'https://www.youtube.com/live/rMT78xVz_Qc?feature=shared', 'https://i.ytimg.com/vi/rMT78xVz_Qc/maxresdefault.jpg', 'crimes antigos', TRUE),
('Caso Família Gonçalves ', 'Em uma noite comum de janeiro de 2020, em São Bernardo do Campo, no Grande ABC de São Paulo, Flaviana Gonçalves chegava em casa do trabalho quando encontrou sua família rendida por três ladrões. O Romoyuki, o marido, Juan, o filho adolescente, Anaflávia, a filha e a namorada de sua filha, Carina, todos estavam sob a mira dos assaltantes. Flaviana foi levada ao quarto para passar suas senhas de banco, quando foi morta ao lado do caçula e do esposo. ', 'https://youtu.be/kcIpYBnwlBk?feature=shared', 'https://i.ytimg.com/vi/kcIpYBnwlBk/maxresdefault.jpg', 'crimes antigos', TRUE);


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
    ('Luiz Gabriel Lopes Carvalho Pinto', 'Desenvolvedor (a)', 'https://mail.google.com/mail/u/0?ui=2&ik=1a84e770a3&attid=0.1&permmsgid=msg-f:1832212135489621963&th=196d533ad104cfcb&view=fimg&fur=ip&permmsgid=msg-f:1832212135489621963&sz=s0-l75-ft&attbid=ANGjdJ_uSM2lS10wc1pjDksQ-c1DpQyGezR9izRsi9wmVRQmDctfDS4bVqhfLIyTIV4WF8AJS48rdHQaE8u4LzqGwwcXNhyRndhVkQHF_3rzn5EAWc8hggQsOna98d8&disp=emb&realattid=ii_196d5336f88654b64d21&zw', 1),
    ('Carlos Eduardo Ferraz Augusto', 'Desenvolvedor (a)', 'https://avatars.githubusercontent.com/u/158209729?s=400&u=ea58c944f794b2851f01abda7ad25341d06255dc&v=4', 1);


    ALTER TABLE likes ADD CONSTRAINT unique_user_post UNIQUE (user_id, post_id);
