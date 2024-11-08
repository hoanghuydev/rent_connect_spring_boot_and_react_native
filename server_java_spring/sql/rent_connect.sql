-- SQL Database design for a self-driving car rental application

-- Table for users (accounts for both customers and car owners)
CREATE TABLE users (
                       user_id INT PRIMARY KEY AUTO_INCREMENT,
                       full_name VARCHAR(100) NOT NULL,
                       email VARCHAR(100) UNIQUE NOT NULL,
                       password VARCHAR(255),
                       phone_number VARCHAR(15),
                       user_type ENUM('customer', 'owner') NOT NULL,
                       created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                       verified BOOLEAN DEFAULT FALSE,
                       login_platform ENUM('email', 'google', 'facebook', 'other') NOT NULL,
                       platform_id VARCHAR(255),
                       deleted_at DATETIME,
                       CHECK (login_platform <> 'email' OR password IS NOT NULL)
);

-- Table for otp verification
CREATE TABLE otp_verification (
                                  otp_id INT PRIMARY KEY AUTO_INCREMENT,
                                  user_id INT,
                                  otp_code VARCHAR(6) NOT NULL,
                                  expires_at DATETIME NOT NULL,
                                  FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Table for transmissions
CREATE TABLE transmissions (
                               transmission_id INT PRIMARY KEY AUTO_INCREMENT,
                               transmission_type VARCHAR(50) NOT NULL,
                               deleted_at DATETIME
);

-- Table for fuels
CREATE TABLE fuels
(
    fuel_id    INT PRIMARY KEY AUTO_INCREMENT,
    fuel_type  VARCHAR(50) NOT NULL,
    deleted_at DATETIME
);

-- Table for car locations
CREATE TABLE car_locations (
                               location_id INT PRIMARY KEY AUTO_INCREMENT,
                               address_line VARCHAR(255) NOT NULL,
                               province VARCHAR(100) NOT NULL,
                               district VARCHAR(100) NOT NULL,
                               ward VARCHAR(100) NOT NULL,
                               latitude DECIMAL(10, 8),
                               longitude DECIMAL(11, 8),
                               deleted_at DATETIME
);

-- Table for cars
CREATE TABLE cars (
                      car_id INT PRIMARY KEY AUTO_INCREMENT,
                      owner_id INT,
                      car_name VARCHAR(100) NOT NULL,
                      description TEXT,
                      price_per_day DECIMAL(10, 2) NOT NULL,
                      times_rented INT DEFAULT 0,
                      transmission_id INT,
                      seats INT,
                      fuel_id INT,
                      range_per_charge_or_tank VARCHAR(50),
                      location_id INT,
                      created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                      deleted_at DATETIME,
                      FOREIGN KEY (owner_id) REFERENCES users(user_id) ON DELETE CASCADE,
                      FOREIGN KEY (transmission_id) REFERENCES transmissions(transmission_id) ON DELETE SET NULL,
                      FOREIGN KEY (fuel_id) REFERENCES fuels(fuel_id) ON DELETE SET NULL,
                      FOREIGN KEY (location_id) REFERENCES car_locations(location_id) ON DELETE SET NULL
);

-- Table for car images
CREATE TABLE car_images (
                            image_id INT PRIMARY KEY AUTO_INCREMENT,
                            car_id INT,
                            image_url VARCHAR(255) NOT NULL,
                            deleted_at DATETIME,
                            FOREIGN KEY (car_id) REFERENCES cars(car_id) ON DELETE CASCADE
);

-- Table for car amenities
CREATE TABLE amenities (
                           amenity_id INT PRIMARY KEY AUTO_INCREMENT,
                           amenity_name VARCHAR(100) NOT NULL,
                           icon VARCHAR(255),
                           deleted_at DATETIME
);

-- Table to link cars and amenities
CREATE TABLE car_amenities (
                               car_id INT,
                               amenity_id INT,
                               PRIMARY KEY (car_id, amenity_id),
                               FOREIGN KEY (car_id) REFERENCES cars(car_id) ON DELETE CASCADE,
                               FOREIGN KEY (amenity_id) REFERENCES amenities(amenity_id) ON DELETE CASCADE
);

-- Table for rentals
CREATE TABLE rentals (
                         rental_id INT PRIMARY KEY AUTO_INCREMENT,
                         car_id INT,
                         customer_id INT,
                         owner_id INT,
                         start_date DATETIME NOT NULL,
                         end_date DATETIME NOT NULL,
                         status ENUM('requested', 'approved', 'rejected', 'completed', 'canceled') DEFAULT 'requested',
                         created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                         deleted_at DATETIME,
                         FOREIGN KEY (car_id) REFERENCES cars(car_id) ON DELETE CASCADE,
                         FOREIGN KEY (customer_id) REFERENCES users(user_id) ON DELETE CASCADE,
                         FOREIGN KEY (owner_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Table for reviews
CREATE TABLE reviews (
                         review_id INT PRIMARY KEY AUTO_INCREMENT,
                         car_id INT,
                         customer_id INT,
                         rating INT CHECK (rating >= 1 AND rating <= 5),
                         review_text TEXT,
                         created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                         deleted_at DATETIME,
                         FOREIGN KEY (car_id) REFERENCES cars(car_id) ON DELETE CASCADE,
                         FOREIGN KEY (customer_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Table for addresses
CREATE TABLE addresses (
                           address_id INT PRIMARY KEY AUTO_INCREMENT,
                           user_id INT,
                           address_type ENUM('home', 'company', 'other') NOT NULL,
                           address_line VARCHAR(255) NOT NULL,
                           province VARCHAR(100) NOT NULL,
                           district VARCHAR(100) NOT NULL,
                           ward VARCHAR(100) NOT NULL,
                           specific_address VARCHAR(255) NOT NULL,
                           address_label VARCHAR(100),
                           is_default BOOLEAN DEFAULT FALSE,
                           created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                           deleted_at DATETIME,
                           FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Table for car features (Specific characteristics like transmission, fuel type, etc.)
CREATE TABLE car_features (
                              feature_id INT PRIMARY KEY AUTO_INCREMENT,
                              feature_name VARCHAR(100) NOT NULL,
                              deleted_at DATETIME
);

-- Table to link cars and features
CREATE TABLE car_feature_map (
                                 car_id INT,
                                 feature_id INT,
                                 feature_value VARCHAR(100),
                                 PRIMARY KEY (car_id, feature_id),
                                 FOREIGN KEY (car_id) REFERENCES cars(car_id) ON DELETE CASCADE,
                                 FOREIGN KEY (feature_id) REFERENCES car_features(feature_id) ON DELETE CASCADE
);

-- Table for booking history
CREATE TABLE booking_history (
                                 history_id INT PRIMARY KEY AUTO_INCREMENT,
                                 rental_id INT,
                                 status ENUM('requested', 'approved', 'rejected', 'completed', 'canceled') NOT NULL,
                                 updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                                 deleted_at DATETIME,
                                 FOREIGN KEY (rental_id) REFERENCES rentals(rental_id) ON DELETE CASCADE
);

-- Table for terms (can be edited)
CREATE TABLE terms (
                       term_id INT PRIMARY KEY AUTO_INCREMENT,
                       term_text TEXT NOT NULL,
                       created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                       updated_at DATETIME,
                       deleted_at DATETIME
);

-- Table for additional fees (can be edited)
CREATE TABLE additional_fees (
                                 fee_id INT PRIMARY KEY AUTO_INCREMENT,
                                 fee_name VARCHAR(100) NOT NULL,
                                 description TEXT,
                                 amount DECIMAL(10, 2) NOT NULL,
                                 unit VARCHAR(50) NOT NULL,
                                 created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                                 updated_at DATETIME,
                                 deleted_at DATETIME
);

-- Table for conversations between car owners and customers
CREATE TABLE conversations (
                               conversation_id INT PRIMARY KEY AUTO_INCREMENT,
                               owner_id INT NOT NULL CHECK (owner_id IN (SELECT user_id FROM users WHERE user_type = 'owner')),
                               customer_id INT NOT NULL,
                               created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                               deleted_at DATETIME,
                               FOREIGN KEY (owner_id) REFERENCES users(user_id) ON DELETE CASCADE,
                               FOREIGN KEY (customer_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Table for messages in conversations
CREATE TABLE messages (
                          message_id INT PRIMARY KEY AUTO_INCREMENT,
                          conversation_id INT NOT NULL,
                          sender_id INT NOT NULL,
                          message_text TEXT NOT NULL,
                          sent_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                          deleted_at DATETIME,
                          FOREIGN KEY (conversation_id) REFERENCES conversations(conversation_id) ON DELETE CASCADE,
                          FOREIGN KEY (sender_id) REFERENCES users(user_id) ON DELETE CASCADE
);
