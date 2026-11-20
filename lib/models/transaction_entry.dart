class TransactionEntry {
  final String name;
  final String description;
  final String type;
  final double amount;
  final DateTime time;

  TransactionEntry({
    required this.name,
    required this.description,
    required this.type,
    required this.amount,
    required this.time,
  });
}
