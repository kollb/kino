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
    duration    INTEGER,
    fsk         INTEGER,
    imageUrl    VARCHAR(255),
    name        VARCHAR(255),
    releaseYear INTEGER,
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
    is3d          BIT,
    presentedAt   DATETIME(6),
    cinemaHallId  BIGINT,
    movieId       BIGINT,
    priceCategoryId BIGINT,
    PRIMARY KEY (id),
    FOREIGN KEY (cinemaHallId) REFERENCES CinemaHall (id),
    FOREIGN KEY (movieId) REFERENCES Movie (id),
    FOREIGN KEY (priceCategoryId) REFERENCES PriceCategory (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- Create Seat table
CREATE TABLE Seat
(
    id            BIGINT       NOT NULL AUTO_INCREMENT,
    number        INTEGER,
    row           VARCHAR(255),
    cinemaHallId  BIGINT,
    PRIMARY KEY (id),
    FOREIGN KEY (cinemaHallId) REFERENCES CinemaHall (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- Create Reservation table
CREATE TABLE Reservation
(
    id             BIGINT NOT NULL AUTO_INCREMENT,
    accountId      BIGINT,
    presentationId BIGINT,
    seatId         BIGINT,
    PRIMARY KEY (id),
    FOREIGN KEY (accountId) REFERENCES Account (id),
    FOREIGN KEY (presentationId) REFERENCES Presentation (id),
    FOREIGN KEY (seatId) REFERENCES Seat (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- Insert default accounts (passwords are hashed)
-- admin@account.de / admin
-- moderator@account.de / moderator
-- customer@account.de / customer
-- customer1@account.de / customer1
INSERT INTO Account (id, birthday, email, firstName, hashedPassword, lastName, role, salt)
VALUES (1, '2019-05-09', 'admin@account.de', 'Admin',
        '64f73e3451c5def78775e060f68e2c94b4d53b1d2c5375917042cf8b08ca0dc77b7459e557b6ed7ef83fd4cb4f30697968aaa3008e70505507707eecbb468b5e',
        'Account', '0', 0x4d533cd6317305b3ecb4cd06afe26376),
       (2, '2019-05-09', 'moderator@account.de', 'Moderator',
        '8e89d4f48e9a81f7a6d6a687c3b93f1cf9e58e323f9a0ba82beab4766245cc37c800ab16136f62f722e98859903643ae5c74189c961ba73d456d13da482efbb9',
        'Account', '1', 0x4dbd312e02b619ac8a57cd596352bdef),
       (3, '2019-05-09', 'customer@account.de', 'Emilia',
        '7cc0e2f8aeefc0f2c07e86ebbf40beab7dca4128a8f9b46051608974cd522c50e78dfcb321b9204a30a0a88ae7deaec53455d6a8d7850db1755529027a3f26b9',
        'Clarke', '2', 0x91f1cdcc46daacf42cc5639d0c56d026),
       (4, '2019-05-09', 'customer1@account.de', 'Alicia',
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
INSERT INTO Seat (number, row, cinemaHallId)
VALUES (1, 'A', 1),
       (2, 'A', 1),
       (3, 'A', 1),
       (4, 'A', 1),
       (5, 'A', 1),
       (1, 'B', 1),
       (2, 'B', 1),
       (3, 'B', 1),
       (4, 'B', 1),
       (5, 'B', 1),
       (1, 'C', 1),
       (2, 'C', 1),
       (3, 'C', 1),
       (4, 'C', 1),
       (5, 'C', 1);

-- Insert seats for cinema hall 2
INSERT INTO Seat (number, row, cinemaHallId)
VALUES (1, 'A', 2),
       (2, 'A', 2),
       (3, 'A', 2),
       (4, 'A', 2),
       (1, 'B', 2),
       (2, 'B', 2),
       (3, 'B', 2),
       (4, 'B', 2);

-- Insert seats for cinema hall 3
INSERT INTO Seat (number, row, cinemaHallId)
VALUES (1, 'A', 3),
       (2, 'A', 3),
       (3, 'A', 3),
       (4, 'A', 3),
       (5, 'A', 3),
       (6, 'A', 3),
       (1, 'B', 3),
       (2, 'B', 3),
       (3, 'B', 3),
       (4, 'B', 3),
       (5, 'B', 3),
       (6, 'B', 3);

-- Insert sample movies
INSERT INTO Movie (id, name, director, description, duration, fsk, releaseYear, imageUrl)
VALUES (1, 'The Shawshank Redemption', 'Frank Darabont',
        'Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.',
        142, 12, 1994, 'https://m.media-amazon.com/images/M/MV5BMDFkYTc0MGEtZmNhMC00ZDIzLWFmNTEtODM1ZmRlYWMwMWFmXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_SX300.jpg'),
       (2, 'The Godfather', 'Francis Ford Coppola',
        'The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.',
        175, 16, 1972, 'https://m.media-amazon.com/images/M/MV5BM2MyNjYxNmUtYTAwNi00MTYxLWJmNWYtYzZlODY3ZTk3OTFlXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_SX300.jpg'),
       (3, 'The Dark Knight', 'Christopher Nolan',
        'When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.',
        152, 12, 2008, 'https://m.media-amazon.com/images/M/MV5BMTMxNTMwODM0NF5BMl5BanBnXkFtZTcwODAyMTk2Mw@@._V1_SX300.jpg'),
       (4, 'Pulp Fiction', 'Quentin Tarantino',
        'The lives of two mob hitmen, a boxer, a gangster and his wife intertwine in four tales of violence and redemption.',
        154, 16, 1994, 'https://m.media-amazon.com/images/M/MV5BNGNhMDIzZTUtNTBlZi00MTRlLWFjM2ItYzViMjE3YzI5MjljXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_SX300.jpg'),
       (5, 'Forrest Gump', 'Robert Zemeckis',
        'The presidencies of Kennedy and Johnson, the Vietnam War, and other historical events unfold from the perspective of an Alabama man with an IQ of 75.',
        142, 6, 1994, 'https://m.media-amazon.com/images/M/MV5BNWIwODRlZTUtY2U3ZS00Yzg1LWJhNzYtMmZiYmEyNmU1NjMzXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg');

-- Insert sample presentations (upcoming shows)
INSERT INTO Presentation (id, presentedAt, is3d, movieId, cinemaHallId, priceCategoryId)
VALUES (1, DATE_ADD(NOW(), INTERVAL 2 DAY), 0, 1, 1, 1),
       (2, DATE_ADD(NOW(), INTERVAL 3 DAY), 1, 2, 2, 1),
       (3, DATE_ADD(NOW(), INTERVAL 4 DAY), 1, 3, 3, 1),
       (4, DATE_ADD(NOW(), INTERVAL 5 DAY), 0, 4, 1, 2),
       (5, DATE_ADD(NOW(), INTERVAL 6 DAY), 0, 5, 2, 2);

-- Insert a sample reservation
INSERT INTO Reservation (accountId, presentationId, seatId)
VALUES (3, 1, 1);
