from backend.serializers import EmployeeSerializer, DesignationSerializer, AttendanceSerializer, PayrollSerializer, ApplicationSerializer
from rest_framework.response import Response
from rest_framework.decorators import api_view
from rest_framework import status,permissions
from backend.models import Employee, Designation, Attendance, Payroll, Application
from django.contrib.auth import login
from rest_framework.authtoken.serializers import AuthTokenSerializer
from knox.views import LoginView as KnoxLoginView

from backend.models import Company
from backend.serializers import CompanySerializer

# Create your views here.
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


@api_view(['GET'])
def employees(request):
    if request.method=='GET':
        queryset = Employee.objects.all()
        serializer = EmployeeSerializer(queryset,many=True)
        return Response({"message" : serializer.data})

@api_view(['GET'])
def companys(request):
    if request.method=='GET':
        queryset = Company.objects.first()
        serializer = CompanySerializer(queryset)
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
    
