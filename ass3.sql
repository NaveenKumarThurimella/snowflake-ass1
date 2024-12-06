----TASK 1

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


---TASK2

-- Step 1: Set Up the Original Table and Insert Data
CREATE OR REPLACE TABLE PatientRecords (
    PatientID INT,
    Name STRING,
    Diagnosis STRING,
    AdmissionDate DATE
);

INSERT INTO PatientRecords (PatientID, Name, Diagnosis, AdmissionDate) VALUES
(1, 'Alice', 'Flu', '2024-11-01'),
(2, 'Bob', 'Cold', '2024-11-02'),
(3, 'Charlie', 'Asthma', '2024-11-03');

-- Step 2: Update Data in the Table (Simulate Changes)
UPDATE PatientRecords
SET Diagnosis = 'Pneumonia'
WHERE PatientID = 1;

-- Step 3: Clone the Table Using Time Travel
-- Clone the table to capture the data before the update, specifying the offset in seconds (e.g., -60 for 60 seconds before the update)
 -- Clones the table data 60 seconds before the update

CREATE OR REPLACE TABLE PatientRecordsClone
CLONE PatientRecords
AT (OFFSET => -60);
-- Step 4: Query the Clone and Compare
-- Query the cloned data (historical snapshot)
SELECT * FROM PatientRecordsClone;

-- Query the original table (live data)
SELECT * FROM PatientRecords;
