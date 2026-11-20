import 'package:expance_tracker/models/transaction_entry.dart';
import 'package:expance_tracker/pages/add_transaction_page.dart';
import 'package:expance_tracker/widget/transaction_tile.dart';
import 'package:material_ui/material_ui.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<TransactionEntry> transactions = [
    TransactionEntry(
      name: "Salary",
      description: "Monthly Salary",
      type: "Income",
      amount: 5000,
      time: DateTime.now(),
    ),
    TransactionEntry(
      name: "Lunch",
      description: "Group Lunch",
      type: "Expance",
      amount: 300,
      time: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    Future<void> _gotoAddPage() async {
      final transaction = await Navigator.push<TransactionEntry>(
        context,
        MaterialPageRoute(builder: (context) => const AddTransactionPage()),
      );

      if (!mounted || transaction == null) {
        return;
      }

      setState(() {
        transactions.add(transaction);
      });
    }

    return Scaffold(
      body: transactions.isEmpty
          ? const Text("NO products Added")
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];

                return Builder(
                  builder: (tileContext) {
                    return TransactionTile(
                      transaction: transaction,
                      onLongPressed: () {},
                    );
                  },
                );
              },
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: _gotoAddPage,
        child: const Icon(Icons.add),
      ),
    );
  }
}
