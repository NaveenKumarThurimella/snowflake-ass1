CREATE TABLE PatientRecords (
    patient_id INT,
    patient_name STRING,
    region STRING,
    diagnosis STRING,
    date_of_visit DATE
);

INSERT INTO PatientRecords (patient_id, patient_name, region, diagnosis, date_of_visit) 
VALUES
    (1, 'John Doe', 'North', 'Flu', '2024-12-01'),
    (2, 'Jane Smith', 'South', 'Cold', '2024-12-02'),
    (3, 'Alice Brown', 'North', 'COVID-19', '2024-12-03'),
    (4, 'Bob White', 'East', 'Back Pain', '2024-12-04'),
    (5, 'Charlie Green', 'West', 'Asthma', '2024-12-05');


CREATE ROW ACCESS POLICY region_policy
  AS 
  (user_region STRING, data_region STRING) 
  RETURNS BOOLEAN ->
    user_region = data_region;

ALTER TABLE PatientRecords
  ADD ROW ACCESS POLICY region_policy
  ON (region);

ALTER SESSION SET user_region = 'North';

SELECT * FROM PatientRecords;
