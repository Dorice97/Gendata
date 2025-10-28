
use stud_db;
# Question 1 : Using JOIN get the student names, school id, email, phone number (new_stud_details)

CREATE VIEW new_stud_details AS
SELECT 
    pd.stud_name AS Student_Name,
    pd.stud_ID AS Student_ID,
    sd.stud_email AS Email,
    pd.phone_number AS Phone_Number
FROM personal_details pd
JOIN school_details sd ON pd.stud_ID = sd.stud_ID
JOIN contact_details cd ON sd.stud_email = cd.stud_email;

select * 
from new_stud_details;


#Question 2: Create a table with all the details from contacts to school and financial details (full_stud_details)

CREATE TABLE full_stud_details AS
SELECT
    pd.national_ID,
    pd.stud_ID,
    pd.stud_name,
    pd.phone_number,
    pd.age,
    pd.gender,
    
    sd.current_home_county,
    sd.secondary_school_county,
    sd.residence,
    sd.stud_email,
    
    cd.next_of_kin_name,
    cd.next_of_kin_relation,
    cd.next_of_kin_contacts,
    
    fd.sem_fee,
    fd.fee_paid,
    (fd.sem_fee - fd.fee_paid) AS fee_balance

FROM personal_details pd
JOIN school_details sd 
    ON pd.stud_ID = sd.stud_ID
JOIN contact_details cd 
    ON sd.stud_email = cd.stud_email
JOIN financial_details fd 
    ON pd.stud_ID = fd.stud_ID;

select * from full_stud_details;

# Question 4 : Add student names on any empty row of stud_name in financial_details

SET SQL_SAFE_UPDATES = 0;

UPDATE financial_details fd
JOIN personal_details pd 
  ON fd.stud_ID = pd.stud_ID
SET fd.stud_name = pd.stud_name
WHERE fd.stud_name IS NULL OR fd.stud_name = '';

# Question 4:  On the financial_details table add a column, fee_cleared, that has True if student has cleared current


UPDATE financial_details
SET fee_cleared = (fee_paid >= sem_fee);

#for any upcoming fee updates to change status

DELIMITER $$

CREATE TRIGGER trg_modify_fee_cleared
BEFORE UPDATE ON financial_details
FOR EACH ROW
BEGIN
  IF NEW.fee_paid >= NEW.sem_fee THEN
    SET NEW.fee_cleared = TRUE;
  ELSE
    SET NEW.fee_cleared = FALSE;
  END IF;
END$$

DELIMITER ;

# update a fee status
UPDATE financial_details
SET fee_paid = 25000
WHERE stud_ID = 'stud102';

SELECT stud_ID, stud_name, sem_fee, fee_paid, fee_cleared
FROM financial_details
WHERE stud_ID = 'stud102';


# quesztion 5: Get the national ID and name of all students who have cleared their fees (fee_cleared)

CREATE VIEW fee_cleared AS
SELECT 
    pd.national_ID,
    pd.stud_name
FROM 
    personal_details pd
JOIN 
    financial_details fd 
    ON pd.stud_ID = fd.stud_ID
WHERE 
    fd.fee_cleared = TRUE;
    
select * from fee_cleared;

# question 6 : Get the total sum of fees paid so far and the total current deficit (total_fee_balance)

SELECT 
    SUM(fee_paid) AS total_fees_paid,
    SUM(sem_fee - fee_paid) AS total_fee_balance
FROM 
    financial_details;
    
#Question 7: Get the count of students who share a current home county i.e., Say Nairobi, get the number of students who’s current_home_county is Nairobi, and so on for all available counties (home_county_count)

CREATE VIEW home_county_count AS
SELECT 
    current_home_county,
    COUNT(stud_ID) AS student_count
FROM 
    school_details
GROUP BY 
    current_home_county;
  
  # Question 8 Get the count of Male and/or Female students from each secondary_school_county (secondary_school_count). The table should contain a column for male student count and female student count for each county.
  
CREATE VIEW secondary_school_count AS
SELECT 
    s.secondary_school_county,
    SUM(CASE WHEN p.gender = 'Male' THEN 1 ELSE 0 END) AS male_count,
    SUM(CASE WHEN p.gender = 'Female' THEN 1 ELSE 0 END) AS female_count
FROM 
    school_details s
JOIN 
    personal_details p 
    ON s.stud_ID = p.stud_ID
GROUP BY 
    s.secondary_school_county;

# Question 9: Get the percentage of students who set their next_of_kin as Mother vs those that set it as Father1. (kin_percentage) 

CREATE VIEW kin_percentage AS
SELECT 
    next_of_kin_relation,
    COUNT(*) AS total_students,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM contact_details), 2) AS percentage
FROM 
    contact_details
WHERE 
    next_of_kin_relation IN ('Mother', 'Father')
GROUP BY 
    next_of_kin_relation;
    
SELECT * FROM kin_percentage;