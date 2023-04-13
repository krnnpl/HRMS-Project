import PySimpleGUI as pg
import cv2, os, numpy, datetime
import random, string, re
from queries import *
from constants import *
from layouts import *
from db_conn import create_connection

mydb = create_connection()
mycursor = mydb.cursor()


window = pg.Window("HRMS", another_layout ,size=(300,300))
#  Create 
# # mycursor.execute("CREATE TABLE Designations (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(255), salary FLOAT)")
# # mycursor.execute("CREATE TABLE Employees (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(255), username VARCHAR(255), email VARCHAR(255), number VARCHAR(255), address VARCHAR(255), panno VARCHAR(255), password VARCHAR(255), is_admin BOOLEAN, designation_id INT NOT NULL, FOREIGN KEY (designation_id) REFERENCES Designations(id))")
# # mycursor.execute("CREATE TABLE Attendances (id INT AUTO_INCREMENT PRIMARY KEY, name_id INT NOT NULL, FOREIGN KEY (name_id) REFERENCES Employees(id), date DATE, time TIME)")
# # mycursor.execute("CREATE TABLE Payrolls (id INT AUTO_INCREMENT PRIMARY KEY, name_id INT NOT NULL, FOREIGN KEY (name_id) REFERENCES Employees(id), year BIGINT, month VARCHAR(255), salary FLOAT NULL, overtime FLOAT, payroll_deduction FLOAT, gross_salary FLOAT, tax FLOAT, tax_amt FLOAT, net_salary FLOAT)")
# # mycursor.execute("CREATE TABLE Applications (id INT AUTO_INCREMENT PRIMARY KEY, type ENUM('Leave Request','Suggestions','Allowance'), title VARCHAR(255), reason VARCHAR(500), start_date DATE, days ENUM('1','2','3','More'), status ENUM('Approved','Declined','Pending'), employee_id INT NOT NULL, FOREIGN KEY (employee_id) REFERENCES Employees(id))")



while True:
    event, values = window.read()
    if event == pg.WIN_CLOSED or event == 'Exit':
      window.close()
      break

#  ### HOME PAGE ### #
    if event == "Admin Login":
        window = pg.Window("Admin Login", login_layout ,size=(300,300))

    if event == "Register Employee":
        window = pg.Window("Register Employee", register_layout ,size=(300,300))
   
    if event == "Login":
        username = values['username']
        password = values['password']
        credentials = (username,password,)
        mycursor.execute(check_login,credentials)
        row = mycursor.fetchone()
        if row:
            window = pg.Window("Home", admin_home ,size=(300,300))
        else:
            pg.popup("Login fail")

    if event == "Next":
        name = values['name'].capitalize()
        username = values['username']
        email = values['email']
        number = values['number']
        address = values['address']
        panno = values['panno']
        e1 = (name,username,email,number, address, panno)
        mycursor.execute(sqlsave,e1)
        mydb.commit()

        if not name or not username or not email or not number or not address or not panno:
            pg.popup("Please Enter all the details")
        elif len(number) != 10 or len(panno) !=10:
            pg.popup("Number Format Error")
        elif not re.match(email_format, email):
            pg.popup('Invalid email address')
        else:
            path = os.path.join(datasets,name)
            if not os.path.isdir(path):
                os.mkdir(path)
            (width, height) = (130, 100)

            count = 0
            while count < 30:
                (_, cap_data) = video_cap.read()
                col = cv2.cvtColor(cap_data, cv2.COLOR_BGR2GRAY)
                faces = face_cap.detectMultiScale(col, 1.3, 4)
                for (x, y, w, h) in faces:
                    cv2.rectangle(cap_data, (x, y), (x + w, y + h), (255, 0, 0), 2)
                    face = col[y : y + h, x : x + w]
                    face_resize = cv2.resize(face, (width, height))
                    cv2.imwrite("% s/% s.png" % (path, count), face_resize)
                count += 1

                cv2.imshow(f"Reading your image ----- {name}", cap_data)
                if cv2.waitKey(100) == ord("z"):
                    break
            cv2.destroyAllWindows()
            mycursor.execute(fetch_designations)
            designation_choices = tuple(f"{row[0]} - {row[1]}" for row in mycursor.fetchall())
            password_layout = [[pg.Text("Type Password",size=(15,1)),pg.Input(key="pass1",password_char="*")],
                   [pg.Text("Retype Password",size=(15,1)),pg.Input(key="pass2",password_char="*")],
                   [pg.Text("Designation",size=(15,1)),pg.Combo(designation_choices, key='desg')],
                   [pg.Input(key="gen",size=(20,1),readonly=True, background_color= "white",text_color="white"), pg.Button("GeneratePass")],
                   [pg.Button("Set Password"),pg.Button("Exit")],
                   ]
            window = pg.Window("Set Password",password_layout,size=(300,300))

    if event == "Take Attendance":
        window = pg.Window("Register Employee", attendance_layout ,size=(300,300))

    if event == "Check":
        print("Checking")
        name = values['name'].capitalize()
        if not name:
            pg.popup("Please Enter all the details")
        else:
            employee = (name,)
            mycursor.execute(selemp,employee)
            myresult = mycursor.fetchone()
            if myresult == []:
                pg.popup("Can't find employee")
            else:
                name_id = myresult[0]
                pg.popup("Recognizing Face Please Be in sufficient Lights...",auto_close=True, auto_close_duration=5,)
                # Create a list of images and a list of corresponding names
                (images, labels, names, id) = ([], [], {}, 0)
                for (subdirs, dirs, files) in os.walk(datasets):
                    for subdir in dirs:
                        names[id] = subdir
                        subjectpath = os.path.join(datasets, subdir)
                        for filename in os.listdir(subjectpath):
                            path = subjectpath + "/" + filename
                            label = id
                            images.append(cv2.imread(path, 0))
                            labels.append(int(label))
                        id += 1
                (width, height) = (130, 100)

                (images, labels) = [numpy.array(series) for series in [images, labels]]

                model = cv2.face.LBPHFaceRecognizer_create()
                model.train(images, labels)
                (_, cap_data) = video_cap.read()
                col = cv2.cvtColor(cap_data, cv2.COLOR_BGR2GRAY)
                faces = face_cap.detectMultiScale(col, 1.3, 5)
                for (x, y, w, h) in faces:
                    cv2.rectangle(cap_data, (x, y), (x + w, y + h), (255, 0, 0), 2)
                    face = col[y : y + h, x : x + w]
                    face_resize = cv2.resize(face, (width, height))
                    prediction = model.predict(face_resize)
                    cv2.rectangle(cap_data, (x, y), (x + w, y + h), (0, 255, 0), 3)
                    if prediction[1] < 500:
                        cv2.putText(
                            cap_data,
                            "% s - %.0f" % (names[prediction[0]], prediction[1]),
                            (x - 10, y - 10),
                            cv2.FONT_HERSHEY_PLAIN,
                            2,
                            (255, 255, 255),
                        )
                    else:
                        cv2.putText(
                            cap_data,
                            "not recognized",
                            (x - 10, y - 10),
                            cv2.FONT_HERSHEY_PLAIN,
                            1,
                            (255, 0, 0),
                        )
                
                    if names[prediction[0]] == name and prediction[1] > 50.0:
                        print("Match")
                        now = datetime.datetime.now()
                        date = now.strftime("%Y-%m-%d")
                        time = now.strftime("%H:%M:%S")
                        atnd = (name_id,date,time)
                        mycursor.execute(attendancesave,atnd)
                        mydb.commit()
                        window = pg.Window("Your Attendance have been recorded",success_layout, size=(300,300))
                    else:
                        window = pg.Window("Error Occurred", error_layout,size=(300,300))

    if event == "GeneratePass":
        characters = string.ascii_letters + string.digits + string.punctuation
        password = ''.join(random.choice(characters) for i in range(10))
        window["gen"].update(password)

    if event == "Home":
        window = pg.Window("HRMS", another_layout ,size=(300,300))

    if event == "Set Password":
            pass1 = values['pass1']
            pass2 = values['pass2']
            desg = int(values['desg'].split("-")[0])

            if not pass1 or not pass2 or not desg:
                pg.popup("Error")
            elif len(pass1) <10:
                pg.popup("length error")
            elif len(pass1) != len(pass2):
                pg.popup("length error")
            elif pass1 != pass2:
                pg.popup("Password do not match error")
            else:
                password = pass1
                designation = desg
                emp = (name,)
                mycursor.execute(selemp, emp)
                row = mycursor.fetchone()
                if row:
                    passupd = (password, designation, name)
                    mycursor.execute(updpass,passupd)
                    mydb.commit()
                    pg.popup("Employee registered successfully")
                    

#  ### HOME PAGE END ### #

#  ### Designation ### #

    if event == "Designation":
        window = pg.Window("Designation", designation_layout ,size=(300,300))

    if event == "Add Designation":
        add_designation = [[pg.Text("Designation Name"),pg.Input(key = "desg")],[pg.Text("Salary"),pg.Input(key = "salary")],[pg.Button("Designation Submit")]]
        window = pg.Window("Designation", add_designation ,size=(300,300))

    if event =="Designation Submit":
        desg_name = values['desg']
        salary = values['salary']

        if desg_name == '' or salary =='':
            pg.popup("please enter all the values")
        else:
            data = (desg_name,salary)
            mycursor.execute(designation_add,data)
            mydb.commit()
            pg.popup("Designation added successfully")

    if event == "View Designation":
        mycursor.execute(fetch_designations)
        data = mycursor.fetchall()
        view_designation =[[pg.Table(values=data, headings=[i[0] for i in mycursor.description], max_col_width=50,
                    auto_size_columns=True, justification='center', num_rows=min(len(data), 20))]]
        window = pg.Window("Designation", view_designation ,size=(300,300))  

#  ### Designation ### #

    if event == "Payroll":
        window = pg.Window("Payroll", payroll_layout ,size=(300,300))

    if event == "Add Payroll":
        years = [str(year) for year in range(1900, 2101)]
        months = ['Baishakh','Jestha','Ashadh','Shrawan','Bhadra','Ashoj','Karthik','Mangshir','Poush','Magh','Falgun','Chaitra']
        mycursor.execute(sqlcheck)
        employee_choices = tuple(f"{row[0]} - {row[1]}" for row in mycursor.fetchall())
        add_payroll = [
            [pg.Text("Employee ID")],
            [pg.Text("Year"),pg.Combo(values= years, size=(10,1),key = "year")],
            [pg.Text("Month"),pg.Combo(values= months, size=(10,1),key = "month")],
            [pg.Text("Employee"),pg.Combo(values= employee_choices, size=(10,1),key = "emp")],
            [pg.Text("overtime"),pg.Input(key = "overtime")],
            [pg.Text("payroll_deduction"),pg.Input(key = "payroll_deduction")],
            [pg.Text("Tax %"),pg.Text("15",key = "tax_percent")], #fixed
            [pg.Button("Payroll Submit")]
        ]
        window = pg.Window("Payroll", add_payroll ,size=(300,300))

    if event == "Payroll Submit":
        name_id = int(values['emp'].split("-")[0])
        year = values['year']
        month = values['month']
        overtime = float(values['overtime'])
        payroll_deduction = float(values['payroll_deduction'])
        tax_percent = 0.15
        pay = (name_id,year,month,overtime,payroll_deduction,tax_percent)
        mycursor.execute(payroll_add,pay)
        mydb.commit()
        mycursor.execute(fetch_salary,(name_id,))
        result = mycursor.fetchall()
        salary = result[0][0]
        gross_salary = salary + overtime - payroll_deduction
        tax_amt = gross_salary * tax_percent
        net_salary = gross_salary - tax_amt
        upd_sal = (salary,gross_salary,tax_amt,net_salary,name_id)
        mycursor.execute(updsalary,upd_sal)
        mydb.commit()
        pg.popup("Payroll Added successfully")
      
    if event == "View Payrolls":
        mycursor.execute(fetch_payrolls)
        data = mycursor.fetchall()
        view_payroll =[[pg.Table(values=data, headings=[i[0] for i in mycursor.description], max_col_width=50,
                    auto_size_columns=True, justification='center', num_rows=min(len(data), 20))]]
        window = pg.Window("Payrolls", view_payroll ,size=(300,300))  

        # end payrolls #

    if event == "Statistics":
        mycursor.execute(check)
        data = mycursor.fetchall()
        statistics_layout = [[pg.Table(values=data, headings=[i[0] for i in mycursor.description], max_col_width=50,
                     auto_size_columns=True, justification='center', num_rows=min(len(data), 20))]]

        window = pg.Window("Statistics", statistics_layout ,size=(300,300))

                    
    if event == "Applications":
        mycursor.execute(fetch_applications)
        data = mycursor.fetchall()
        headings = [i[0] for i in mycursor.description]
        id_choices = [i[0] for i in data]
        application_layout =[[pg.Text("All Applications"),pg.Combo(status_options,enable_events=True, default_value='Choose Status',key='stat'),pg.Button("Filter")],[pg.Table(key='-TABLE-', values=data, headings=headings, max_col_width=50,
                    auto_size_columns=True, justification='center', num_rows=min(len(data), 20))],[pg.Text("Select an Application to update its status")],[pg.Combo(id_choices,enable_events=True,default_value = 'Choose ID', size=(20,1), key='id_choice'),pg.Combo(status_options,enable_events=True,default_value = 'Choose status', size=(20,1), key='status_choice'), pg.Button("Update Status", size=(20,1),)]]
        window = pg.Window("Applications", application_layout ,size=(900,300))

    if event == "Filter":
        status = values['stat']
        mycursor.execute(filter_applications,(status,))
        filtered_data = mycursor.fetchall()
        table = window["-TABLE-"]
        table.update(values=filtered_data)

    if event =="Update Status":
        app_id = values['id_choice']
        new_status = values['status_choice']
        new_data = (new_status,app_id)
        mycursor.execute(update_application,new_data)
        mydb.commit()
        mycursor.execute(fetch_applications)
        data = mycursor.fetchall()
        headings = [i[0] for i in mycursor.description]
        table = window["-TABLE-"]
        table.update(values=data)
        pg.popup("Status Updated Successfully")



def generate_password(length):
    characters = string.ascii_letters + string.digits + string.punctuation
    password = ''.join(random.choice(characters) for i in range(length))
    return password
