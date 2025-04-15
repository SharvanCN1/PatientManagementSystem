USE PatientManagementDB;

CREATE INDEX idx_patient_name ON Patient (FirstName, LastName);

CREATE INDEX idx_doctor_specialization ON Doctor (Specialization);

CREATE INDEX idx_appointment_patient ON Appointment (PatientID);

CREATE INDEX idx_appointment_doctor ON Appointment (DoctorID);

CREATE INDEX idx_bill_patient ON Bill (PatientID);

CREATE INDEX idx_medical_record_patient ON MedicalRecord (PatientID);

CREATE INDEX idx_prescription_appointment ON Prescription (AppointmentID);

