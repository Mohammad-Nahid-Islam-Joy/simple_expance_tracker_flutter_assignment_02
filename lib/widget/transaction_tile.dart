import 'package:expance_tracker/models/transaction_entry.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

class TransactionTile extends StatelessWidget {
  final TransactionEntry transaction;
  final VoidCallback onLongPressed;
  const TransactionTile({
    super.key,
    required this.transaction,
    required this.onLongPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPressed,
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.greenAccent,
          foregroundColor: Color.fromARGB(255, 42, 97, 44),
          child: Icon(Icons.trending_up),
        ),
        title: Text(transaction.name),
        subtitle: Text(
          '${transaction.description}\n${DateFormat('dd-MMM-yyyy | hh:mm a').format(transaction.time)}',
        ),
        trailing: Text(transaction.amount.toString()),
      ),
    );
  }
}
