from django.shortcuts import render
from backend.serializers import EmployeeSerializer, DesignationSerializer, AttendanceSerializer, PayrollSerializer, ApplicationSerializer
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.decorators import api_view
from rest_framework import status
import json

from backend.models import Employee, Designation, Attendance, Payroll, Application

# Create your views here.

# @api_view(['POST'])
# def login(request):
#     if request.method=='POST':
#         userid = request.data.get('userid')
#         password = request.data.get('password')
#         data = (userid,password)
#         serializer = EmployeeSerializer(data)
#         if serializer.validate(data):
#             return Response({"id":"id here","message": serializer.data})
#         else:
#             return Response({"error": "Invalid userid or password"}, status=status.HTTP_401_UNAUTHORIZED)


        # try:
        #     employee = Employee.objects.get(name=name,password= password)
        #     print(employee)
        # except Employee.DoesNotExist:
        #     return Response({"error": "Invalid userid or password"}, status=status.HTTP_401_UNAUTHORIZED)
        # if (password == employee.password):
        #     serializer = EmployeeSerializer(name)
        #     return Response(serializer.data)
        # else:
        #     return Response({"error": "Invalid userid or password"}, status=status.HTTP_401_UNAUTHORIZED)


from django.contrib.auth import login

from rest_framework import permissions
from rest_framework.authtoken.serializers import AuthTokenSerializer
from knox.views import LoginView as KnoxLoginView

class LoginAPI(KnoxLoginView):
    permission_classes = (permissions.AllowAny,)
    def post(self, request, format=None):
        serializer = AuthTokenSerializer(data=request.data)
        print(serializer)
        serializer.is_valid(raise_exception=True)
        username = serializer.validated_data['username']
        print(username)
        login(request, username)
        return super(LoginAPI, self).post(request, format=None)
    
# from django.contrib.auth import authenticate
# # from user_rl.renderers import UserRenderer
# from rest_framework_simplejwt.tokens import RefreshToken
# from rest_framework.permissions import IsAuthenticated
# from rest_framework.permissions import IsAdminUser, IsAuthenticated
# from datetime import datetime
# # from user_rl.models import User
# # from rest_framework import viewsets
# # from user_rl.models import User


# def get_tokens_for_employee(hrmsuser):
#     refresh = RefreshToken.for_user(hrmsuser)
#     time_stamp = datetime.now()
#     return {
#         'refresh': str(refresh),
#         'access': str(refresh.access_token),
#         'time_stamp':str(time_stamp)
#     }

# class EmployeeLoginView(APIView):
#     # renderer_classes = [UserRenderer]
#     # @action(detail= False)
#     def post(self, request,format=None):
#         serializer = EmployeeLoginSerializer(data=request.data)
#         serializer.is_valid(raise_exception=True)
#         userid = serializer.data.get('userid')
#         password = serializer.data.get('password')
#         print(userid,password)
#         employee = authenticate(userid=userid, password=password)
#         print(employee)
#         if employee is not None:
#             token = get_tokens_for_employee(employee)
#             return Response({'token': token,'message':'login success'}, status= status.HTTP_201_CREATED)
#         else:
#             return Response({'errors':{'non_field_errors':['Email or Password is not Valid']}}, status=status.HTTP_404_NOT_FOUND)




@api_view(['GET'])
def employees(request):
    if request.method=='GET':
        queryset = Employee.objects.all()
        serializer = EmployeeSerializer(queryset,many=True)
        return Response({"message" : serializer.data})


@api_view(['GET'])
def viewEmployee(request,pk):
    employee = Employee.objects.get(id=pk)
    serializer = EmployeeSerializer(employee,many = False)
    return Response({"message" : serializer.data})


@api_view(['GET'])
def designations(request):
    if request.method=='GET':
        queryset = Designation.objects.all()
        serializer = DesignationSerializer(queryset,many=True)
        return Response({"message" : serializer.data})
    
@api_view(['GET'])
def attendances(request):
    if request.method=='GET':
        queryset = Attendance.objects.all()
        serializer = AttendanceSerializer(queryset,many=True)
        return Response({"message" : serializer.data})
    
@api_view(['GET'])
def employeeattendance(request,name_id):
    if request.method=='GET':
        queryset = Attendance.objects.filter(name=name_id)
        serializer = AttendanceSerializer(queryset,many=True)
        return Response({"message" : serializer.data})
    
@api_view(['GET'])
def payrolls(request):
    if request.method=='GET':
        queryset = Payroll.objects.all()
        serializer = PayrollSerializer(queryset,many=True)
        return Response({"message" : serializer.data})
    

@api_view(['GET'])
def employeepayroll(request,name_id):
    if request.method=='GET':
        queryset = Payroll.objects.filter(name=name_id)
        serializer = PayrollSerializer(queryset,many=True)
        return Response({"message" : serializer.data})

    
@api_view(['GET','POST'])
def applications(request):
    if request.method=='GET':
        queryset = Application.objects.all()
        serializer = ApplicationSerializer(queryset,many=True)
        return Response({"message" : serializer.data})
    elif request.method == 'POST':
        print(request.data)
        serializer = ApplicationSerializer(data=request.data)

        print(serializer)
        if serializer.is_valid():
            employee_id = serializer.validated_data['employee_id'].id
            if not Employee.objects.filter(id=employee_id).exists():
                return Response({'error': f'Employee with ID {employee_id} does not exist.'}, status=400)
        
            # Create the leave request object and save it to the database   
            serializer.save()
            return Response({"message": serializer.data}, status=status.HTTP_201_CREATED)
        return Response({"message": serializer.errors}, status=status.HTTP_400_BAD_REQUEST)
        
@api_view(['GET'])
def employeeapplication(request,pk):
    if request.method=='GET':
        queryset = Application.objects.filter(employee_id=pk)
        serializer = ApplicationSerializer(queryset,many=True)
        return Response({"message" : serializer.data})
    
