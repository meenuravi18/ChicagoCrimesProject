SET GLOBAL local_infile = 1;
SHOW VARIABLES LIKE "secure_file_priv";



LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Location_Table.csv' 
INTO TABLE chicagocrime.location
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
  LINES TERMINATED BY '\r\n'
  IGNORE 1 LINES
  (Location_ID, Block, Location_Description, District, Ward, Community_Area_ID, L_Lattitude, L_Longitude)
;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Case_Information_Table.csv' 
INTO TABLE chicagocrime.case_information
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
  LINES TERMINATED BY '\r\n'
  IGNORE 1 LINES
  (Case_Number, Arrest, Domestic, Crime_ID, Date, Crime_Description, FBI_Code, IUCR_Code, Location_ID)
;
