import 'package:expance_tracker/models/transaction_entry.dart';
import 'package:expance_tracker/pages/add_transaction_page.dart';
import 'package:expance_tracker/pages/update_transaction_page.dart';
import 'package:expance_tracker/widget/transaction_action_menu.dart';
import 'package:expance_tracker/widget/transaction_tile.dart';
import 'package:material_ui/material_ui.dart';
import 'package:popover/popover.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<TransactionEntry> _transactions = [
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
      type: "Expense",
      amount: 300,
      time: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    void showMessage(String message) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(message)));
    }

    Future<void> gotoAddPage() async {
      final transaction = await Navigator.push<TransactionEntry>(
        context,
        MaterialPageRoute(builder: (context) => const AddTransactionPage()),
      );

      if (!mounted || transaction == null) {
        return;
      }

      setState(() {
        _transactions.add(transaction);
      });

      showMessage("Transaction Added");
    }

    Future<void> gotoUpdatePage(int index) async {
      final updatedTransaction = await Navigator.push<TransactionEntry>(
        context,
        MaterialPageRoute(
          builder: (context) =>
              UpdateTransactionPage(transactionEntry: _transactions[index]),
        ),
      );

      if (!mounted || updatedTransaction == null) {
        return;
      }

      setState(() {
        _transactions[index] = updatedTransaction;
      });

      showMessage("Transaction Updated");
    }

    void deleteTransaction(int index) {
      setState(() {
        _transactions.removeAt(index);
      });

      showMessage("Transaction Deleted");
    }

    Future<void> showPopOverMenu(BuildContext tileContext, int index) async {
      final action = await showPopover(
        context: tileContext,
        bodyBuilder: (context) => const TransactionActionMenu(),
        direction: PopoverDirection.right,
        width: 150,
        style: PopoverStyle(
          backgroundColor: Colors.white,
          barrierColor: Colors.transparent,
        ),
      );

      if (!mounted || action == null) return;

      if (index >= _transactions.length) {
        return;
      }

      if (action == "update") {
        await gotoUpdatePage(index);
      } else if (action == "delete") {
        deleteTransaction(index);
      }
    }

    return Scaffold(
      body: _transactions.isEmpty
          ? const Text("NO products Added")
          : ListView.builder(
              itemCount: _transactions.length,
              itemBuilder: (context, index) {
                final transaction = _transactions[index];

                return Builder(
                  builder: (tileContext) {
                    return TransactionTile(
                      transaction: transaction,
                      onLongPressed: () {
                        showPopOverMenu(tileContext, index);
                      },
                    );
                  },
                );
              },
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: gotoAddPage,
        child: const Icon(Icons.add),
      ),
    );
  }
}
