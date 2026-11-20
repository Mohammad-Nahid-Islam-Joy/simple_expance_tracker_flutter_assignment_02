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
    final bool isIncome = transaction.type == "Income";

    return GestureDetector(
      onLongPress: onLongPressed,
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: isIncome
              ? const Color.fromARGB(100, 76, 175, 79)
              : const Color.fromARGB(100, 255, 82, 82),
          foregroundColor: isIncome
              ? const Color.fromARGB(255, 76, 175, 79)
              : const Color.fromARGB(255, 255, 82, 82),
          child: isIncome
              ? const Icon(Icons.trending_up)
              : const Icon(Icons.trending_down),
        ),

        title: Text(
          transaction.name,
          style: TextStyle(fontSize: 25, fontWeight: .bold),
        ),

        subtitle: Text(
          '${transaction.description}\n${DateFormat('dd-MMM-yyyy | hh:mm a').format(transaction.time)}',
          style: TextStyle(fontSize: 15),
        ),

        trailing: Text(
          '${isIncome ? '+' : '-'} Tk.${transaction.amount.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: 15,
            color: isIncome ? Colors.green : Colors.red,
            fontWeight: .bold,
          ),
        ),
      ),
    );
  }
}
