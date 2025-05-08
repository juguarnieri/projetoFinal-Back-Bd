-- INSERTS de notícias pesquisadas com categorias específicas

INSERT INTO news (title, description, link, image, category, decade, year, is_featured) 
VALUES 
('Chacina de Ácari', 'Caso ocorrido no Rio de Janeiro envolvendo o desaparecimento de 11 jovens, supostamente mortos por policiais.', 'https://g1.globo.com/jornal-nacional/noticia/2024/12/04/chacina-de-acari-corte-interamericana-responsabiliza-brasil-pelo-desaparecimento-de-11-jovens-no-rio.ghtml', 'https://pbs.twimg.com/media/FYnV_70X0AANwOs.jpg', 'Chacina', '90', 1990, false),

('Caso da menina Míriam', 'Desaparecimento e morte da menina Míriam Brandão, caso que chocou o país.', 'https://www.em.com.br/app/noticia/gerais/2011/09/02/interna_gerais,248406/assassino-que-chocou-a-capital-em-1992-esta-proximo-da-liberdade.shtml', 'https://img.r7.com/images/r7-estudio-1990-a-decada-do-crime-24112022154352302?&no_crop=true', 'Homicídio', '1990s', 1992, false),

('Caso Daniella Perez', 'Assassinato da atriz Daniella Perez por um colega de elenco, gerando grande comoção nacional.', 'https://www.cnnbrasil.com.br/entretenimento/daniella-perez-assassinato-de-atriz-completa-32-anos-relembre-o-caso/L', 'https://s2-oglobo.glbimg.com/cW6BerL4pb_WXtZd550OYmPyIBU=/0x0:5545x3372/924x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_da025474c0c44edd99332dddb09cabe8/internal_photos/bs/2022/E/L/FdCKeyTmaQxLHI5atsHA/61507276-rio-de-janeiro-rj-11-11-1992-televisao-rj-tv-globo-novela-de-corpo-e-alma-g.jpg', 'Feminicídio', '90', 1992, true),

('Caso Maníaco do Parque', 'Francisco de Assis Pereira, conhecido como Maníaco do Parque, foi responsável por uma série de assassinatos em São Paulo.', 'https://www.cnnbrasil.com.br/nacional/relembere-o-caso-do-maniaco-do-parque-tema-de-filme-que-estreia-hoje/', 'https://img.r7.com/images/r7-estudio-1990-a-decada-do-crime-24112022154355697?&no_crop=true', 'Assassinato em série', '90', 1998, true),

('Caso atirador do shopping', 'Caso envolvendo um atirador em um shopping center brasileiro. Detalhes adicionais necessários.', 'https://www.cnnbrasil.com.br/nacional/atirador-do-shopping-morumbi-em-sp-deixa-prisao-apos-25-anos-entenda/', 'https://img.r7.com/images/r7-estudio-1990-a-decada-do-crime-24112022154353116?dimensions=780x340', 'Homicídio', '90', 1998, false);
