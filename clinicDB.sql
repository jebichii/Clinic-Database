-- Creating a database for the clinic system
CREATE DATABASE ClinicDB;
USE ClinicDB;

-- Table for storing patient information
CREATE TABLE Patients (
    PatientID INT PRIMARY KEY AUTO_INCREMENT, -- Unique identifier for each patient
    FullName VARCHAR(100) NOT NULL, -- Patient's full name
    DOB DATE NOT NULL, -- Date of birth
    Gender ENUM('Male', 'Female', 'Other') NOT NULL, -- Gender selection
    ContactNumber VARCHAR(15) NOT NULL UNIQUE, -- Unique phone number
    Email VARCHAR(100) UNIQUE, -- Unique email
    Address TEXT -- Address details
);

-- Table for storing doctor details
CREATE TABLE Doctors (
    DoctorID INT PRIMARY KEY AUTO_INCREMENT, -- Unique identifier for each doctor
    Name VARCHAR(100) NOT NULL, -- Doctor's name
    Specialization VARCHAR(50) NOT NULL, -- Area of expertise
    ContactNumber VARCHAR(15) NOT NULL UNIQUE, -- Unique contact number
    Email VARCHAR(100) UNIQUE, -- Unique email
    Availability ENUM('Available', 'Unavailable') DEFAULT 'Available' -- Doctor's availability status
);

-- Table for managing clinic appointments
CREATE TABLE Appointments (
    AppointmentID INT PRIMARY KEY AUTO_INCREMENT, -- Unique appointment ID
    PatientID INT NOT NULL, -- References Patients table (One patient can have multiple appointments)
    DoctorID INT NOT NULL, -- References Doctors table (One doctor can have multiple appointments)
    AppointmentDate DATE NOT NULL, -- Date of the appointment
    AppointmentTime TIME NOT NULL, -- Time of the appointment
    Status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled', -- Appointment status
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID) ON DELETE CASCADE, -- Relationship: One-to-Many (Patient → Appointments)
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID) ON DELETE CASCADE -- Relationship: One-to-Many (Doctor → Appointments)
);

-- Table for storing medical records of patients
CREATE TABLE MedicalRecords (
    RecordID INT PRIMARY KEY AUTO_INCREMENT, -- Unique medical record ID
    PatientID INT NOT NULL, -- References Patients table (One patient can have multiple medical records)
    DoctorID INT NOT NULL, -- References Doctors table (One doctor can add multiple medical records)
    Diagnosis TEXT NOT NULL, -- Diagnosis information
    Prescription TEXT, -- Medications prescribed
    VisitDate DATE NOT NULL, -- Date of the visit
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID) ON DELETE CASCADE, -- Relationship: One-to-Many (Patient → MedicalRecords)
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID) ON DELETE CASCADE -- Relationship: One-to-Many (Doctor → MedicalRecords)
);

-- Table for payment details
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY AUTO_INCREMENT, -- Unique payment transaction ID
    PatientID INT NOT NULL, -- References Patients table (Each patient can make multiple payments)
    AppointmentID INT NOT NULL, -- References Appointments table (Each appointment can have a payment)
    Amount DECIMAL(10,2) NOT NULL CHECK (Amount > 0), -- Payment amount with validation
    PaymentDate DATE NOT NULL, -- Date of payment
    PaymentStatus ENUM('Pending', 'Paid', 'Failed') DEFAULT 'Pending', -- Payment status
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID) ON DELETE CASCADE, -- Relationship: One-to-Many (Patient → Payments)
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID) ON DELETE CASCADE -- Relationship: One-to-One (Appointment → Payment)
);
