DROP DATABASE IF EXISTS PatientManagementDB;
CREATE DATABASE PatientManagementDB;
USE PatientManagementDB;

CREATE TABLE IF NOT EXISTS Patient (
    PatientID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DOB DATE NOT NULL,
    Gender ENUM('Male', 'Female', 'Other') NOT NULL,
    Email VARCHAR(100) UNIQUE
);

CREATE TABLE IF NOT EXISTS Doctor (
    DoctorID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Specialization VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS Appointment (
    AppointmentID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    AppointmentDate DATETIME NOT NULL,
    Status ENUM('Scheduled', 'Completed', 'Cancelled') NOT NULL,
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID)
);

CREATE TABLE IF NOT EXISTS Prescription (
    PrescriptionID INT PRIMARY KEY AUTO_INCREMENT,
    AppointmentID INT NOT NULL,
    Medication VARCHAR(255) NOT NULL,
    Dosage VARCHAR(100) NOT NULL,
    FOREIGN KEY (AppointmentID) REFERENCES Appointment(AppointmentID)
);

CREATE TABLE IF NOT EXISTS MedicalRecord (
    RecordID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT NOT NULL,
    Diagnosis TEXT NOT NULL,
    TreatmentPlan TEXT NOT NULL,
    VisitDate DATE NOT NULL,
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
);

CREATE TABLE IF NOT EXISTS Bill (
    BillID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    PaymentStatus ENUM('Pending', 'Paid') NOT NULL,
    BillingDate DATE NOT NULL,
    DueDate DATE NOT NULL,
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
);

CREATE TABLE IF NOT EXISTS Staff (
    StaffID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Role VARCHAR(50) NOT NULL,
    Salary DECIMAL(10,2) NOT NULL
);
