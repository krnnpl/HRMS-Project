from django.db import models

# Create your models here.
class Designation(models.Model):
    # id = models.IntegerField()
    name = models.CharField(max_length=100)
    salary = models.FloatField()
    class Meta:
        db_table = 'Designations'

class Employee(models.Model):
    # id = models.IntegerField(primary_key=True)
    name = models.CharField(max_length=100)
    username = models.CharField(max_length=100)
    email = models.CharField(max_length=100)
    number = models.CharField(max_length=100)
    address = models.CharField(max_length=100)
    panno = models.CharField(max_length=100)
    password = models.CharField(max_length=100)
    is_admin = models.BooleanField()
    designation= models.ForeignKey(Designation,on_delete=models.CASCADE)
    
    class Meta:
        db_table = 'Employees'
    def __str__(self):
        return self.name

class Attendance(models.Model):
    name = models.ForeignKey(Employee,on_delete=models.CASCADE)
    date = models.CharField(max_length=100)
    time = models.CharField(max_length=100)
    class Meta:
        db_table = 'Attendances'

class Payroll(models.Model):
    name = models.ForeignKey(Employee,on_delete=models.CASCADE)
    year = models.CharField(max_length=100)
    month = models.CharField(max_length=100)
    salary = models.FloatField()
    overtime = models.FloatField()
    payroll_deduction = models.FloatField()
    gross_salary = models.FloatField()
    tax = models.FloatField()
    tax_amt = models.FloatField()
    net_salary = models.FloatField()
    class Meta:
        db_table = 'Payrolls'


class Application(models.Model):
    type = models.CharField(max_length=100)
    title = models.CharField(max_length=250)
    reason = models.CharField(max_length=250)
    start_date = models.DateField()
    days = models.IntegerField()
    status = models.CharField(max_length=100)
    employee = models.ForeignKey(Employee,on_delete=models.CASCADE)
    class Meta:
        db_table = 'Applications'