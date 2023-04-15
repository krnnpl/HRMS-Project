from rest_framework import serializers
from backend.models import Employee, Designation, Attendance, Payroll, Application
from django.core.exceptions import ObjectDoesNotExist

from backend.models import Company


class EmployeeSerializer(serializers.ModelSerializer):
    class Meta:
        model = Employee
        fields ='__all__'
        depth = 2
    def validate(self, data):
        username = data.get("username")
        password = data.get("password")
        if username is None or password is None:
            raise serializers.ValidationError(
                "Both username and password are required to log in."
            )
        try:
            employee = Employee.objects.get(username=username)
        except ObjectDoesNotExist:
            raise serializers.ValidationError(
                "No employee found with the provided username."
            )
        if not employee.password == password:
            raise serializers.ValidationError("Incorrect password.")
        data["employee"] = employee
        return data

class CompanySerializer(serializers.ModelSerializer):
    class Meta:
        model = Company
        fields ='__all__'
        depth = 1

class DesignationSerializer(serializers.ModelSerializer):
    class Meta:
        model = Designation
        fields ='__all__'
        depth = 1

class AttendanceSerializer(serializers.ModelSerializer):
    class Meta:
        model = Attendance
        fields ='__all__'
        depth = 2

class PayrollSerializer(serializers.ModelSerializer):
    class Meta:
        model = Payroll
        fields ='__all__'
        depth = 2

class ApplicationSerializer(serializers.ModelSerializer):
    employee_id = serializers.PrimaryKeyRelatedField(queryset=Employee.objects.all())

    class Meta:
        model = Application
        fields = '__all__'
        depth = 2
    def create(self, validated_data):
        employee_id = validated_data.pop('employee_id')
        validated_data['employee_id'] = employee_id.pk  # get the primary key value
        return Application.objects.create(**validated_data)