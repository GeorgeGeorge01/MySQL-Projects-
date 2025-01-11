USE UK_Road_Safety;

show tables;
select * from vehicle;

/* create table for Vehicle Data */
CREATE TABLE Vehicle (
    collision_index VARCHAR(50) PRIMARY KEY,
    vehicle_reference INT,
    vehicle_type INT,
    vehicle_manoeuvre INT,
    vehicle_direction_from INT,
    vehicle_direction_to INT,
    sex_of_driver INT,
    age_band_of_driver INT
);

/* Create table for Casualty Data */
CREATE TABLE Casualty (
    collision_index VARCHAR(50) PRIMARY KEY,
    casualty_reference INT,
    casualty_class INT,
    casualty_severity INT,
    sex_of_casualty INT,
    age_band_of_casualty INT)
    ;
  drop table collision; 
-- Create Table for Collision Data
CREATE TABLE Collision (
    collision_index VARCHAR(50) PRIMARY KEY,
    day_of_week INT,
    time TIME,
    road_type INT,
    speed_limit INT,
    light_conditions INT,
    weather_conditions INT,
    number_of_vehicles INT,
    number_of_casualties INT,
    local_authority_highway VARCHAR(5000));

/* Load for Vehicle Data */
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/vehicle_2024mid-year.csv'
INTO TABLE vehicle
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
;

/* Load for Casualty Data */
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/casualty_2024mid_year.csv'
INTO TABLE Casualty
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

/* Load for Collision Data */
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/collision_2024mid-year.csv'
INTO TABLE Collision
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/collision_2024mid-year.csv'
INTO TABLE collision
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


ALTER TABLE collision
MODIFY local_authority_highway VARCHAR(1000); -- Adjust the length as needed

UPDATE collision
SET local_authority_highway = LEFT(local_authority_highway, 1000);


SELECT * FROM collision;


SELECT collision_index, vehicle_reference FROM vehicle LIMIT 10;
DELETE FROM Vehicle
WHERE collision_index IS NULL
AND vehicle_reference IS NULL
AND vehicle_type IS NULL
AND vehicle_manoeuvre IS NULL
AND vehicle_direction_from IS NULL
AND vehicle_direction_to IS NULL
AND sex_of_driver IS NULL
AND age_band_of_driver IS NULL
;

SELECT 
    v.vehicle_type, 
    c.casualty_severity, 
    COUNT(*) AS severity_count
FROM 
    Vehicle v
INNER JOIN 
    Casualty c
ON 
    v.collision_index = c.collision_index
GROUP BY 
    v.vehicle_type, c.casualty_severity
ORDER BY 
    v.vehicle_type, c.casualty_severity;
    
drop table VehicleTypeReference;

CREATE TABLE VehicleTypeReference (
    vehicle_type INT PRIMARY KEY,
    vehicle_type_description VARCHAR(255)
);

INSERT INTO VehicleTypeReference VALUES 
(-1, 'Data missing'),
(1, 'Pedal cycle'),
(2, 'Motorcycle 50cc and under'),
(3, 'Motorcycle 125cc and under'),
(4, 'Motorcycle over 125cc and up to 500cc'),
(5, 'Motorcycle over 500cc'),
(8, 'Taxi/Private hire car'),
(9, 'Car'),
(10, 'Minibus (8 - 16 passenger seats)'),
(11, 'Bus or coach (17 or more pass seats)'),
(16, 'Ridden horse'),
(17, 'Agricultural vehicle'),
(18, 'Tram'),
(19, 'Van / Goods 3.5 tonnes mgw or under'),
(20, 'Goods over 3.5t. and under 7.5t'),
(21, 'Goods 7.5 tonnes mgw and over'),
(22, 'Mobility scooter'),
(23, 'Electric motorcycle'),
(90, 'Other vehicle'),
(97, 'Motorcycle - unknown cc'),
(98, 'Goods vehicle - unknown weight'),
(99, 'Unknown vehicle type (self rep only)'),
(103,'Motorcycle - Scooter (1979-1998)'),
(104,'Motorcycle (1979-1998)'),
(105,'Motorcycle - Combination (1979-1998)'),
(106,'Motorcycle over 125cc (1999-2004)'),
(108,'Taxi (excluding private hire cars) (1979-2004)'),
(109,'Car (including private hire cars) (1979-2004)'),
(110,'Minibus/Motor caravan (1979-1998)'),
(113,'Goods over 3.5 tonnes (1979-1998)');

CREATE TABLE CasualtySeverityReference (
    casualty_serverity INT PRIMARY KEY,
    casualty_serverity_description VARCHAR(255)
    );

INSERT INTO CasualtySeverityReference VALUES 
(1, 'Fatal'),
(2, 'Serious'),
(3, 'Slight');

CREATE TABLE AgebandofdriverReference (
    age_band_of_driver INT PRIMARY KEY,
    age_band_of_driver_description VARCHAR(255)
    );

select * from AgebandofdriverReference;
INSERT INTO AgebandofdriverReference VALUES
(1,'0-5'),
(2,'6-10'),
(3,'11-15'),
(4,'16-20'),
(5,'12-25'),
(6,'26-35'),
(7,'36-45'),
(8,'46-55'),
(9,'56-65'),
(10,'66-75'),
(11,'Over 75'),
(-1,'Data missing');

CREATE TABLE AgebandofcasualtyReference (
    age_band_of_casaualty INT PRIMARY KEY,
    age_band_of_casaualty_description VARCHAR(255)
    );

INSERT INTO AgebandofcasualtyReference VALUES
(1,'0-5'),
(2,'6-10'),
(3,'11-15'),
(4,'16-20'),
(5,'12-25'),
(6,'26-35'),
(7,'36-45'),
(8,'46-55'),
(9,'56-65'),
(10,'66-75'),
(11,'Over 75'),
(-1,'Data missing');

CREATE TABLE light_conditionsReference (
    light_conditions INT PRIMARY KEY,
    light_conditions_description VARCHAR(255)
    );
    
INSERT INTO light_conditionsReference VALUES
(1,'Daylight'),
(4,'Darkness - lights lit'),
(5,'Darkness - lights unlit'),
(6,'Darkness - no lighting'),
(7,'Darkness - lighting unknown'),
(-1,'Data missing');

CREATE TABLE day_of_weekReference (
    day_of_week INT PRIMARY KEY,
    day_of_week_description VARCHAR(255)
    );
    
INSERT INTO day_of_weekReference (day_of_week, day_of_week_description)
VALUES 
(1, 'Sunday'),
(2, 'Monday'),
(3, 'Tuesday'),
(4, 'Wednesday'),
(5, 'Thursday'),
(6, 'Friday'),
(7, 'Saturday');

CREATE TABLE weather_conditionsReference (
    weather_conditions INT PRIMARY KEY,
    weather_conditions_description VARCHAR(255)
    );
    
INSERT INTO weather_conditionsReference VALUES
(1,'Fine no high winds'),
(2,'Raining no high winds'),
(3,'Snowing no high winds'),
(4,'Fine + high winds'),
(5,'Raining + high winds'),
(6,'Snowing + high winds'),
(7,'Fog or mist'),
(8,'Other'),
(9,'unknown'),
(-1,'Data missing');

CREATE TABLE sex_of_driveryReference (
    sex_of_drivery INT PRIMARY KEY,
    sex_of_drivery_description VARCHAR(255)
    );
    
INSERT INTO sex_of_driveryReference VALUES
(1,'Male'),
(2,'Female'),
(3,'Not known'),
(-1,'Data missing');

CREATE TABLE local_authority_highwayReference (
    local_authority_highway VARCHAR(50) PRIMARY KEY,
    local_authority_highway_description VARCHAR(255)
    );
    
INSERT INTO local_authority_highwayReference VALUES
('E06000001','Hartlepool'),
('E06000002','Middlesbrough'),
('E06000003','Redcar and Cleveland'),
('E06000004','Stockton-on-Tees'),
('E06000005','Darlington'),
('E06000006','Halton'),
('E06000007','Warrington'),
('E06000008','Blackburn with Darwen'),
('E06000009','Blackpool'),
('E06000010','City of Kingston upon Hull'),
('E06000011','East Riding of Yorkshire'),
('E06000012','North East Lincolnshire'),
('E06000013','North Lincolnshire'),
('E06000014','York'),
('E06000015','Derby'),
('E06000016','Leicester'),
('E06000017','Rutland'),
('E06000018','Nottingham'),
('E06000019','County of Herefordshire'), 
('E06000020','Telford and Wrekin'),
('E06000021','Stoke-on-Trent'),
('E06000022','Bath and North East Somerset'),
('E06000023','City of Bristol'),
('E06000024','North Somerset'),
('E06000025','South Gloucestershire'),
('E06000026','Plymouth'),
('E06000027','Torbay'),
('E06000028','Bournemouth'),
('E06000029','Poole'),
('E06000030','Swindon'),
('E06000031','Peterborough'),
('E06000032','Luton'),
('E06000033','Southend-on-Sea'),
('E06000034','Thurrock'),
('E06000035','Medway'),
('E06000037','West Berkshire'),
('E06000038','Reading'),
('E06000039','Slough'),
('E06000040','Windsor and Maidenhead'),
('E06000041','Wokingham'),
('E06000042','Milton Keynes'),
('E06000043','Brighton and Hove'),
('E06000044','Portsmouth'),
('E06000045','Southampton'),
('E06000046','Isle of Wight'),
('E06000047','County Durham'),
('E06000048','Northumberland'),
('E06000049','Cheshire East'),
('E06000050','Cheshire West and Chester'),
('E06000051','Shropshire'),
('E06000052','Cornwall'),
('E06000053','Isles of Scilly'),
('E06000054','Wiltshire'),
('E06000055','Bedford'),
('E06000056','Central Bedfordshire'),
('E06000057','Northumberland'),
('E06000058','Bournemouth, Christchurch and Poole'),
('E06000059','Dorset (excluding Christchurch)'),
('E06000060','Buckinghamshire'),
('E06000061','North Northamptonshire'),
('E06000062','West Northamptonshire'),
('E08000001','Bolton'),
('E08000002','Bury'),
('E08000003','Manchester'),
('E08000004','Oldham'),
('E08000005','Rochdale'),
('E08000006','Salford'),
('E08000007','Stockport'),
('E08000008','Tameside'),
('E08000009','Trafford'),
('E08000010','Wigan'),
('E08000011','Knowsley'),
('E08000012','Liverpool'),
('E08000013','St. Helens'),
('E08000014','Sefton'),
('E08000015','Wirral'),
('E08000016','Barnsley'),
('E08000017','Doncaster'),
('E08000018','Rotherham'),
('E08000019','Sheffield'),
('E08000020','Gateshead'),
('E08000021','Newcastle upon Tyne'),
('E08000022','North Tyneside'),
('E08000023','South Tyneside'),
('E08000024','Sunderland'),
('E08000025','Birmingham'),
('E08000026','Coventry'),
('E08000027','Dudley'),
('E08000028','Sandwell'),
('E08000029','Solihull'),
('E08000030','Walsall'),
('E08000031','Wolverhampton'),
('E08000032','Bradford'),
('E08000033','Calderdale'),
('E08000034','Kirklees'),
('E08000035','Leeds'),
('E08000036','Wakefield'),
('E08000037','Gateshead'),
('E09000001','City of London'),
('E09000002','Barking and Dagenham'),
('E09000003','Barnet'),
('E09000004','Bexley'),
('E09000005','Brent'),
('E09000006','Bromley'),
('E09000007','Camden'),
('E09000008','Croydon'),
('E09000009','Ealing'),
('E09000010','Enfield'),
('E09000011','Greenwich'),
('E09000012','Hackney'),
('E09000013','Hammersmith and Fulham'),
('E09000014','Haringey'),
('E09000015','Harrow'),
('E09000016','Havering'),
('E09000017','Hillingdon'),
('E09000018','Hounslow'),
('E09000019','Islington'),
('E09000020','Kensington and Chelsea'),
('E09000021','Kingston upon Thames'),
('E09000022','Lambeth'),
('E09000023','Lewisham'),
('E09000024','Merton'),
('E09000025','Newham'),
('E09000026','Redbridge'),
('E09000027','Richmond upon Thames'),
('E09000028','Southwark'),
('E09000029','Sutton'),
('E09000030','Tower Hamlets'),
('E09000031','Waltham Forest'),
('E09000032','Wandsworth'),
('E09000033','Westminster'),
('E10000002','Buckinghamshire'),
('E10000003','Cambridgeshire'),
('E10000006','Cumbria'),
('E10000007','Derbyshire'),
('E10000008','Devon'),
('E10000009','Dorset'),
('E10000011','East Sussex'),
('E10000012','Essex'),
('E10000013','Gloucestershire'),
('E10000014','Hampshire'),
('E10000015','Hertfordshire'),
('E10000016','Kent'),
('E10000017','Lancashire'),
('E10000018','Leicestershire'),
('E10000019','Lincolnshire'),
('E10000020','Norfolk'),
('E10000021','Northamptonshire'),
('E10000023','North Yorkshire'),
('E10000024','Nottinghamshire'),
('E10000025','Oxfordshire'),
('E10000027','Somerset'),
('E10000028','Staffordshire'),
('E10000029','Suffolk'),
('E10000030','Surrey'),
('E10000031','Warwickshire'),
('E10000032','West Sussex'),
('E10000034','Worcestershire'),
('EHEATHROW','London Airport (Heathrow)'),
('S12000005','Clackmannanshire'),
('S12000006','Dumfries & Galloway'),
('S12000008','East Ayrshire'),
('S12000009','East Dunbartonshire'),
('S12000010','East Lothian'),
('S12000011','East Renfrewshire'),
('S12000013','Na h-Eileanan an Iar (Western Isles)'),
('S12000014','Falkirk'),
('S12000015','Fife'),
('S12000017','Highland'),
('S12000018','Inverclyde'),
('S12000019','Midlothian'),
('S12000020','Moray'),
('S12000021','North Ayrshire'),
('S12000023','Orkney Islands'),
('S12000024','Perth and Kinross'),
('S12000026','Scottish Borders'),
('S12000027','Shetland Islands'),
('S12000028','South Ayrshire'),
('S12000029','South Lanarkshire'),
('S12000030','Stirling'),
('S12000033','Aberdeen City'),
('S12000034','Aberdeenshire'),
('S12000035','Argyll & Bute'),
('S12000036','Edinburgh, City of'),
('S12000038','Renfrewshire'),
('S12000039','West Dunbartonshire'),
('S12000040','West Lothian'),
('S12000041','Angus'),
('S12000042','Dundee City'),
('S12000043','Glasgow City'),
('S12000044','North Lanarkshire'),
('S12000045','East Dunbartonshire'),
('S12000047','Fife'),
('S12000048','Perth and Kinross'),
('S12000049','Glasgow City'),
('S12000050','North Lanarkshire'),
('W06000001','Isle of Anglesey'),
('W06000002','Gwynedd'),
('W06000003','Conwy'),
('W06000004','Denbighshire'),
('W06000005','Flintshire'),
('W06000006','Wrexham'),
('W06000008','Ceredigion'),
('W06000009','Pembrokeshire'),
('W06000010','Carmarthenshire'),
('W06000011','Swansea'),
('W06000012','Neath Port Talbot'),
('W06000013','Bridgend'),
('W06000014','The Vale of Glamorgan'),
('W06000015','Cardiff'),
('W06000016','Rhondda, Cynon, Taff'),
('W06000018','Caerphilly'),
('W06000019','Blaenau Gwent'),
('W06000020','Torfaen'),
('W06000021','Monmouthshire'),
('W06000022','Newport'),
('W06000023','Powys'),
('W06000024','Merthyr Tydfil'),
('-1','Pre-2000 Records');

-- 1.	Accident Severity Trends by Vehicle Type
SELECT 
    r.vehicle_type_description AS vehicle_type, -- Get readable descriptions for vehicle types
    csr.casualty_serverity_description AS casualty_severity, -- Get readable descriptions for casualty severity
    COUNT(*) AS severity_count -- Count the number of occurrences for each combination
FROM 
    Vehicle v
JOIN 
    VehicleTypeReference r ON v.vehicle_type = r.vehicle_type -- Link the Vehicle table to the VehicleTypeReference table using vehicle_type
JOIN 
    Casualty c ON v.collision_index = c.collision_index -- Match vehicles with casualties using the collision_index
JOIN 
    CasualtySeverityReference csr ON c.casualty_severity = csr.casualty_serverity -- Link the Casualty table to the CasualtySeverityReference table using casualty_severity
WHERE 
    csr.casualty_serverity_description = 'Fatal' -- Filter results for serious casualties
GROUP BY 
    r.vehicle_type_description, -- Group results by vehicle type
    csr.casualty_serverity_description -- Group results by casualty severity
ORDER BY 
    severity_count DESC; -- Sort results by severity count in descending order

-- 2.	Casualty Age and Severity Correlation
SELECT 
    abc.age_band_of_casaualty_description AS age_band_of_casualty,  -- Readable descriptions for casualty age bands
    csr.casualty_serverity_description AS casualty_severity,       -- Readable descriptions for casualty severity
    COUNT(*) AS severity_count                                     -- Count of occurrences for each combination
FROM 
    Casualty c
JOIN 
    AgebandofcasualtyReference abc 
ON 
    c.age_band_of_casualty = abc.age_band_of_casaualty             -- Match Casualty table to age band reference
JOIN 
    CasualtySeverityReference csr 
ON 
    c.casualty_severity = csr.casualty_serverity                   -- Match Casualty table to casualty severity reference
WHERE csr.casualty_serverity_description = 'Serious'
GROUP BY 
    abc.age_band_of_casaualty_description, 
    csr.casualty_serverity_description
ORDER BY 
    severity_count DESC;                                          -- Sort by the highest severity count

-- 3.	Impact of Weather and Road Conditions
SELECT lc.light_conditions_description AS light_conditions, 
wc.weather_conditions_description AS weather_conditions,
COUNT(*) AS Impact_count
FROM collision c
JOIN 
light_conditionsreference lc ON c.light_conditions = lc.light_conditions
JOIN
weather_conditionsreference wc ON c.weather_conditions = wc.weather_conditions
GROUP BY light_conditions_description, weather_conditions_description
ORDER BY Impact_count DESC
; 

SELECT 
    wc.weather_conditions_description AS weather_condition,  -- Readable description of weather conditions
    -- lc.light_conditions_description AS light_condition,      -- Readable description of light conditions
    csr.casualty_serverity_description AS casualty_severity, -- Readable description of casualty severity
    COUNT(*) AS accident_count                              -- Count of accidents for each combination
FROM 
    Collision c
JOIN 
    weather_conditionsReference wc
 ON 
	c.weather_conditions = wc.weather_conditions            -- Match Collision table to weather reference
-- JOIN 
    -- light_conditionsReference lc 
-- ON 
    -- c.light_conditions = lc.light_conditions                -- Match Collision table to light conditions reference
JOIN 
    Casualty ca 
ON 
	c.collision_index = ca.collision_index                  -- Link Collision table to Casualty table
JOIN 
    CasualtySeverityReference csr
ON 
    ca.casualty_severity = csr.casualty_serverity           -- Match Casualty table to casualty severity reference
WHERE csr.casualty_serverity_description = 'Serious'
GROUP BY 
    wc.weather_conditions_description, 
    -- lc.light_conditions_description, 
    csr.casualty_serverity_description                      -- Group by weather, light, and severity
ORDER BY 
    accident_count DESC;                                    -- Sort by highest accident count

-- 4.	Casualty and Collision Hotspots
SELECT 
	local_authority_highway,
    csr.casualty_serverity_description AS casualty_severity,
    COUNT(*) AS accident_count
FROM 
    Collision c
JOIN 
    Casualty ca ON c.collision_index = ca.collision_index
JOIN 
    CasualtySeverityReference csr ON ca.casualty_severity = csr.casualty_serverity
GROUP BY 
    local_authority_highway,
    csr.casualty_serverity_description
ORDER BY 
    accident_count DESC;
    
-- 5.	Collision Patterns by Time and Day of the Week
SELECT 
    dor.day_of_week_description AS day_of_week, 
    csr.casualty_serverity_description AS casualty_severity,
    COUNT(*) AS accident_count
FROM 
    Collision c
JOIN 
    Casualty ca ON c.collision_index = ca.collision_index
JOIN 
    CasualtySeverityReference csr ON ca.casualty_severity = csr.casualty_serverity
JOIN 
    day_of_weekReference dor ON c.day_of_week = dor.day_of_week
GROUP BY 
    dor.day_of_week_description, csr.casualty_serverity_description
ORDER BY 
    accident_count DESC;
    
-- 6.	Driver Behavior and Collision Outcomes
SELECT
    sdr.sex_of_drivery_description AS sex_of_driver,
    csr.casualty_serverity_description AS casualty_severity,
    COUNT(*) AS accident_count
FROM 
    Collision c
JOIN 
    Casualty ca ON c.collision_index = ca.collision_index
JOIN 
    Vehicle v ON c.collision_index = v.collision_index
JOIN 
    CasualtySeverityReference csr ON ca.casualty_severity = csr.casualty_serverity
JOIN 
    sex_of_driveryReference sdr ON v.sex_of_driver = sdr.sex_of_drivery
GROUP BY 
    sdr.sex_of_drivery_description, 
    csr.casualty_serverity_description
ORDER BY 
    accident_count DESC;






































DESCRIBE Collision;
DESCRIBE CasualtySeverityReference;





