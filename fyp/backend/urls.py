from django.urls import path, include
from . import views
from rest_framework import routers
# from backend.views import ApplicationView
from knox import views as knox_views
from .views import LoginAPI


urlpatterns = [
    path('company/', views.companys, name='company'),
    # all employess
    path('employees/', views.employees, name='employee'),
    # specific employee
    path('employee/<int:pk>/', views.viewEmployee, name='employee-view'),
    # all designations
    path('designations/', views.designations, name='designation'),
    # all attendance
    path('attendances/', views.attendances, name='attendance'),
    # specific attendance of employee
    path('employeeattendance/<int:name_id>/', views.employeeattendance, name='attendance-view'),
    # all payrolls
    path('payrolls/', views.payrolls, name='payroll'),
    # specific payroll of employee
    path('employeepayroll/<int:name_id>/', views.employeepayroll, name='payroll-view'),
    # all applications
    path('applications/', views.applications, name='applications'),
    # specific application
    path('employeeapplication/<int:pk>', views.employeeapplication, name='application-view'),
    # path('login/',EmployeeLoginView.as_view(), name='login'),


    path('login/', LoginAPI.as_view(), name='login'),
    path('logout/', knox_views.LogoutView.as_view(), name='logout'),
    path('logoutall/', knox_views.LogoutAllView.as_view(), name='logoutall'),

]
