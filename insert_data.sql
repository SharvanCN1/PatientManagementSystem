USE PatientManagementDB

INSERT INTO Patient (FirstName, LastName, DOB, Gender, Email) VALUES
('John', 'Doe', '1985-03-15', 'Male', 'john.doe@example.com'),
('Emily', 'Smith', '1990-07-22', 'Female', 'emily.smith@example.com'),
('Michael', 'Johnson', '1978-11-05', 'Male', 'michael.johnson@example.com'),
('Sarah', 'Williams', '1992-04-18', 'Female', 'sarah.williams@example.com'),
('David', 'Brown', '1980-09-30', 'Male', 'david.brown@example.com'),
('Jessica', 'Miller', '1987-06-12', 'Female', 'jessica.miller@example.com'),
('Robert', 'Davis', '1975-01-25', 'Male', 'robert.davis@example.com'),
('Amanda', 'Garcia', '1995-08-07', 'Female', 'amanda.garcia@example.com'),
('Christopher', 'Martinez', '1983-12-14', 'Male', 'christopher.martinez@example.com'),
('Rachel', 'Anderson', '1988-02-28', 'Female', 'rachel.anderson@example.com');

INSERT INTO Doctor (FirstName, LastName, Specialization, Email, Phone) VALUES
('William', 'Thompson', 'Cardiology', 'william.thompson@hospital.com', '555-1234'),
('Elizabeth', 'Rodriguez', 'Pediatrics', 'elizabeth.rodriguez@hospital.com', '555-5678'),
('James', 'Lee', 'Orthopedics', 'james.lee@hospital.com', '555-9012'),
('Maria', 'Sanchez', 'Neurology', 'maria.sanchez@hospital.com', '555-3456'),
('Daniel', 'Kim', 'Oncology', 'daniel.kim@hospital.com', '555-7890'),
('Jennifer', 'Chen', 'Dermatology', 'jennifer.chen@hospital.com', '555-2345'),
('Thomas', 'Wilson', 'Psychiatry', 'thomas.wilson@hospital.com', '555-6789'),
('Linda', 'Taylor', 'Gynecology', 'linda.taylor@hospital.com', '555-0123'),
('Richard', 'Moore', 'Endocrinology', 'richard.moore@hospital.com', '555-4567'),
('Patricia', 'Jackson', 'Gastroenterology', 'patricia.jackson@hospital.com', '555-8901');

INSERT INTO Appointment (PatientID, DoctorID, AppointmentDate, Status) VALUES
(1, 1, '2024-03-20 10:00:00', 'Scheduled'),
(2, 2, '2024-03-21 14:30:00', 'Completed'),
(3, 3, '2024-03-22 09:15:00', 'Scheduled'),
(4, 4, '2024-03-23 11:45:00', 'Cancelled'),
(5, 5, '2024-03-24 13:00:00', 'Completed'),
(6, 6, '2024-03-25 15:30:00', 'Scheduled'),
(7, 7, '2024-03-26 08:45:00', 'Completed'),
(8, 8, '2024-03-27 16:00:00', 'Scheduled'),
(9, 9, '2024-03-28 10:30:00', 'Cancelled'),
(10, 10, '2024-03-29 14:00:00', 'Scheduled');

INSERT INTO Prescription (AppointmentID, Medication, Dosage) VALUES
(1, 'Aspirin', '100mg once daily'),
(2, 'Amoxicillin', '500mg three times daily'),
(3, 'Ibuprofen', '200mg as needed'),
(4, 'Metformin', '500mg twice daily'),
(5, 'Levothyroxine', '75mcg once daily'),
(6, 'Hydrochlorothiazide', '12.5mg once daily'),
(7, 'Atorvastatin', '40mg once daily'),
(8, 'Lisinopril', '10mg once daily'),
(9, 'Warfarin', '5mg once daily'),
(10, 'Omeprazole', '20mg once daily');

INSERT INTO MedicalRecord (PatientID, Diagnosis, TreatmentPlan, VisitDate) VALUES
(1, 'Hypertension', 'Lifestyle modification and medication', '2024-03-20'),
(2, 'Seasonal Allergies', 'Antihistamine and nasal spray', '2024-03-21'),
(3, 'Lower Back Pain', 'Physical therapy and pain management', '2024-03-22'),
(4, 'Type 2 Diabetes', 'Diet plan and insulin regulation', '2024-03-23'),
(5, 'Thyroid Disorder', 'Hormone replacement therapy', '2024-03-24'),
(6, 'Skin Rash', 'Topical cream and allergy test', '2024-03-25'),
(7, 'High Cholesterol', 'Statin medication and diet change', '2024-03-26'),
(8, 'Hypertension', 'Blood pressure medication', '2024-03-27'),
(9, 'Anxiety Disorder', 'Counseling and medication', '2024-03-28'),
(10, 'Acid Reflux', 'Dietary changes and medication', '2024-03-29');

INSERT INTO Bill (PatientID, Amount, PaymentStatus, BillingDate, DueDate) VALUES
(1, 250.00, 'Pending', '2024-03-20', '2024-04-20'),
(2, 175.50, 'Paid', '2024-03-21', '2024-04-21'),
(3, 300.75, 'Pending', '2024-03-22', '2024-04-22'),
(4, 225.00, 'Paid', '2024-03-23', '2024-04-23'),
(5, 190.25, 'Pending', '2024-03-24', '2024-04-24'),
(6, 265.50, 'Paid', '2024-03-25', '2024-04-25'),
(7, 210.75, 'Pending', '2024-03-26', '2024-04-26'),
(8, 185.00, 'Paid', '2024-03-27', '2024-04-27'),
(9, 240.50, 'Pending', '2024-03-28', '2024-04-28'),
(10, 275.25, 'Paid', '2024-03-29', '2024-04-29');

INSERT INTO Staff (FirstName, LastName, Role, Salary) VALUES
('Mark', 'Johnson', 'Receptionist', 35000.00),
('Laura', 'Martinez', 'Nurse', 55000.00),
('Kevin', 'Chen', 'Lab Technician', 45000.00),
('Sandra', 'Rodriguez', 'Administrative Assistant', 40000.00),
('Brian', 'Wilson', 'IT Support', 50000.00),
('Michelle', 'Taylor', 'Medical Billing Specialist', 48000.00),
('David', 'Garcia', 'Security Guard', 35000.00),
('Karen', 'Kim', 'Pharmacy Technician', 42000.00),
('Robert', 'Nguyen', 'Maintenance', 38000.00),
('Jennifer', 'Brown', 'Human Resources', 52000.00);
