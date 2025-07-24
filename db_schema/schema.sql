-- currency
CREATE TABLE currency (
    id INT PRIMARY KEY AUTO_INCREMENT,
    currency_code VARCHAR(5) NOT NULL,
    exchange_rate DECIMAL(12,6) NOT NULL
);

-- country
CREATE TABLE country (
    id INT PRIMARY KEY AUTO_INCREMENT,
    country_name VARCHAR(100) NOT NULL,
    language_code VARCHAR(10) NOT NULL,
    currency_id INT NOT NULL,
    FOREIGN KEY (currency_id) REFERENCES currency(id)
);

-- zip_code
CREATE TABLE zip_code (
    id INT PRIMARY KEY AUTO_INCREMENT,
    zip_code VARCHAR(20) NOT NULL
);

-- city
CREATE TABLE city (
    id INT PRIMARY KEY AUTO_INCREMENT,
    city_name VARCHAR(100) NOT NULL,
    country_id INT NOT NULL,
    zip_code_id INT NOT NULL,
    FOREIGN KEY (country_id) REFERENCES country(id),
    FOREIGN KEY (zip_code_id) REFERENCES zip_code(id)
);

-- rental_agency
CREATE TABLE rental_agency (
    id INT PRIMARY KEY AUTO_INCREMENT,
    agency_name VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    city_id INT NOT NULL,
    FOREIGN KEY (city_id) REFERENCES city(id)
);

-- user
CREATE TABLE user (
    id INT PRIMARY KEY AUTO_INCREMENT,
    is_active BOOLEAN NOT NULL DEFAULT 1,
    gender ENUM('MALE', 'FEMALE', 'OTHER', 'UNSPECIFIED') NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    address VARCHAR(255) NOT NULL,
    email_address VARCHAR(100) NOT NULL UNIQUE,
    phone_number VARCHAR(20) NOT NULL,
    driving_licence_number VARCHAR(50) NOT NULL,
    city_id INT NOT NULL,
    FOREIGN KEY (city_id) REFERENCES city(id)
);

-- acriss_category
CREATE TABLE acriss_category (
    id INT PRIMARY KEY AUTO_INCREMENT,
    category_code CHAR(1) NOT NULL
);

-- acriss_type
CREATE TABLE acriss_type (
    id INT PRIMARY KEY AUTO_INCREMENT,
    type_code CHAR(1) NOT NULL
);

-- acriss_transmission_drive
CREATE TABLE acriss_transmission_drive (
    id INT PRIMARY KEY AUTO_INCREMENT,
    transmission_drive_code CHAR(1) NOT NULL
);

-- acriss_fuel_aircond
CREATE TABLE acriss_fuel_aircond (
    id INT PRIMARY KEY AUTO_INCREMENT,
    fuel_aircond_code CHAR(1) NOT NULL
);

-- vehicle_category
CREATE TABLE vehicle_category (
    id INT PRIMARY KEY AUTO_INCREMENT,
    acriss_category_id INT NOT NULL,
    acriss_type_id INT NOT NULL,
    acriss_transmission_drive_id INT NOT NULL,
    acriss_fuel_aircond_id INT NOT NULL,
    FOREIGN KEY (acriss_category_id) REFERENCES acriss_category(id),
    FOREIGN KEY (acriss_type_id) REFERENCES acriss_type(id),
    FOREIGN KEY (acriss_transmission_drive_id) REFERENCES acriss_transmission_drive(id),
    FOREIGN KEY (acriss_fuel_aircond_id) REFERENCES acriss_fuel_aircond(id)
);

-- vehicle
CREATE TABLE vehicle (
    id INT PRIMARY KEY AUTO_INCREMENT,
    licence_plate VARCHAR(20) NOT NULL UNIQUE,
    brand VARCHAR(50) NOT NULL,
    model VARCHAR(50) NOT NULL,
    year INT NOT NULL,
    number_of_seats INT NOT NULL,
    photo_url VARCHAR(255) NOT NULL,
    vehicle_category_id INT NOT NULL,
    rental_agency_id INT NOT NULL,
    FOREIGN KEY (vehicle_category_id) REFERENCES vehicle_category(id),
    FOREIGN KEY (rental_agency_id) REFERENCES rental_agency(id)
);

-- rental_offer
CREATE TABLE rental_offer (
    id INT PRIMARY KEY AUTO_INCREMENT,
    status ENUM('ACTIVE','INACTIVE','EXPIRED','ARCHIVED') NOT NULL DEFAULT 'ACTIVE',
    departure_date DATE NOT NULL,
    departure_time TIME NOT NULL,
    return_date DATE NOT NULL,
    return_time TIME NOT NULL,
    price_in_usd DECIMAL(10,2) NOT NULL,
    rental_agency_id INT NOT NULL,
    vehicle_category_id INT NOT NULL,
    departure_city_id INT NOT NULL,
    return_city_id INT NOT NULL,
    FOREIGN KEY (rental_agency_id) REFERENCES rental_agency(id),
    FOREIGN KEY (vehicle_category_id) REFERENCES vehicle_category(id),
    FOREIGN KEY (departure_city_id) REFERENCES city(id),
    FOREIGN KEY (return_city_id) REFERENCES city(id)
);

-- rental
CREATE TABLE rental (
    id INT PRIMARY KEY AUTO_INCREMENT,
    status ENUM('PENDING','CONFIRMED','CANCELED','ACTIVE','COMPLETED') NOT NULL DEFAULT 'PENDING',
    timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    departure_date DATE NOT NULL,
    departure_time TIME NOT NULL,
    return_date DATE NOT NULL,
    return_time TIME NOT NULL,
    price_in_usd DECIMAL(10,2) NOT NULL,
    user_id INT NOT NULL,
    rental_offer_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES user(id),
    FOREIGN KEY (rental_offer_id) REFERENCES rental_offer(id)
);

-- payment
CREATE TABLE payment (
    id INT PRIMARY KEY AUTO_INCREMENT,
    status ENUM('PAID','REFUNDED') NOT NULL DEFAULT 'PAID',
    timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    transaction_id VARCHAR(100) NOT NULL,
    amount_in_usd DECIMAL(10,2) NOT NULL,
    local_transaction_amount DECIMAL(10,2) NOT NULL,
    rental_id INT NOT NULL UNIQUE,
    FOREIGN KEY (rental_id) REFERENCES rental(id)
);

-- refund
CREATE TABLE refund (
    id INT PRIMARY KEY AUTO_INCREMENT,
    timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    transaction_id VARCHAR(100) NOT NULL,
    amount_in_usd DECIMAL(10,2) NOT NULL,
    local_transaction_amount DECIMAL(10,2) NOT NULL,
    payment_id INT NOT NULL UNIQUE,
    FOREIGN KEY (payment_id) REFERENCES payment(id)
);
