-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Loomise aeg: Veebr 26, 2026 kell 09:55 EL
-- Serveri versioon: 10.4.32-MariaDB
-- PHP versioon: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Andmebaas: `praktiline`
--

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `category`
--

CREATE TABLE `category` (
  `idCategory` int(11) NOT NULL,
  `CategotyName` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `customer`
--

CREATE TABLE `customer` (
  `idCustomer` int(11) NOT NULL,
  `name_` varchar(30) DEFAULT NULL,
  `contact` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `product_`
--

CREATE TABLE `product_` (
  `idProduct` int(11) NOT NULL,
  `ProductName` varchar(30) NOT NULL,
  `idCategory` int(11) DEFAULT NULL,
  `price` decimal(7,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `sale`
--

CREATE TABLE `sale` (
  `idSale` int(11) NOT NULL,
  `idProduct` int(11) DEFAULT NULL,
  `idCustomer` int(11) NOT NULL,
  `Count_` int(11) DEFAULT NULL,
  `DateOfSale` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Indeksid tõmmistatud tabelitele
--

--
-- Indeksid tabelile `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`idCategory`),
  ADD UNIQUE KEY `CategotyName` (`CategotyName`);

--
-- Indeksid tabelile `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`idCustomer`),
  ADD UNIQUE KEY `contact` (`contact`);

--
-- Indeksid tabelile `product_`
--
ALTER TABLE `product_`
  ADD PRIMARY KEY (`idProduct`),
  ADD UNIQUE KEY `ProductName` (`ProductName`),
  ADD KEY `idCategory` (`idCategory`);

--
-- Indeksid tabelile `sale`
--
ALTER TABLE `sale`
  ADD PRIMARY KEY (`idSale`),
  ADD UNIQUE KEY `idCustomer` (`idCustomer`),
  ADD KEY `idProduct` (`idProduct`);

--
-- AUTO_INCREMENT tõmmistatud tabelitele
--

--
-- AUTO_INCREMENT tabelile `category`
--
ALTER TABLE `category`
  MODIFY `idCategory` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT tabelile `customer`
--
ALTER TABLE `customer`
  MODIFY `idCustomer` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT tabelile `product_`
--
ALTER TABLE `product_`
  MODIFY `idProduct` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT tabelile `sale`
--
ALTER TABLE `sale`
  MODIFY `idSale` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tõmmistatud tabelite piirangud
--

--
-- Piirangud tabelile `product_`
--
ALTER TABLE `product_`
  ADD CONSTRAINT `product__ibfk_1` FOREIGN KEY (`idCategory`) REFERENCES `category` (`idCategory`);

--
-- Piirangud tabelile `sale`
--
ALTER TABLE `sale`
  ADD CONSTRAINT `sale_ibfk_1` FOREIGN KEY (`idProduct`) REFERENCES `product_` (`idProduct`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
