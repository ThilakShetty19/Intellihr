class Performance {
String? Name,Position,Projects,CompletedPro,ActivePro,employeeId,appraisal;
          
  Performance({
    required this.Name,
    required this.Position,
    required this.Projects,
    required this.CompletedPro,
    required this.ActivePro,
    required this.employeeId,
    
 
    required this.appraisal,
   

  });

  Performance.fromJson(Map<String, dynamic> map) {
    Name = map['Name'];
    Position = map['Position'];
    Projects = map['Projects'];
    CompletedPro = map['CompletedPro'];
    ActivePro = map['ActivePro'];
    employeeId = map['employeeId'];
   
    appraisal = map['appraisal'];
    

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.Name;
    data['Position'] = this.Position;
    data['Projects'] = this.Projects;
    data['CompletedPro'] = this.CompletedPro;
    data['ActivePro'] = this.ActivePro;
    data['employeeId'] = this.employeeId;
    data['appraisal'] = this.appraisal;
 
    return data;
  }
}
