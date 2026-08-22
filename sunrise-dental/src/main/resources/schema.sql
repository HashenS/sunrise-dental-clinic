-- Create database if not exists
CREATE DATABASE IF NOT EXISTS sunrise_dental;
USE sunrise_dental;

-- 1. Table for authorized staff credentials
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    role VARCHAR(20) NOT NULL
) ENGINE=InnoDB;

-- 2. Table to store appointment details
CREATE TABLE IF NOT EXISTS appointments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_number VARCHAR(20) NOT NULL UNIQUE,
    patient_name VARCHAR(100) NOT NULL,
    address VARCHAR(200) NOT NULL,
    contact_number VARCHAR(15) NOT NULL,
    nic_number VARCHAR(12) NOT NULL,
    dentist_name VARCHAR(100) NOT NULL,
    treatment_type VARCHAR(50) NOT NULL,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- 3. Table to store bill records
CREATE TABLE IF NOT EXISTS bills (
    id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_number VARCHAR(20) NOT NULL UNIQUE,
    patient_name VARCHAR(100) NOT NULL,
    treatment_type VARCHAR(50) NOT NULL,
    consultation_fee DOUBLE NOT NULL,
    treatment_cost DOUBLE NOT NULL,
    total_cost DOUBLE NOT NULL,
    payment_status VARCHAR(20) NOT NULL DEFAULT 'UNPAID',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (appointment_number) REFERENCES appointments(appointment_number) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Seed initial admin user (username: admin, password: adminpassword)
INSERT INTO users (username, password, role) 
VALUES ('admin', 'adminpassword', 'RECEPTIONIST')
ON DUPLICATE KEY UPDATE username=username;
