-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 22, 2024 at 05:41 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `rent_connect`
--

-- --------------------------------------------------------

--
-- Table structure for table `additional_fees`
--

CREATE TABLE `additional_fees` (
                                   `fee_id` bigint(20) NOT NULL,
                                   `fee_name` varchar(100) NOT NULL,
                                   `description` longtext DEFAULT NULL,
                                   `amount` decimal(38,2) NOT NULL,
                                   `unit` varchar(50) NOT NULL,
                                   `created_at` datetime DEFAULT current_timestamp(),
                                   `updated_at` datetime DEFAULT NULL,
                                   `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `addresses`
--

CREATE TABLE `addresses` (
                             `address_id` bigint(20) NOT NULL,
                             `user_id` int(11) DEFAULT NULL,
                             `address_type` enum('home','company','other') NOT NULL,
                             `address_line` varchar(255) NOT NULL,
                             `province` varchar(100) NOT NULL,
                             `district` varchar(100) NOT NULL,
                             `ward` varchar(100) NOT NULL,
                             `specific_address` varchar(255) NOT NULL,
                             `address_label` varchar(100) DEFAULT NULL,
                             `is_default` tinyint(1) DEFAULT 0,
                             `created_at` datetime DEFAULT current_timestamp(),
                             `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `amenities`
--

CREATE TABLE `amenities` (
                             `amenity_id` int(11) NOT NULL,
                             `amenity_name` varchar(100) NOT NULL,
                             `icon` varchar(255) DEFAULT NULL,
                             `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `booking_history`
--

CREATE TABLE `booking_history` (
                                   `history_id` bigint(20) NOT NULL,
                                   `rental_id` int(11) DEFAULT NULL,
                                   `status` enum('requested','approved','rejected','completed','canceled') NOT NULL,
                                   `updated_at` datetime DEFAULT current_timestamp(),
                                   `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cars`
--

CREATE TABLE `cars` (
                        `car_id` int(11) NOT NULL,
                        `owner_id` int(11) DEFAULT NULL,
                        `car_name` varchar(100) NOT NULL,
                        `description` longtext DEFAULT NULL,
                        `price_per_day` decimal(38,2) NOT NULL,
                        `times_rented` int(11) DEFAULT 0,
                        `transmission_id` int(11) DEFAULT NULL,
                        `seats` int(11) DEFAULT NULL,
                        `fuel_id` int(11) DEFAULT NULL,
                        `range_per_charge_or_tank` varchar(50) DEFAULT NULL,
                        `location_id` int(11) DEFAULT NULL,
                        `created_at` datetime DEFAULT current_timestamp(),
                        `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `car_amenities`
--

CREATE TABLE `car_amenities` (
                                 `car_id` int(11) NOT NULL,
                                 `amenity_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `car_features`
--

CREATE TABLE `car_features` (
                                `feature_id` int(11) NOT NULL,
                                `feature_name` varchar(100) NOT NULL,
                                `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `car_feature_map`
--

CREATE TABLE `car_feature_map` (
                                   `car_id` int(11) NOT NULL,
                                   `feature_id` int(11) NOT NULL,
                                   `feature_value` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `car_images`
--

CREATE TABLE `car_images` (
                              `image_id` bigint(20) NOT NULL,
                              `car_id` int(11) DEFAULT NULL,
                              `image_url` varchar(255) NOT NULL,
                              `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `car_locations`
--

CREATE TABLE `car_locations` (
                                 `location_id` int(11) NOT NULL,
                                 `address_line` varchar(255) NOT NULL,
                                 `province` varchar(100) NOT NULL,
                                 `district` varchar(100) NOT NULL,
                                 `ward` varchar(100) NOT NULL,
                                 `latitude` decimal(38,2) DEFAULT NULL,
                                 `longitude` decimal(38,2) DEFAULT NULL,
                                 `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `conversations`
--

CREATE TABLE `conversations` (
                                 `conversation_id` bigint(20) NOT NULL,
                                 `created_at` datetime(6) NOT NULL,
                                 `deleted_at` datetime(6) DEFAULT NULL,
                                 `customer_id` bigint(20) NOT NULL,
                                 `owner_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fuels`
--

CREATE TABLE `fuels` (
                         `fuel_id` int(11) NOT NULL,
                         `fuel_type` varchar(50) NOT NULL,
                         `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `fuels`
--

INSERT INTO `fuels` (`fuel_id`, `fuel_type`, `deleted_at`) VALUES
                                                               (1, 'Gasoline', NULL),
                                                               (2, 'Diesel', NULL),
                                                               (3, 'CNG', NULL),
                                                               (4, 'LPG', NULL),
                                                               (5, 'Ethanol', NULL),
                                                               (6, 'Biodiesel', NULL),
                                                               (7, 'Electricity', NULL),
                                                               (8, 'Hydrogen', NULL),
                                                               (9, 'Synthetic Fuels', NULL),
                                                               (10, 'Methanol', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
                            `message_id` bigint(20) NOT NULL,
                            `deleted_at` datetime(6) DEFAULT NULL,
                            `message_text` varchar(255) NOT NULL,
                            `sent_at` datetime(6) NOT NULL,
                            `conversation_id` bigint(20) NOT NULL,
                            `sender_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `otp_verification`
--

CREATE TABLE `otp_verification` (
                                    `otp_id` bigint(20) NOT NULL,
                                    `user_id` int(11) DEFAULT NULL,
                                    `otp_code` varchar(100) NOT NULL,
                                    `expires_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `otp_verification`
--

INSERT INTO `otp_verification` (`otp_id`, `user_id`, `otp_code`, `expires_at`) VALUES
    (1, 5, 'rZupuCE/xDnXwp9b4FAzgg==', '2024-11-22 10:03:11');

-- --------------------------------------------------------

--
-- Table structure for table `rentals`
--

CREATE TABLE `rentals` (
                           `rental_id` int(11) NOT NULL,
                           `car_id` int(11) DEFAULT NULL,
                           `customer_id` int(11) DEFAULT NULL,
                           `owner_id` int(11) DEFAULT NULL,
                           `start_date` datetime NOT NULL,
                           `end_date` datetime NOT NULL,
                           `status` enum('requested','approved','rejected','completed','canceled') DEFAULT 'requested',
                           `created_at` datetime DEFAULT current_timestamp(),
                           `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
                           `review_id` bigint(20) NOT NULL,
                           `car_id` int(11) DEFAULT NULL,
                           `customer_id` int(11) DEFAULT NULL,
                           `rating` int(11) DEFAULT NULL CHECK (`rating` >= 1 and `rating` <= 5),
                           `review_text` longtext DEFAULT NULL,
                           `created_at` datetime DEFAULT current_timestamp(),
                           `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `terms`
--

CREATE TABLE `terms` (
                         `term_id` bigint(20) NOT NULL,
                         `term_text` tinytext NOT NULL,
                         `created_at` datetime DEFAULT current_timestamp(),
                         `updated_at` datetime DEFAULT NULL,
                         `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transmissions`
--

CREATE TABLE `transmissions` (
                                 `transmission_id` int(11) NOT NULL,
                                 `transmission_type` varchar(50) NOT NULL,
                                 `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transmissions`
--

INSERT INTO `transmissions` (`transmission_id`, `transmission_type`, `deleted_at`) VALUES
                                                                                       (1, ' Manual', NULL),
                                                                                       (2, 'Traditional Automatic', NULL),
                                                                                       (3, 'CVT', NULL),
                                                                                       (4, 'Dual-Clutch', NULL),
                                                                                       (5, 'Automated Manual', NULL),
                                                                                       (6, 'Semi-Automatic', NULL),
                                                                                       (7, 'Electric', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
                         `user_id` int(11) NOT NULL,
                         `full_name` varchar(100) NOT NULL,
                         `email` varchar(100) NOT NULL,
                         `password` varchar(255) DEFAULT NULL,
                         `phone_number` varchar(15) DEFAULT NULL,
                         `user_type` enum('customer','owner','admin') NOT NULL DEFAULT 'customer',
                         `created_at` datetime NOT NULL DEFAULT current_timestamp(),
                         `verified` tinyint(1) DEFAULT 0,
                         `login_platform` enum('email','google','facebook','other') NOT NULL DEFAULT 'facebook',
                         `platform_id` varchar(255) DEFAULT NULL,
                         `deleted_at` datetime DEFAULT NULL
) ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `full_name`, `email`, `password`, `phone_number`, `user_type`, `created_at`, `verified`, `login_platform`, `platform_id`, `deleted_at`) VALUES
    (5, 'Trần Võ Hoàng Huy', '21130386st.hcmuaf.edu.vn', '$2a$10$7Gj2zF.K9ziFGdckUIuaROWE2jgA8iJhhATrFZHF/YMFaR82qhhBq', '094694447', 'customer', '2024-11-22 09:46:08', 1, 'email', NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `additional_fees`
--
ALTER TABLE `additional_fees`
    ADD PRIMARY KEY (`fee_id`);

--
-- Indexes for table `addresses`
--
ALTER TABLE `addresses`
    ADD PRIMARY KEY (`address_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `amenities`
--
ALTER TABLE `amenities`
    ADD PRIMARY KEY (`amenity_id`);

--
-- Indexes for table `booking_history`
--
ALTER TABLE `booking_history`
    ADD PRIMARY KEY (`history_id`),
  ADD KEY `rental_id` (`rental_id`);

--
-- Indexes for table `cars`
--
ALTER TABLE `cars`
    ADD PRIMARY KEY (`car_id`),
  ADD KEY `owner_id` (`owner_id`),
  ADD KEY `transmission_id` (`transmission_id`),
  ADD KEY `fuel_id` (`fuel_id`),
  ADD KEY `location_id` (`location_id`);

--
-- Indexes for table `car_amenities`
--
ALTER TABLE `car_amenities`
    ADD PRIMARY KEY (`car_id`,`amenity_id`),
  ADD KEY `amenity_id` (`amenity_id`);

--
-- Indexes for table `car_features`
--
ALTER TABLE `car_features`
    ADD PRIMARY KEY (`feature_id`);

--
-- Indexes for table `car_feature_map`
--
ALTER TABLE `car_feature_map`
    ADD PRIMARY KEY (`car_id`,`feature_id`),
  ADD KEY `feature_id` (`feature_id`);

--
-- Indexes for table `car_images`
--
ALTER TABLE `car_images`
    ADD PRIMARY KEY (`image_id`),
  ADD KEY `car_id` (`car_id`);

--
-- Indexes for table `car_locations`
--
ALTER TABLE `car_locations`
    ADD PRIMARY KEY (`location_id`);

--
-- Indexes for table `conversations`
--
ALTER TABLE `conversations`
    ADD PRIMARY KEY (`conversation_id`);

--
-- Indexes for table `fuels`
--
ALTER TABLE `fuels`
    ADD PRIMARY KEY (`fuel_id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
    ADD PRIMARY KEY (`message_id`),
  ADD KEY `FKt492th6wsovh1nush5yl5jj8e` (`conversation_id`);

--
-- Indexes for table `otp_verification`
--
ALTER TABLE `otp_verification`
    ADD PRIMARY KEY (`otp_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `rentals`
--
ALTER TABLE `rentals`
    ADD PRIMARY KEY (`rental_id`),
  ADD KEY `car_id` (`car_id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `owner_id` (`owner_id`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
    ADD PRIMARY KEY (`review_id`),
  ADD KEY `car_id` (`car_id`),
  ADD KEY `customer_id` (`customer_id`);

--
-- Indexes for table `terms`
--
ALTER TABLE `terms`
    ADD PRIMARY KEY (`term_id`);

--
-- Indexes for table `transmissions`
--
ALTER TABLE `transmissions`
    ADD PRIMARY KEY (`transmission_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
    ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `additional_fees`
--
ALTER TABLE `additional_fees`
    MODIFY `fee_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `addresses`
--
ALTER TABLE `addresses`
    MODIFY `address_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `amenities`
--
ALTER TABLE `amenities`
    MODIFY `amenity_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `booking_history`
--
ALTER TABLE `booking_history`
    MODIFY `history_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cars`
--
ALTER TABLE `cars`
    MODIFY `car_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `car_features`
--
ALTER TABLE `car_features`
    MODIFY `feature_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `car_images`
--
ALTER TABLE `car_images`
    MODIFY `image_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `car_locations`
--
ALTER TABLE `car_locations`
    MODIFY `location_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `conversations`
--
ALTER TABLE `conversations`
    MODIFY `conversation_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fuels`
--
ALTER TABLE `fuels`
    MODIFY `fuel_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
    MODIFY `message_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `otp_verification`
--
ALTER TABLE `otp_verification`
    MODIFY `otp_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `rentals`
--
ALTER TABLE `rentals`
    MODIFY `rental_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
    MODIFY `review_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `terms`
--
ALTER TABLE `terms`
    MODIFY `term_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transmissions`
--
ALTER TABLE `transmissions`
    MODIFY `transmission_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
    MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `addresses`
--
ALTER TABLE `addresses`
    ADD CONSTRAINT `addresses_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `booking_history`
--
ALTER TABLE `booking_history`
    ADD CONSTRAINT `booking_history_ibfk_1` FOREIGN KEY (`rental_id`) REFERENCES `rentals` (`rental_id`) ON DELETE CASCADE;

--
-- Constraints for table `cars`
--
ALTER TABLE `cars`
    ADD CONSTRAINT `cars_ibfk_1` FOREIGN KEY (`owner_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cars_ibfk_2` FOREIGN KEY (`transmission_id`) REFERENCES `transmissions` (`transmission_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `cars_ibfk_3` FOREIGN KEY (`fuel_id`) REFERENCES `fuels` (`fuel_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `cars_ibfk_4` FOREIGN KEY (`location_id`) REFERENCES `car_locations` (`location_id`) ON DELETE SET NULL;

--
-- Constraints for table `car_amenities`
--
ALTER TABLE `car_amenities`
    ADD CONSTRAINT `car_amenities_ibfk_1` FOREIGN KEY (`car_id`) REFERENCES `cars` (`car_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `car_amenities_ibfk_2` FOREIGN KEY (`amenity_id`) REFERENCES `amenities` (`amenity_id`) ON DELETE CASCADE;

--
-- Constraints for table `car_feature_map`
--
ALTER TABLE `car_feature_map`
    ADD CONSTRAINT `car_feature_map_ibfk_1` FOREIGN KEY (`car_id`) REFERENCES `cars` (`car_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `car_feature_map_ibfk_2` FOREIGN KEY (`feature_id`) REFERENCES `car_features` (`feature_id`) ON DELETE CASCADE;

--
-- Constraints for table `car_images`
--
ALTER TABLE `car_images`
    ADD CONSTRAINT `car_images_ibfk_1` FOREIGN KEY (`car_id`) REFERENCES `cars` (`car_id`) ON DELETE CASCADE;

--
-- Constraints for table `messages`
--
ALTER TABLE `messages`
    ADD CONSTRAINT `FKt492th6wsovh1nush5yl5jj8e` FOREIGN KEY (`conversation_id`) REFERENCES `conversations` (`conversation_id`);

--
-- Constraints for table `otp_verification`
--
ALTER TABLE `otp_verification`
    ADD CONSTRAINT `otp_verification_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `rentals`
--
ALTER TABLE `rentals`
    ADD CONSTRAINT `rentals_ibfk_1` FOREIGN KEY (`car_id`) REFERENCES `cars` (`car_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `rentals_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `rentals_ibfk_3` FOREIGN KEY (`owner_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
    ADD CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`car_id`) REFERENCES `cars` (`car_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
