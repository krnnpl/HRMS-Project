

# # create tables
# cursor.execute("CREATE TABLE Designations (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(255), salary FLOAT)")
# cursor.execute("CREATE TABLE Employees (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(255), username VARCHAR(255), email VARCHAR(255), number VARCHAR(255), address VARCHAR(255), panno VARCHAR(255), password VARCHAR(255), is_admin BOOLEAN, designation_id INT NOT NULL, FOREIGN KEY (designation_id) REFERENCES Designations(id))")
# cursor.execute("CREATE TABLE Attendances (id INT AUTO_INCREMENT PRIMARY KEY, name_id INT NOT NULL, FOREIGN KEY (name_id) REFERENCES Employees(id), date DATE, time TIME)")
# cursor.execute("CREATE TABLE Payrolls (id INT AUTO_INCREMENT PRIMARY KEY, name_id INT NOT NULL, FOREIGN KEY (name_id) REFERENCES Employees(id), year BIGINT, month VARCHAR(255), salary FLOAT NULL, overtime FLOAT, payroll_deduction FLOAT, gross_salary FLOAT, tax FLOAT, tax_amt FLOAT, net_salary FLOAT)")
# cursor.execute("CREATE TABLE Applications (id INT AUTO_INCREMENT PRIMARY KEY, type ENUM('Leave Request','Suggestions','Allowance'), title VARCHAR(255), reason VARCHAR(500), start_date DATE, days ENUM('1','2','3','More'), status ENUM('Approved','Declined','Pending'), employee_id INT NOT NULL, FOREIGN KEY (employee_id) REFERENCES Employees(id))")


# employees query
sqlsave = "INSERT INTO Employees (name, username,email,number,address, panno, password,is_admin,designation_id) VALUES (%s,%s,%s,%s,%s,%s,'',False,1)"
selemp = "SELECT * FROM Employees WHERE username=%s"
updpass = "UPDATE Employees SET password=%s, designation_id=%s WHERE name=%s"
check_login = "SELECT * FROM Employees WHERE username = %s AND password = %s AND is_admin= true"
sqlcheck = "SELECT * from Employees"

# attendance query
check = "SELECT name, date, time FROM Attendances LEFT JOIN employees ON attendances.name_id = employees.id; "
attendancesave = "INSERT INTO Attendances (name_id, date, time) VALUES (%s,%s,%s)"

#designation query
fetch_designations = "SELECT * FROM Designations"
designation_add = "INSERT INTO Designations (name, salary) VALUES (%s,%s)"

#payrolls query
fetch_payrolls = "SELECT * FROM Payrolls"
fetch_salary = "SELECT Designations.salary FROM Employees, Payrolls, Designations where Payrolls.name_id = Employees.id AND Employees.designation_id = Designations.id AND Payrolls.name_id = %s"
payroll_add = "INSERT INTO Payrolls (name_id,year,month, salary, overtime,payroll_deduction,gross_salary,tax,tax_amt,net_salary) VALUES (%s,%s,%s,0,%s,%s,0,%s,0,0)"
updsalary = "UPDATE Payrolls SET salary=%s, gross_salary=%s, tax_amt=%s, net_salary=%s WHERE name_id=%s"

#applications query
fetch_applications = "SELECT * FROM Applications"
filter_applications = "SELECT * FROM Applications WHERE status=%s"
update_application = "UPDATE Applications SET status=%s WHERE id=%s"



