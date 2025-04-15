USE PatientManagementDB;

SELECT * FROM Patient;

SELECT FirstName, LastName, DOB FROM Patient WHERE Gender = 'Female';

SELECT Specialization, COUNT(*) AS TotalDoctors FROM Doctor GROUP BY Specialization;

SELECT p.FirstName, p.LastName, a.AppointmentDate, d.FirstName AS DoctorFirstName, d.LastName AS DoctorLastName 
FROM Appointment a
JOIN Patient p ON a.PatientID = p.PatientID
JOIN Doctor d ON a.DoctorID = d.DoctorID;

SELECT p.FirstName, p.LastName, COUNT(a.AppointmentID) AS TotalAppointments 
FROM Patient p 
JOIN Appointment a ON p.PatientID = a.PatientID 
GROUP BY p.PatientID 
HAVING TotalAppointments > 1;

SELECT d.FirstName, d.LastName, COUNT(a.AppointmentID) AS TotalAppointments 
FROM Doctor d 
LEFT JOIN Appointment a ON d.DoctorID = a.DoctorID 
GROUP BY d.DoctorID 
ORDER BY TotalAppointments DESC;

UPDATE Appointment 
SET Status = 'Completed' 
WHERE AppointmentDate < NOW() AND Status = 'Scheduled';

--DELETE FROM Appointment 
--WHERE Status = 'Cancelled';

SELECT p.FirstName, p.LastName, b.Amount, b.PaymentStatus 
FROM Bill b
JOIN Patient p ON b.PatientID = p.PatientID
WHERE b.PaymentStatus = 'Pending'
ORDER BY b.Amount DESC;

--INSERT INTO Patient (FirstName, LastName, DOB, Gender) VALUES ('Michael', 'Brown', '1988-07-19', 'Male');

UPDATE Appointment SET Status = 'Completed' WHERE AppointmentID = 2;

--DELETE FROM Bill WHERE PaymentStatus = 'Paid';

SELECT Gender, COUNT(*) AS TotalPatients FROM Patient GROUP BY Gender;

SELECT DoctorID, COUNT(AppointmentID) AS AppointmentCount FROM Appointment GROUP BY DoctorID HAVING COUNT(AppointmentID) > 3;

SELECT p.FirstName, p.LastName, SUM(b.Amount) AS TotalBilled FROM Bill b JOIN Patient p ON b.PatientID = p.PatientID GROUP BY p.PatientID;

SELECT AppointmentDate, COUNT(*) AS TotalAppointments FROM Appointment GROUP BY AppointmentDate HAVING TotalAppointments > 2;

SELECT d.FirstName, d.LastName, COUNT(a.AppointmentID) AS AppointmentsHandled FROM Doctor d LEFT JOIN Appointment a ON d.DoctorID = a.DoctorID GROUP BY d.DoctorID;

SELECT PaymentStatus, COUNT(*) AS TotalPayments FROM Bill GROUP BY PaymentStatus HAVING COUNT(*) > 1;

