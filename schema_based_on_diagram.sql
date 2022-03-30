/* Database schema to keep the structure of entire database. */
CREATE DATABASE Clinic;

CREATE TABLE patients(
	id INT PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255),
	date_of_birth DATE
);

CREATE TABLE medical_histories (   
id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
admitted_at TIMESTAMP,
patient_id INT,
status VARCHAR(255));

ALTER TABLE medical_histories ADD CONSTRAINT id_fk FOREIGN KEY (patient_id) REFERENCES patients(id);

CREATE TABLE invoices(
	id INT PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY,
  total_amount DECIMAL,
	generated_at TIMESTAMP,
	payed_at TIMESTAMP,
	medical_history_id int
);

ALTER TABLE invoices 
ADD CONSTRAINT medical_histories_constraint 
FOREIGN KEY(medical_history_id) REFERENCES medical_histories(id);

CREATE TABLE invoice_items (
id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
unit_price DECIMAL,
quantity INT,
total_price DECIMAL,
invoice_id INT,
treatment_id INT );

ALTER TABLE invoice_items ADD CONSTRAINT id_invoice_fk FOREIGN KEY (invoice_id) REFERENCES invoices(id); 

CREATE TABLE treatments(
id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
type VARCHAR(225),
name VARCHAR(225));

ALTER TABLE invoice_items ADD CONSTRAINT id_treatment_fk FOREIGN KEY (treatment_id) REFERENCES treatments(id); 

CREATE TABLE medicalhistories_treatments(
	id_medical_history INT REFERENCES medical_histories(id),
	id_treatments INT REFERENCES treatments(id)
);

ALTER TABLE medicalhistories_treatments 
ADD CONSTRAINT medicalhistories_treatments_constraint 
PRIMARY KEY(id_medical_history,id_treatments);