# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class AttendanceTracking(models.Model):
    attendance_id = models.CharField(primary_key=True, max_length=255)
    employee = models.ForeignKey('Employees', models.DO_NOTHING, blank=True, null=True)
    date = models.ForeignKey('CalendarDates', models.DO_NOTHING, db_column='date', blank=True, null=True)
    time_in = models.DateTimeField(blank=True, null=True)
    time_out = models.DateTimeField(blank=True, null=True)
    status = models.CharField(max_length=20, blank=True, null=True)
    late_hours = models.DecimalField(max_digits=4, decimal_places=2, blank=True, null=True)
    undertime_hours = models.DecimalField(max_digits=4, decimal_places=2, blank=True, null=True)
    is_holiday = models.BooleanField(blank=True, null=True)
    holiday_type = models.CharField(max_length=20, blank=True, null=True)
    work_hours = models.DecimalField(max_digits=5, decimal_places=2, blank=True, null=True)
    created_at = models.DateTimeField(blank=True, null=True)
    updated_at = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'attendance_tracking'


class CalendarDates(models.Model):
    date = models.DateField(primary_key=True)
    is_workday = models.BooleanField()
    is_holiday = models.BooleanField()
    is_special = models.BooleanField()
    holiday_name = models.CharField(max_length=100, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'calendar_dates'


class Candidates(models.Model):
    candidate_id = models.CharField(primary_key=True, max_length=255)
    job = models.ForeignKey('JobPosting', models.DO_NOTHING, blank=True, null=True)
    first_name = models.CharField(max_length=50, blank=True, null=True)
    last_name = models.CharField(max_length=50, blank=True, null=True)
    email = models.CharField(unique=True, max_length=100, blank=True, null=True)
    phone = models.CharField(max_length=20, blank=True, null=True)
    resume_path = models.TextField(blank=True, null=True)
    application_status = models.CharField(max_length=50, blank=True, null=True)
    documents = models.JSONField(blank=True, null=True)
    interview_details = models.JSONField(blank=True, null=True)
    offer_details = models.JSONField(blank=True, null=True)
    contract_details = models.JSONField(blank=True, null=True)
    created_at = models.DateTimeField(blank=True, null=True)
    updated_at = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'candidates'


class DepartmentSuperiors(models.Model):
    dept = models.OneToOneField('Departments', models.DO_NOTHING, primary_key=True)  # The composite primary key (dept_id, position_id) found, that is not supported. The first column is selected.
    position = models.ForeignKey('Positions', models.DO_NOTHING)
    hierarchy_level = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'department_superiors'
        unique_together = (('dept', 'position'),)


class Departments(models.Model):
    dept_id = models.CharField(primary_key=True, max_length=255)
    dept_name = models.CharField(unique=True, max_length=100, blank=True, null=True)
    is_archived = models.BooleanField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'departments'


class EmployeeLeaveBalances(models.Model):
    balance_id = models.CharField(primary_key=True, max_length=255)
    employee = models.ForeignKey('Employees', models.DO_NOTHING, blank=True, null=True)
    year = models.IntegerField(blank=True, null=True)
    sick_leave_remaining = models.IntegerField(blank=True, null=True)
    vacation_leave_remaining = models.IntegerField(blank=True, null=True)
    maternity_leave_remaining = models.IntegerField(blank=True, null=True)
    paternity_leave_remaining = models.IntegerField(blank=True, null=True)
    solo_parent_leave_remaining = models.IntegerField(blank=True, null=True)
    unpaid_leave_taken = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'employee_leave_balances'
        unique_together = (('employee', 'year'),)


class EmployeePerformance(models.Model):
    performance_id = models.CharField(primary_key=True, max_length=255)
    employee = models.ForeignKey('Employees', models.DO_NOTHING, blank=True, null=True)
    immediate_superior = models.ForeignKey('Employees', models.DO_NOTHING, related_name='employeeperformance_immediate_superior_set', blank=True, null=True)
    rating = models.IntegerField(blank=True, null=True)
    bonus_amount = models.DecimalField(max_digits=12, decimal_places=2, blank=True, null=True)
    bonus_payment_month = models.IntegerField(blank=True, null=True)
    review_date = models.DateField(blank=True, null=True)
    updated_at = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'employee_performance'


class EmployeeSalary(models.Model):
    salary_id = models.CharField(primary_key=True, max_length=255)
    employee = models.ForeignKey('Employees', models.DO_NOTHING, blank=True, null=True)
    base_salary = models.DecimalField(max_digits=12, decimal_places=2, blank=True, null=True)
    daily_rate = models.DecimalField(max_digits=12, decimal_places=2, blank=True, null=True)
    effective_date = models.DateField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'employee_salary'


class Employees(models.Model):
    employee_id = models.CharField(primary_key=True, max_length=255)
    user_id = models.CharField(max_length=255, blank=True, null=True)
    dept = models.ForeignKey(Departments, models.DO_NOTHING, blank=True, null=True)
    position = models.ForeignKey('Positions', models.DO_NOTHING, blank=True, null=True)
    first_name = models.CharField(max_length=50, blank=True, null=True)
    last_name = models.CharField(max_length=50, blank=True, null=True)
    phone = models.CharField(max_length=20, blank=True, null=True)
    employment_type = models.CharField(max_length=20, blank=True, null=True)
    status = models.CharField(max_length=20, blank=True, null=True)
    reports_to = models.ForeignKey('self', models.DO_NOTHING, db_column='reports_to', blank=True, null=True)
    is_supervisor = models.BooleanField(blank=True, null=True)
    created_at = models.DateTimeField(blank=True, null=True)
    updated_at = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'employees'


class JobPosting(models.Model):
    job_id = models.CharField(primary_key=True, max_length=255)
    dept = models.ForeignKey(Departments, models.DO_NOTHING, blank=True, null=True)
    position = models.ForeignKey('Positions', models.DO_NOTHING, blank=True, null=True)
    position_title = models.CharField(max_length=100, blank=True, null=True)
    description = models.TextField(blank=True, null=True)
    requirements = models.TextField(blank=True, null=True)
    employment_type = models.CharField(max_length=20, blank=True, null=True)
    base_salary = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    daily_rate = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    duration_days = models.SmallIntegerField(blank=True, null=True)
    finance_approval_id = models.CharField(max_length=255, blank=True, null=True)
    finance_approval_status = models.CharField(max_length=20, blank=True, null=True)
    posting_status = models.CharField(max_length=20, blank=True, null=True)
    created_at = models.DateTimeField(blank=True, null=True)
    updated_at = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'job_posting'


class LeaveRequests(models.Model):
    leave_id = models.CharField(primary_key=True, max_length=255)
    employee = models.ForeignKey(Employees, models.DO_NOTHING, blank=True, null=True)
    dept = models.ForeignKey(Departments, models.DO_NOTHING, blank=True, null=True)
    immediate_superior = models.ForeignKey(Employees, models.DO_NOTHING, related_name='leaverequests_immediate_superior_set', blank=True, null=True)
    management_approval_id = models.CharField(max_length=255, blank=True, null=True)
    leave_type = models.CharField(max_length=20, blank=True, null=True)
    start_date = models.DateField(blank=True, null=True)
    end_date = models.DateField(blank=True, null=True)
    total_days = models.IntegerField(blank=True, null=True)
    is_paid = models.BooleanField(blank=True, null=True)
    status = models.CharField(max_length=50, blank=True, null=True)
    created_at = models.DateTimeField(blank=True, null=True)
    updated_at = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'leave_requests'


class Payroll(models.Model):
    payroll_id = models.CharField(primary_key=True, max_length=255)
    employee = models.ForeignKey(Employees, models.DO_NOTHING, blank=True, null=True)
    pay_period_start = models.DateField(blank=True, null=True)
    pay_period_end = models.DateField(blank=True, null=True)
    employment_type = models.CharField(max_length=20)
    base_salary = models.DecimalField(max_digits=12, decimal_places=2, blank=True, null=True)
    overtime_hours = models.DecimalField(max_digits=5, decimal_places=2, blank=True, null=True)
    overtime_pay = models.DecimalField(max_digits=12, decimal_places=2, blank=True, null=True)
    holiday_pay = models.DecimalField(max_digits=12, decimal_places=2, blank=True, null=True)
    bonus_pay = models.DecimalField(max_digits=12, decimal_places=2, blank=True, null=True)
    thirteenth_month_pay = models.DecimalField(max_digits=12, decimal_places=2, blank=True, null=True)
    gross_pay = models.DecimalField(max_digits=12, decimal_places=2, blank=True, null=True)
    sss_contribution = models.DecimalField(max_digits=12, decimal_places=2, blank=True, null=True)
    philhealth_contribution = models.DecimalField(max_digits=12, decimal_places=2, blank=True, null=True)
    pagibig_contribution = models.DecimalField(max_digits=12, decimal_places=2, blank=True, null=True)
    tax = models.DecimalField(max_digits=12, decimal_places=2, blank=True, null=True)
    late_deduction = models.DecimalField(max_digits=12, decimal_places=2, blank=True, null=True)
    absent_deduction = models.DecimalField(max_digits=12, decimal_places=2, blank=True, null=True)
    undertime_deduction = models.DecimalField(max_digits=12, decimal_places=2, blank=True, null=True)
    total_deductions = models.DecimalField(max_digits=12, decimal_places=2, blank=True, null=True)
    net_pay = models.DecimalField(max_digits=12, decimal_places=2, blank=True, null=True)
    status = models.CharField(max_length=20, blank=True, null=True)
    created_at = models.DateTimeField(blank=True, null=True)
    updated_at = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'payroll'


class Positions(models.Model):
    position_id = models.CharField(primary_key=True, max_length=255)
    position_title = models.CharField(max_length=100, blank=True, null=True)
    salary_grade = models.CharField(max_length=20, blank=True, null=True)
    min_salary = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    max_salary = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    employment_type = models.CharField(max_length=20, blank=True, null=True)
    typical_duration_days = models.SmallIntegerField(blank=True, null=True)
    is_active = models.BooleanField(blank=True, null=True)
    created_at = models.DateTimeField(blank=True, null=True)
    updated_at = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'positions'


class Resignations(models.Model):
    resignation_id = models.CharField(primary_key=True, max_length=255)
    employee = models.ForeignKey(Employees, models.DO_NOTHING)
    submission_date = models.DateTimeField(blank=True, null=True)
    notice_period_days = models.IntegerField(blank=True, null=True)
    hr_approver = models.ForeignKey(Employees, models.DO_NOTHING, related_name='resignations_hr_approver_set', blank=True, null=True)
    approval_status = models.CharField(max_length=20, blank=True, null=True)
    clearance_status = models.CharField(max_length=20, blank=True, null=True)
    created_at = models.DateTimeField(blank=True, null=True)
    updated_at = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'resignations'


class WorkforceAllocation(models.Model):
    allocation_id = models.CharField(primary_key=True, max_length=255)
    request_id = models.CharField(unique=True, max_length=255, blank=True, null=True)
    requesting_dept = models.ForeignKey(Departments, models.DO_NOTHING, blank=True, null=True)
    required_skills = models.TextField(blank=True, null=True)
    task_description = models.TextField(blank=True, null=True)
    employee = models.ForeignKey(Employees, models.DO_NOTHING, blank=True, null=True)
    current_dept = models.ForeignKey(Departments, models.DO_NOTHING, related_name='workforceallocation_current_dept_set', blank=True, null=True)
    hr_approver = models.ForeignKey(Employees, models.DO_NOTHING, related_name='workforceallocation_hr_approver_set', blank=True, null=True)
    approval_status = models.CharField(max_length=20, blank=True, null=True)
    status = models.CharField(max_length=20, blank=True, null=True)
    start_date = models.DateField(blank=True, null=True)
    end_date = models.DateField(blank=True, null=True)
    rejection_reason = models.TextField(blank=True, null=True)
    submitted_at = models.DateTimeField(blank=True, null=True)
    approved_at = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'workforce_allocation'
