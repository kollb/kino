-- Docker initialization script for Kino database
-- This script is automatically executed when MySQL container starts

USE kino;

-- Drop tables if they exist
DROP TABLE IF EXISTS Reservation;
DROP TABLE IF EXISTS Seat;
DROP TABLE IF EXISTS Presentation;
DROP TABLE IF EXISTS PriceCategory;
DROP TABLE IF EXISTS Movie;
DROP TABLE IF EXISTS CinemaHall;
DROP TABLE IF EXISTS Account;

-- Create Account table
CREATE TABLE Account
(
    id             BIGINT       NOT NULL AUTO_INCREMENT,
    birthday       DATE,
    email          VARCHAR(255),
    firstName      VARCHAR(255),
    hashedPassword VARCHAR(255),
    lastName       VARCHAR(255),
    role           VARCHAR(255),
    salt           TINYBLOB,
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- Create CinemaHall table
CREATE TABLE CinemaHall
(
    id   BIGINT       NOT NULL AUTO_INCREMENT,
    name VARCHAR(255),
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- Create Movie table
CREATE TABLE Movie
(
    id          BIGINT       NOT NULL AUTO_INCREMENT,
    description VARCHAR(511),
    director    VARCHAR(255),
    duration    DOUBLE,
    ageRating   VARCHAR(255),
    imageURL    VARCHAR(255),
    name        VARCHAR(255),
    releaseYear INTEGER,
    PRICECATEGORY_ID BIGINT,
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- Create PriceCategory table
CREATE TABLE PriceCategory
(
    id          BIGINT         NOT NULL AUTO_INCREMENT,
    name        VARCHAR(255),
    priceInCent DECIMAL(19, 2),
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- Create Presentation table
CREATE TABLE Presentation
(
    id            BIGINT  NOT NULL AUTO_INCREMENT,
    date          DATETIME,
    CINEMAHALL_ID BIGINT,
    MOVIE_ID      BIGINT,
    PRIMARY KEY (id),
    FOREIGN KEY (CINEMAHALL_ID) REFERENCES CinemaHall (id),
    FOREIGN KEY (MOVIE_ID) REFERENCES Movie (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- Create Seat table
CREATE TABLE Seat
(
    id            BIGINT       NOT NULL AUTO_INCREMENT,
    seatNumber    VARCHAR(255),
    `row`         VARCHAR(255),
    CINEMAHALL_ID BIGINT,
    PRIMARY KEY (id),
    FOREIGN KEY (CINEMAHALL_ID) REFERENCES CinemaHall (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- Create Reservation table
CREATE TABLE Reservation
(
    id             BIGINT NOT NULL AUTO_INCREMENT,
    reservationDate DATETIME,
    ACCOUNT_ID     BIGINT,
    PRESENTATION_ID BIGINT,
    PRIMARY KEY (id),
    FOREIGN KEY (ACCOUNT_ID) REFERENCES Account (id),
    FOREIGN KEY (PRESENTATION_ID) REFERENCES Presentation (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- Create ReservationSeat junction table
CREATE TABLE reservation_seat
(
    RESERVATION_ID BIGINT,
    SEAT_ID        BIGINT,
    FOREIGN KEY (RESERVATION_ID) REFERENCES Reservation (id),
    FOREIGN KEY (SEAT_ID) REFERENCES Seat (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- Insert default accounts (passwords are hashed)
-- admin@account.de / admin
-- moderator@account.de / moderator
-- customer@account.de / customer
-- customer1@account.de / customer1
INSERT INTO Account (id, birthday, email, firstName, hashedPassword, lastName, role, salt)
VALUES (1, '1985-03-15', 'admin@account.de', 'Admin',
        '64f73e3451c5def78775e060f68e2c94b4d53b1d2c5375917042cf8b08ca0dc77b7459e557b6ed7ef83fd4cb4f30697968aaa3008e70505507707eecbb468b5e',
        'Account', '0', 0x4d533cd6317305b3ecb4cd06afe26376),
       (2, '1990-08-22', 'moderator@account.de', 'Moderator',
        '8e89d4f48e9a81f7a6d6a687c3b93f1cf9e58e323f9a0ba82beab4766245cc37c800ab16136f62f722e98859903643ae5c74189c961ba73d456d13da482efbb9',
        'Account', '1', 0x4dbd312e02b619ac8a57cd596352bdef),
       (3, '1993-11-07', 'customer@account.de', 'Emilia',
        '7cc0e2f8aeefc0f2c07e86ebbf40beab7dca4128a8f9b46051608974cd522c50e78dfcb321b9204a30a0a88ae7deaec53455d6a8d7850db1755529027a3f26b9',
        'Clarke', '2', 0x91f1cdcc46daacf42cc5639d0c56d026),
       (4, '1988-12-03', 'customer1@account.de', 'Alicia',
        'c61dffc876d3b92499b7fcbf19e183bb85eb0a5ed980674defd10d4670cd15b77242b69011bd71c1167d85741dfd9230bfd555bfbec7d0a4875bd3571865f6c4',
        'Vikander', '2', 0x2a870ff77542121091862f8801497bd8);

-- Insert price categories
INSERT INTO PriceCategory (id, name, priceInCent)
VALUES (1, 'Erwachsener', 9.50),
       (2, 'Kind', 7.50),
       (3, 'Student', 8.00);

-- Insert cinema halls
INSERT INTO CinemaHall (id, name)
VALUES (1, 'Saal 1'),
       (2, 'Saal 2'),
       (3, 'Saal 3');

-- Insert seats for cinema hall 1
INSERT INTO Seat (id, seatNumber, `row`, CINEMAHALL_ID)
VALUES (1, '1', 'A', 1),
       (2, '2', 'A', 1),
       (3, '3', 'A', 1),
       (4, '4', 'A', 1),
       (5, '5', 'A', 1),
       (6, '1', 'B', 1),
       (7, '2', 'B', 1),
       (8, '3', 'B', 1),
       (9, '4', 'B', 1),
       (10, '5', 'B', 1),
       (11, '1', 'C', 1),
       (12, '2', 'C', 1),
       (13, '3', 'C', 1),
       (14, '4', 'C', 1),
       (15, '5', 'C', 1);

-- Insert seats for cinema hall 2
INSERT INTO Seat (id, seatNumber, `row`, CINEMAHALL_ID)
VALUES (16, '1', 'A', 2),
       (17, '2', 'A', 2),
       (18, '3', 'A', 2),
       (19, '4', 'A', 2),
       (20, '1', 'B', 2),
       (21, '2', 'B', 2),
       (22, '3', 'B', 2),
       (23, '4', 'B', 2);

-- Insert seats for cinema hall 3
INSERT INTO Seat (id, seatNumber, `row`, CINEMAHALL_ID)
VALUES (24, '1', 'A', 3),
       (25, '2', 'A', 3),
       (26, '3', 'A', 3),
       (27, '4', 'A', 3),
       (28, '5', 'A', 3),
       (29, '6', 'A', 3),
       (30, '1', 'B', 3),
       (31, '2', 'B', 3),
       (32, '3', 'B', 3),
       (33, '4', 'B', 3),
       (34, '5', 'B', 3),
       (35, '6', 'B', 3);

-- Insert sample movies (2026 blockbusters)
INSERT INTO Movie (id, name, director, description, duration, ageRating, releaseYear, imageURL, PRICECATEGORY_ID)
VALUES (1, 'Dune: Teil Zwei', 'Denis Villeneuve',
        'Paul Atreides vereint sich mit Chani und den Fremen, während er sich auf einem Rachefeldzug gegen die Verschwörer befindet, die seine Familie zerstört haben.',
        2.75, '12', 2024, 'https://image.tmdb.org/t/p/w500/1pdfLvkbY9ohJlCjQH2CZjjYVvJ.jpg', 3),
       (2, 'Oppenheimer', 'Christopher Nolan',
        'Die Geschichte von J. Robert Oppenheimer und seiner Rolle bei der Entwicklung der Atombombe während des Manhattan-Projekts.',
        3.0, '12', 2023, 'https://image.tmdb.org/t/p/w500/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg', 1),
       (3, 'Barbie', 'Greta Gerwig',
        'Eine lebensgroße Barbie wird aus ihrer perfekten Puppenwelt in die echte Welt geschleudert und entdeckt, dass Perfektion nur von innen kommen kann.',
        1.95, '6', 2023, 'https://image.tmdb.org/t/p/w500/iuFNMS8U5cb6xfzi51Dbkovj7vM.jpg', 2),
       (4, 'Top Gun: Maverick', 'Joseph Kosinski',
        'Nach mehr als 30 Jahren als einer der besten Kampfpiloten der Navy führt Pete "Maverick" Mitchell eine Gruppe von Top Gun-Absolventen für eine Mission an.',
        2.2, '12', 2022, 'https://image.tmdb.org/t/p/w500/62HCnUTziyWcpDaBO2i1DX17ljH.jpg', 3),
       (5, 'Avatar: The Way of Water', 'James Cameron',
        'Jake Sully und seine Familie kämpfen ums Überleben, erkunden die Regionen von Pandora und suchen Zuflucht beim Metkayina-Clan.',
        3.2, '12', 2022, 'https://image.tmdb.org/t/p/w500/t6HIqrRAclMCA60NsSmeqe9RmNV.jpg', 1);

-- Insert sample presentations (upcoming shows in February 2026)
INSERT INTO Presentation (id, date, CINEMAHALL_ID, MOVIE_ID)
VALUES (1, '2026-02-01 19:30:00', 1, 1), -- Dune: Teil Zwei, Saal 1
       (2, '2026-02-02 21:00:00', 2, 2), -- Oppenheimer, Saal 2
       (3, '2026-02-03 16:00:00', 3, 3), -- Barbie, Saal 3
       (4, '2026-02-04 20:15:00', 1, 4), -- Top Gun: Maverick, Saal 1
       (5, '2026-02-05 18:45:00', 2, 5); -- Avatar: The Way of Water, Saal 2

-- Insert a sample reservation
INSERT INTO Reservation (id, reservationDate, ACCOUNT_ID, PRESENTATION_ID)
VALUES (1, '2026-01-25 14:30:00', 3, 1);

INSERT INTO reservation_seat (RESERVATION_ID, SEAT_ID)
VALUES (1, 1), (1, 2);
