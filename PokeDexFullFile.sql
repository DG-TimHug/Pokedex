DROP DATABASE IF EXISTS pokedex;
CREATE DATABASE `pokedex`;
USE `pokedex`;
       
-- SCHEMA --

CREATE TABLE IF NOT EXISTS `Type` (
    `Slug` VARCHAR(10) NOT NULL,
    `Name` VARCHAR(100) NOT NULL,
    `Abbreviation` VARCHAR(10) NOT NULL,
    CONSTRAINT `PK_Type` PRIMARY KEY (`Slug`)
);

CREATE TABLE Pokemon (
    Id INT AUTO_INCREMENT,
    `Name` VARCHAR(100) NOT NULL,
    ImagePath VARCHAR(255),
    EvoCond TEXT,

    CONSTRAINT PK_Pokemon 
        PRIMARY KEY (Id)
);

SELECT Id as Id, Name as Name, EvoCond as EvolutionCondition from Pokemon Order by Id Desc;

CREATE TABLE PokemonEvolution (
    FromPokemonId INT NOT NULL,
    ToPokemonId   INT NOT NULL,

    CONSTRAINT PK_PokemonEvolution 
        PRIMARY KEY (FromPokemonId, ToPokemonId),

    CONSTRAINT FK_PokemonEvolution_FromPokemon
        FOREIGN KEY (FromPokemonId) 
        REFERENCES Pokemon(Id)
        ON DELETE CASCADE,

    CONSTRAINT FK_PokemonEvolution_ToPokemon
        FOREIGN KEY (ToPokemonId)   
        REFERENCES Pokemon(Id)
        ON DELETE CASCADE,

    CONSTRAINT CK_PokemonEvolution_NoSelfEvolution
        CHECK (FromPokemonId <> ToPokemonId)
);



CREATE TABLE PokemonType (
    PokemonId INT NOT NULL,
    TypeSlug  VARCHAR(10) NOT NULL,

    CONSTRAINT PK_PokemonType 
        PRIMARY KEY (PokemonId, TypeSlug),

    CONSTRAINT FK_PokemonType_Pokemon
        FOREIGN KEY (PokemonId) 
        REFERENCES Pokemon(Id)
        ON DELETE CASCADE,

    CONSTRAINT FK_PokemonType_Type
        FOREIGN KEY (TypeSlug)  
        REFERENCES Type(Slug)
);



-- DATA --

INSERT INTO `Type` (`Name`,`Abbreviation`,`Slug`) VALUES 
     ('Normal','NORMAL','normal')
    ,('Pflanze','PFL.','pflanze')
    ,('Feuer','FEUER', 'feuer')
    ,('Wasser','WASSER', 'wasser')
    ,('Elektro','ELEK.', 'elektro')
    ,('Kampf','KAMPF', 'kampf')
    ,('Flug','FLUG', 'flug')
    ,('Gift','GIFT', 'gift')
    ,('Boden','BODEN', 'boden')
    ,('Gestein','GEST.', 'gestein')
    ,('Käfer','KÄFER', 'kaefer')
    ,('Eis','EIS', 'eis')
    ,('Psycho','PSYCHO', 'psycho')
    ,('Geist','GEIST', 'geist')
    ,('Drache','DRA.', 'drache')
    ,('Unlicht','UNL.', 'unlicht')
    ,('Stahl','STAHL', 'stahl')
    ,('Fee','FEE', 'fee')
;


INSERT INTO Pokemon (Name, ImagePath, EvoCond) VALUES
('Bulbasaur',  'icons/001-bulbasaur.svg',  'Level 16'),
('Ivysaur',    'icons/002-ivysaur.svg',    'Level 32'),
('Venusaur',   'icons/003-venusaur.svg',   NULL),

('Charmander', 'icons/004-charmander.svg', 'Level 16'),
('Charmeleon', 'icons/005-charmeleon.svg', 'Level 36'),
('Charizard',  'icons/006-charizard.svg',  NULL),

('Squirtle',   'icons/007-squirtle.svg',   'Level 16'),
('Wartortle',  'icons/008-wartortle.svg',  'Level 36'),
('Blastoise',  'icons/009-blastoise.svg',  NULL),

('Caterpie',   'icons/010-caterpie.svg',   'Level 7'),
('Metapod',    'icons/011-metapod.svg',    'Level 10'),
('Butterfree', 'icons/012-butterfree.svg', NULL),

('Weedle',     'icons/013-weedle.svg',     'Level 7'),
('Kakuna',     'icons/014-kakuna.svg',     'Level 10'),
('Beedrill',   'icons/015-beedrill.svg',   NULL),

('Pidgey',     'icons/016-pidgey.svg',     'Level 18'),
('Pidgeotto',  'icons/017-pidgeotto.svg',  'Level 36'),
('Pidgeot',    'icons/018-pidgeot.svg',    NULL),

('Rattata',    'icons/019-rattata.svg',    'Level 20'),
('Raticate',   'icons/020-raticate.svg',   NULL),

('Spearow',    'icons/021-spearow.svg',    'Level 20'),
('Fearow',     'icons/022-fearow.svg',     NULL),

('Ekans',      'icons/023-ekans.svg',      'Level 22'),
('Arbok',      'icons/024-arbok.svg',      NULL),

('Pikachu',    'icons/025-pikachu.svg',    'Thunder Stone'),
('Raichu',     'icons/026-raichu.svg',     NULL),

('Sandshrew',  'icons/027-sandshrew.svg',  'Level 22'),
('Sandslash',  'icons/028-sandslash.svg',  NULL),

('Nidoran♀',   'icons/029-nidoran-f.svg',  'Level 16'),
('Nidorina',   'icons/030-nidorina.svg',   'Moon Stone'),
('Nidoqueen',  'icons/031-nidoqueen.svg',  NULL),

('Nidoran♂',   'icons/032-nidoran-m.svg',  'Level 16'),
('Nidorino',   'icons/033-nidorino.svg',   'Moon Stone'),
('Nidoking',   'icons/034-nidoking.svg',   NULL),

('Clefairy',   'icons/035-clefairy.svg',   'Moon Stone'),
('Clefable',   'icons/036-clefable.svg',   NULL),

('Vulpix',     'icons/037-vulpix.svg',     'Fire Stone'),
('Ninetales',  'icons/038-ninetales.svg',  NULL),

('Jigglypuff', 'icons/039-jigglypuff.svg', 'Moon Stone'),
('Wigglytuff', 'icons/040-wigglytuff.svg', NULL),

('Zubat',      'icons/041-zubat.svg',      'Level 22'),
('Golbat',     'icons/042-golbat.svg',     NULL),

('Oddish',     'icons/043-oddish.svg',     'Level 21'),
('Gloom',      'icons/044-gloom.svg',      'Leaf Stone'),
('Vileplume',  'icons/045-vileplume.svg',  NULL),

('Paras',      'icons/046-paras.svg',      'Level 24'),
('Parasect',   'icons/047-parasect.svg',   NULL),

('Venonat',    'icons/048-venonat.svg',    'Level 31'),
('Venomoth',   'icons/049-venomoth.svg',   NULL),

('Diglett',    'icons/050-diglett.svg',    'Level 26');


INSERT INTO PokemonEvolution (FromPokemonId, ToPokemonId) VALUES
(1,2),
(2,3),
(4,5),
(5,6),
(7,8),
(8,9),
(10, 11),
(11, 12),

(13, 14),
(14, 15),

(16, 17),
(17, 18),

(19, 20),

(21, 22),

(23, 24),

(25, 26),

(27, 28),
(29, 30),
(30, 31),

(32, 33),
(33, 34),

(35, 36),

(37, 38),

(39, 40),

(41, 42),

(43, 44),
(44, 45),

(46, 47),

(48, 49);



INSERT INTO pokemontype (PokemonId, TypeSlug) VALUES
(1,"pflanze"),
(1,"gift"),
(2,"pflanze"),
(2,"gift"),
(3,"pflanze"),
(3,"gift"),
(4,"feuer"),
(5,"feuer"),
(6,"feuer"),
(6,"flug"),
(7,"wasser"),
(8,"wasser"),
(9,"wasser"),
-- Caterpie line
(10, 'kaefer'),
(11, 'kaefer'),
(12, 'kaefer'),
(12, 'flug'),

-- Weedle line
(13, 'kaefer'),
(13, 'gift'),
(14, 'kaefer'),
(14, 'gift'),
(15, 'kaefer'),
(15, 'gift'),

-- Pidgey line
(16, 'normal'),
(16, 'flug'),
(17, 'normal'),
(17, 'flug'),
(18, 'normal'),
(18, 'flug'),

-- Rattata line
(19, 'normal'),
(20, 'normal'),

-- Spearow line
(21, 'normal'),
(21, 'flug'),
(22, 'normal'),
(22, 'flug'),

-- Ekans line
(23, 'gift'),
(24, 'gift'),

-- Pikachu line
(25, 'elektro'),
(26, 'elektro'),

-- Sandshrew line
(27, 'boden'),
(28, 'boden'),

-- Nidoran♀
(29, 'gift'),
(30, 'gift'),
(31, 'gift'),
(31, 'boden'),

-- Nidoran♂ line
(32, 'gift'),
(33, 'gift'),
(34, 'gift'),
(34, 'boden'),

-- Clefairy line
(35, 'fee'),
(36, 'fee'),

-- Vulpix line
(37, 'feuer'),
(38, 'feuer'),

-- Jigglypuff line
(39, 'normal'),
(39, 'fee'),
(40, 'normal'),
(40, 'fee'),

-- Zubat line
(41, 'gift'),
(41, 'flug'),
(42, 'gift'),
(42, 'flug'),

-- Oddish line
(43, 'pflanze'),
(43, 'gift'),
(44, 'pflanze'),
(44, 'gift'),
(45, 'pflanze'),
(45, 'gift'),

-- Paras line
(46, 'kaefer'),
(46, 'pflanze'),
(47, 'kaefer'),
(47, 'pflanze'),

-- Venonat line
(48, 'kaefer'),
(48, 'gift'),
(49, 'kaefer'),
(49, 'gift'),

-- Diglett
(50, 'boden');



SELECT 
	FromPokemonId,
    ToPokemonId,
    pf.Name as PokemonFromName,
    pt.Name as PokemonToName
FROM pokedex.PokemonEvolution pe
JOIN pokemon pf on pe.FromPokemonId = pf.Id
JOIN pokemon pt on pe.ToPokemonId = pt.Id;

SELECT * From pokemon;
