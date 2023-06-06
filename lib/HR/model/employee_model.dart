class Employee {
  final String Name;
  final String Number;
  final String Address;
  final String EmployeeId;
  final String Salary;
  final String Email;
  final String Password;
  Employee(
      {required this.Name,
      required this.Number,
      required this.Address,
      required this.EmployeeId,
      required this.Salary,
      required this.Email,
      required this.Password});

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      Name: json['Name'],
      Number: json['Number'],
      Address: json['Address'],
      EmployeeId: json['EmployeeId'],
      Salary: json['Salary'],
      Email: json['Email'],
      Password: json['Password'],
    );
  }
  Map<String, dynamic> toJson() => {
        'Name': this.Name,
        'Number': this.Number,
        'Address': this.Address,
        'EmployeeId': this.EmployeeId,
        'Salary': this.Salary,
        'Email': this.Email,
        'Password': this.Password,
      };
}



