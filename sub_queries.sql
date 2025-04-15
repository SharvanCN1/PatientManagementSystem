USE PatientManagementDB;

SELECT FirstName, LastName FROM Patient WHERE PatientID IN (SELECT PatientID FROM Appointment WHERE Status = 'Scheduled');

SELECT DoctorID, FirstName, LastName FROM Doctor WHERE DoctorID = (SELECT DoctorID FROM Appointment WHERE AppointmentDate = (SELECT MIN(AppointmentDate) FROM Appointment));

SELECT p.FirstName, p.LastName FROM Patient p WHERE EXISTS (SELECT 1 FROM Bill b WHERE b.PatientID = p.PatientID AND b.PaymentStatus = 'Pending');

SELECT FirstName, LastName FROM Patient WHERE PatientID NOT IN (SELECT DISTINCT PatientID FROM Appointment);

SELECT FirstName, LastName FROM Doctor WHERE DoctorID IN (SELECT DoctorID FROM Appointment GROUP BY DoctorID HAVING COUNT(*) = (SELECT MAX(AppointmentCount) FROM (SELECT COUNT(*) AS AppointmentCount FROM Appointment GROUP BY DoctorID) AS Counts));
