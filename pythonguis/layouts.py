import PySimpleGUI as pg


menu_def = [['Actions', ['Register Employee','Take Attendance', 'Admin Login']],
            ['Edit', ['Copy', 'Paste', 'Delete']],
            ['Help', 'About...']]
layout = [[pg.Menu(menu_def)],[pg.Text(text="Attendance Software")]]

another_layout =[[pg.Menu(menu_def)],[pg.Button("Register Employee"),pg.Button("Take Attendance")],[pg.Button("Admin Login")],]

register_layout = [[pg.Menu(menu_def)],[pg.Text("Full Name",size=(15,1),),pg.Input(key="name")],
                   [pg.Text("username",size=(15,1)),pg.Input(key="username")],
                   [pg.Text("email",size=(15,1)),pg.Input(key="email")],
                   [pg.Text("phone number",size=(15,1)),pg.Input(key="number")],
                   [pg.Text("address",size=(15,1)),pg.Input(key="address")],
                   [pg.Text("Pan no",size=(15,1)),pg.Input(key="panno")],
                   [pg.Button("Next"),pg.Button("Exit")],
                   ]

admin_home =[[pg.Menu(menu_def)],[pg.Button("Designation"), pg.Button("Payroll")], [pg.Button("Statistics"),pg.Button("Applications")]]

designation_layout =[[pg.Menu(menu_def)],[pg.Button("Add Designation"), pg.Button("View Designation")]]
statistic_layout =[[pg.Menu(menu_def)],[pg.Button("View Statistics")]]
payroll_layout =[[pg.Menu(menu_def)],[pg.Button("Add Payroll"), pg.Button("View Payrolls")]]

attendance_layout = [[pg.Menu(menu_def)],[pg.Text("Name"),pg.Input(key="name")],[pg.Button("Check"),pg.Button("Home")]]

login_layout = [[pg.Menu(menu_def)],
    [pg.Text("User Id",size=(15,1)),pg.Input(key="username")],
    [pg.Text("Password",size=(15,1)),pg.Input(key="password",password_char="*")],
    [pg.Button("Login"),pg.Button("Exit")]
    ]

error_layout = [[pg.Menu(menu_def)],[pg.Text(text="Error occurred")],[pg.Button("Back"), pg.Button('Home')]]
success_layout = [[pg.Menu(menu_def)],[pg.Text(text="Success")],[pg.Button('OK')]]
