# Name: Sahib Bajwa

# Question 1
CREATE SCHEMA ClassAssignment;

# Question 2
CREATE TABLE Project (
  `project_num` INT(10) NOT NULL PRIMARY KEY,
  `project_code` CHAR(4),
  `project_title` VARCHAR(45),
  `first_name` VARCHAR(45),
  `last_name` VARCHAR(45),
  `project_budget` DECIMAL(5,2)
  );

#desc Project;

# Question 3
ALTER TABLE Project MODIFY COLUMN project_num INT(10) AUTO_INCREMENT;
ALTER TABLE Project AUTO_INCREMENT = 10;

#desc Project;

# Question 4
ALTER TABLE Project MODIFY COLUMN project_budget DECIMAL(10,2);

#desc Project;

# Question 5
INSERT INTO Project (project_code, project_title, first_name, last_name, project_budget)
VALUES 
	('PC01', 'DIA', 'John', 'Smith', 10000.99),
    ('PC02', 'CHF', 'Tim', 'Cook', 12000.50),
    ('PC03', 'AST', 'Rhonda', 'Smith', 8000.40);

#SELECT * FROM Project;

# Question 6
CREATE TABLE PayRoll (
  `employee_num` INT(10) PRIMARY KEY AUTO_INCREMENT,
  `job_id` INT(10) NOT NULL,
  `job_desc` VARCHAR(40),
  `emp_pay` DECIMAL(10,2)
  );

#desc PayRoll;

# Question 7
ALTER TABLE PayRoll ADD CONSTRAINT ValGrt CHECK (emp_pay > 10000);
ALTER TABLE PayRoll ALTER job_desc SET DEFAULT 'Data Analyst';
ALTER TABLE PayRoll ADD pay_date DATE AFTER job_desc;

#desc PayRoll;

# Question 8
ALTER TABLE PayRoll ADD CONSTRAINT FK_A_B FOREIGN KEY (job_id) REFERENCES Project (project_num);

# Question 9
INSERT INTO PayRoll (job_id, pay_date, emp_pay)
VALUES 
	(10, curdate(), 12000.99),
    (11, curdate(), 14000.99),
    (12, curdate(), 16000.99);
    
#SELECT * FROM PayRoll;

# Question 10
UPDATE PayRoll SET emp_pay = (emp_pay + (emp_pay * 0.1)) WHERE employee_num = 2;

#SELECT * FROM PayRoll;

# Question 11
CREATE TABLE Project_backup (
 `project_num` INT(10) NOT NULL PRIMARY KEY,
  `project_code` CHAR(4),
  `project_title` VARCHAR(45),
  `first_name` VARCHAR(45),
  `last_name` VARCHAR(45),
  `project_budget` DECIMAL(5,2)
  );
  
ALTER TABLE Project_backup MODIFY COLUMN project_num INT(10) AUTO_INCREMENT;
ALTER TABLE Project_backup AUTO_INCREMENT = 10;
ALTER TABLE Project_backup MODIFY COLUMN project_budget DECIMAL(10,2);

INSERT INTO Project_backup SELECT project_num, project_code, project_title, first_name, last_name, project_budget FROM Project WHERE last_name = 'Smith';

#Select * FROM Project_backup; Select * From Project;

# Question 12
CREATE VIEW PayRoll_View AS
	Select job_id, job_desc, pay_date FROM PayRoll WHERE job_id > 10;
    
#Select * FROM PayRoll_View; Select * FROM PayRoll;

# Question 13
CREATE INDEX IX_Name ON PayRoll (pay_date);

#SHOW INDEX FROM PayRoll;

# Question 14
TRUNCATE project_backup;

#Select * FROM Project_backup; Select * FROM Project;

# Question 15
DELETE FROM Project WHERE project_num = 10;

# This script fails because we cannot delete the row from the parent table while there is a reference to the row in the child table.
# We need either remove that row in the child table OR temporarily stop the foreign key check while we delete the row in the parent table.

# Question 16
SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM Project WHERE project_num = 10;
SET FOREIGN_KEY_CHECKS = 1;

#SELECT * FROM Project;