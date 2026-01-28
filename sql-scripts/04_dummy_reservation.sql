use kino;
-- create reservation dummy

-- Reservierungen für die neuen 2026 Filme
INSERT INTO `reservation` (`id`, `reservationDate`, `ACCOUNT_ID`, `PRESENTATION_ID`)
VALUES 
-- Emilia Clarke bucht Dune: Teil Zwei
('1', '2026-02-10 14:20:15', '3', '1'),
-- Alicia Vikander bucht Oppenheimer
('2', '2026-02-11 09:45:30', '4', '3'),
-- Emilia Clarke bucht Barbie für Familie
('3', '2026-02-12 16:10:45', '3', '4'),
-- Alicia Vikander bucht Avatar: The Way of Water
('4', '2026-02-13 19:30:20', '4', '9'),
-- Emilia Clarke bucht John Wick: Kapitel 4
('5', '2026-02-14 11:15:55', '3', '7'),
-- Alicia Vikander bucht Spider-Man für Nachmittagsvorstellung
('6', '2026-02-20 13:25:10', '4', '23'),
-- Emilia Clarke bucht Top Gun: Maverick
('7', '2026-02-17 08:30:45', '3', '10'),
-- Alicia Vikander bucht Fast & Furious 10
('8', '2026-02-18 15:55:20', '4', '11'),
-- Emilia Clarke bucht Guardians of the Galaxy Vol. 3 am Wochenende
('9', '2026-02-19 20:10:30', '3', '15'),
-- Alicia Vikander bucht Barbie Matinee
('10', '2026-02-25 12:40:15', '4', '22');

-- Sitzplätze für Reservierungen
INSERT INTO `reservation_seat` (`RESERVATION_ID`, `SEAT_ID`)
VALUES 
-- Reservation 1: Emilia bucht 2 Sitze für Dune (Europasaal)
('1', '35'), ('1', '36'), 
-- Reservation 2: Alicia bucht 1 Sitz für Oppenheimer (Saal 2)
('2', '11'), 
-- Reservation 3: Emilia bucht 3 Sitze für Barbie Familie (Saal 3)
('3', '25'), ('3', '26'), ('3', '27'),
-- Reservation 4: Alicia bucht 2 Sitze für Avatar (Saal 2)
('4', '12'), ('4', '13'),
-- Reservation 5: Emilia bucht 1 Sitz für John Wick (Europasaal)
('5', '37'),
-- Reservation 6: Alicia bucht 2 Sitze für Spider-Man (Saal 3)
('6', '28'), ('6', '29'),
-- Reservation 7: Emilia bucht 1 Sitz für Top Gun (Saal 2)
('7', '14'),
-- Reservation 8: Alicia bucht 2 Sitze für Fast & Furious (Saal 3)
('8', '30'), ('8', '31'),
-- Reservation 9: Emilia bucht 3 Sitze für Guardians am Wochenende (Saal 3)
('9', '32'), ('9', '33'), ('9', '34'),
-- Reservation 10: Alicia bucht 1 Sitz für Barbie Matinee (Saal 2)
('10', '15');

