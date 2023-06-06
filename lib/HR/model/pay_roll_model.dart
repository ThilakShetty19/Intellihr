class PayRoll {
  late String Name, InvoiceNumber, Salary;

  PayRoll(
      {required this.Name, required this.InvoiceNumber, required this.Salary});
  PayRoll.fromJson(Map<String, dynamic> map) {
    Name = map['Name'];
    InvoiceNumber = map['InvoiceNumber'];
    Salary = map['Salary'];
  }
}
