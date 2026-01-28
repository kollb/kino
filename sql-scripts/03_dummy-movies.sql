USE kino;
-- PRICECATEGORY
INSERT INTO `PriceCategory` (`id`, `name`, `reducedPrice`, `regularPrice`)
VALUES ('1', '2D', '7.5', '8.5'),
       ('2', '3D', '9.5', '11'),
       ('3', '2D Überlänge', '9', '10'),
       ('4', '3D Überlänge', '11', '12.5');

-- CINEMAHALL
INSERT INTO `CinemaHall` (`id`, `name`)
VALUES ('1', 'Luxemburg-Saal'),
       ('2', 'Saal 2'),
       ('3', 'Saal 3'),
       ('4', 'Europasaal');

-- SEAT
-- Sitze für Luxemburg
INSERT INTO `Seat` (`id`, `row`, `seatNumber`, `CINEMAHALL_ID`)
VALUES ('1', 'A', '1', '1'),
       ('2', 'A', '2', '1'),
       ('3', 'B', '1', '1'),
       ('4', 'B', '2', '1');

-- Sitze für Saal 2
INSERT INTO `Seat` (`id`, `row`, `seatNumber`, `CINEMAHALL_ID`)
VALUES ('5', 'A', '1', '2'),
       ('6', 'A', '2', '2'),
       ('7', 'A', '3', '2'),
       ('8', 'A', '4', '2'),
       ('9', 'A', '5', '2'),
       ('10', 'A', '6', '2'),
       ('11', 'B', '1', '2'),
       ('12', 'B', '2', '2'),
       ('13', 'B', '3', '2'),
       ('14', 'B', '4', '2'),
       ('15', 'B', '5', '2'),
       ('16', 'B', '6', '2'),
       ('17', 'C', '1', '2'),
       ('18', 'C', '2', '2'),
       ('19', 'C', '3', '2'),
       ('20', 'C', '4', '2'),
       ('21', 'C', '5', '2'),
       ('22', 'C', '6', '2');

-- Sitze für Saal 3
INSERT INTO `Seat` (`id`, `row`, `seatNumber`, `CINEMAHALL_ID`)
VALUES ('23', 'A', '1', '3'),
       ('24', 'A', '2', '3'),
       ('25', 'A', '3', '3'),
       ('26', 'A', '4', '3'),
       ('27', 'B', '1', '3'),
       ('28', 'B', '2', '3'),
       ('29', 'B', '3', '3'),
       ('30', 'B', '4', '3'),
       ('31', 'C', '1', '3'),
       ('32', 'C', '2', '3'),
       ('33', 'C', '3', '3'),
       ('34', 'C', '4', '3');

-- Sitze für Europasaal
INSERT INTO `Seat` (`id`, `row`, `seatNumber`, `CINEMAHALL_ID`)
VALUES ('35', 'A', '1', '4'),
       ('36', 'A', '2', '4'),
       ('37', 'A', '3', '4'),
       ('38', 'B', '1', '4'),
       ('39', 'B', '2', '4'),
       ('40', 'B', '3', '4'),
       ('41', 'C', '1', '4'),
       ('42', 'C', '2', '4'),
       ('43', 'C', '3', '4');

-- MOVIE
INSERT INTO `Movie` (`id`, `ageRating`, `duration`, `name`, `imageURL`, `PRICECATEGORY_ID`)
VALUES
-- Dune: Part Two, FSK 12
('1', '12', '2.75', 'Dune: Teil Zwei',
 'https://image.tmdb.org/t/p/w500/1pdfLvkbY9ohJlCjQH2CZjjYVvJ.jpg',
 '3'),
-- Oppenheimer, FSK 12
('2', '12', '3.0', 'Oppenheimer',
 'https://image.tmdb.org/t/p/w500/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg',
 '4'),
-- Barbie, FSK 6
('3', '6', '1.95', 'Barbie',
 'https://image.tmdb.org/t/p/w500/iuFNMS8U5cb6xfzi51Dbkovj7vM.jpg',
 '1'),
-- Guardians of the Galaxy Vol. 3, FSK 12
('4', '12', '2.5', 'Guardians of the Galaxy Vol. 3',
 'https://image.tmdb.org/t/p/w500/r2J02Z2OpNTctfOSN1Ydgii51I3.jpg',
 '2'),
-- Spider-Man: Across the Spider-Verse, FSK 6
('5', '6', '2.25', 'Spider-Man: Across the Spider-Verse',
 'https://image.tmdb.org/t/p/w500/8Vt6mWEReuy4Of61Lnj5Xj704m8.jpg',
 '2'),
-- John Wick: Chapter 4, FSK 16
('6', '16', '2.75', 'John Wick: Kapitel 4',
 'https://image.tmdb.org/t/p/w500/vZloFAK7NmvMGKE7VkF5UHaz0I.jpg',
 '1'),
-- Indiana Jones 5, FSK 12
('7', '12', '2.5', 'Indiana Jones und das Rad des Schicksals',
 'https://image.tmdb.org/t/p/w500/Af4bXE63pVsb2FtbW8uYIyPBadD.jpg',
 '3'),
-- Avatar: The Way of Water, FSK 12
('8', '12', '3.2', 'Avatar: The Way of Water',
 'https://image.tmdb.org/t/p/w500/t6HIqrRAclMCA60NsSmeqe9RmNV.jpg',
 '4'),
-- Top Gun: Maverick, FSK 12
('9', '12', '2.2', 'Top Gun: Maverick',
 'https://image.tmdb.org/t/p/w500/62HCnUTziyWcpDaBO2i1DX17ljH.jpg',
 '3'),
-- Fast X, FSK 12
('10', '12', '2.25', 'Fast & Furious 10',
 'https://image.tmdb.org/t/p/w500/fiVW06jE7z9YnO4trhaMEdclSiC.jpg',
 '2');

-- PRESENTATION
INSERT INTO `Presentation` (`id`, `date`, `CINEMAHALL_ID`, `MOVIE_ID`)
VALUES ('1', '2026-02-15 16:00:00', '4', '1'),  -- Dune: Teil Zwei, Europasaal
       ('2', '2026-02-15 19:30:00', '1', '1'),  -- Dune: Teil Zwei, Luxemburg-Saal
       ('3', '2026-02-16 20:00:00', '2', '2'),  -- Oppenheimer, Saal 2
       ('4', '2026-02-16 16:30:00', '3', '3'),  -- Barbie, Saal 3
       ('5', '2026-02-17 18:00:00', '1', '4'),  -- Guardians of the Galaxy Vol. 3, Luxemburg-Saal
       ('6', '2026-02-17 20:30:00', '2', '5'),  -- Spider-Man: Across the Spider-Verse, Saal 2
       ('7', '2026-02-18 21:00:00', '4', '6'),  -- John Wick: Kapitel 4, Europasaal
       ('8', '2026-02-18 17:00:00', '3', '7'),  -- Indiana Jones 5, Saal 3
       ('9', '2026-02-19 19:00:00', '1', '8'),  -- Avatar: The Way of Water, Luxemburg-Saal
       ('10', '2026-02-19 21:30:00', '2', '9'), -- Top Gun: Maverick, Saal 2
       ('11', '2026-02-20 16:00:00', '3', '10'), -- Fast & Furious 10, Saal 3
       ('12', '2026-02-20 18:30:00', '4', '1'), -- Dune: Teil Zwei, Europasaal
       ('13', '2026-02-21 20:00:00', '1', '2'), -- Oppenheimer, Luxemburg-Saal
       ('14', '2026-02-21 17:30:00', '2', '3'), -- Barbie, Saal 2
       ('15', '2026-02-22 19:15:00', '3', '4'), -- Guardians of the Galaxy Vol. 3, Saal 3
       ('16', '2026-02-22 21:45:00', '4', '5'), -- Spider-Man: Across the Spider-Verse, Europasaal
       ('17', '2026-02-23 18:00:00', '1', '6'), -- John Wick: Kapitel 4, Luxemburg-Saal
       ('18', '2026-02-23 20:15:00', '2', '7'), -- Indiana Jones 5, Saal 2
       ('19', '2026-02-24 16:30:00', '3', '8'), -- Avatar: The Way of Water, Saal 3
       ('20', '2026-02-24 19:00:00', '4', '9'), -- Top Gun: Maverick, Europasaal
       ('21', '2026-02-25 21:00:00', '1', '10'), -- Fast & Furious 10, Luxemburg-Saal
       ('22', '2026-02-26 14:30:00', '2', '3'), -- Barbie (Matinee), Saal 2
       ('23', '2026-02-26 17:00:00', '3', '5'), -- Spider-Man (Nachmittagsvorstellung), Saal 3
       ('24', '2026-02-27 20:30:00', '4', '2'), -- Oppenheimer, Europasaal
       ('25', '2026-02-28 18:45:00', '1', '8'); -- Avatar: The Way of Water, Luxemburg-Saal
