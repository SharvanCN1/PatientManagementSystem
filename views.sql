USE PatientManagementDB;

CREATE VIEW PatientAppointments AS
SELECT p.PatientID, p.FirstName, p.LastName, a.AppointmentID, a.AppointmentDate, a.Status, d.FirstName AS DoctorFirstName, d.LastName AS DoctorLastName 
FROM Appointment a
JOIN Patient p ON a.PatientID = p.PatientID
JOIN Doctor d ON a.DoctorID = d.DoctorID;

CREATE VIEW DoctorSummary AS
SELECT d.DoctorID, d.FirstName, d.LastName, d.Specialization, COUNT(a.AppointmentID) AS TotalAppointments 
FROM Doctor d
LEFT JOIN Appointment a ON d.DoctorID = a.DoctorID
GROUP BY d.DoctorID;

CREATE VIEW PendingBills AS
SELECT b.BillID, p.FirstName, p.LastName, b.Amount, b.PaymentStatus 
FROM Bill b
JOIN Patient p ON b.PatientID = p.PatientID
WHERE b.PaymentStatus = 'Pending';

CREATE VIEW MedicalRecordsSummary AS
SELECT p.PatientID, p.FirstName, p.LastName, m.RecordID, m.Diagnosis, m.TreatmentPlan 
FROM MedicalRecord m
JOIN Patient p ON m.PatientID = p.PatientID;

CREATE VIEW PrescriptionDetails AS
SELECT pr.PrescriptionID, p.FirstName, p.LastName, d.FirstName AS DoctorFirstName, d.LastName AS DoctorLastName, pr.Medication, pr.Dosage 
FROM Prescription pr
JOIN Appointment a ON pr.AppointmentID = a.AppointmentID
JOIN Patient p ON a.PatientID = p.PatientID
JOIN Doctor d ON a.DoctorID = d.DoctorID;
