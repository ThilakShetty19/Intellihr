class Leave {
  final String id;
  final String employeeId;
  final String employeeName;
  final DateTime fromDate;
  final DateTime toDate;
  final String reason;

  Leave({
    required this.id,
    required this.employeeId,
    required this.employeeName,
    required this.fromDate,
    required this.toDate,
    required this.reason,
  });
}
