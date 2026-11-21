// ignore_for_file: public_member_api_docs, sort_constructors_first
class Transaction {
  final int? id;
  final String name;
  final String description;
  final String type;
  final double amount;
  final DateTime time;

  Transaction({
    this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.amount,
    required this.time,
  });

  Transaction copyWith({
    int? id,
    String? name,
    String? description,
    String? type,
    double? amount,
    DateTime? time,
  }) {
    return Transaction(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      time: time ?? this.time,
    );
  }
}
