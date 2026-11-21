import 'package:expance_tracker/database/app_database.dart';
import 'package:expance_tracker/models/transaction.dart';
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
  @override
  Widget build(BuildContext context) {
    void showMessage(String message) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(message)));
    }

    Future<void> gotoAddPage() async {
      final transaction = await Navigator.push<Transaction>(
        context,
        MaterialPageRoute(builder: (context) => const AddTransactionPage()),
      );

      if (!mounted || transaction == null) {
        return;
      }

      await AppDatabase.instance.insertTransaction(transaction);

      showMessage("Transaction Added");
    }

    Future<void> gotoUpdatePage(Transaction transaction) async {
      final updatedTransaction = await Navigator.push<Transaction>(
        context,
        MaterialPageRoute(
          builder: (context) => UpdateTransactionPage(transaction: transaction),
        ),
      );

      if (!mounted || updatedTransaction == null) {
        return;
      }

      await AppDatabase.instance.updateTransactions(updatedTransaction);

      showMessage("Transaction Updated");
    }

    Future<void> deleteTransaction(Transaction transaction) async {
      if (transaction.id == null) {
        return;
      }

      await AppDatabase.instance.deleteTransaction(transaction.id!);

      showMessage("Transaction Deleted");
    }

    Future<void> showPopOverMenu(
      BuildContext tileContext,
      Transaction transaction,
    ) async {
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

      if (action == "update") {
        await gotoUpdatePage(transaction);
      } else if (action == "delete") {
        deleteTransaction(transaction);
      }
    }

    return Scaffold(
      body: StreamBuilder<List<Transaction>>(
        stream: AppDatabase.instance.watchAllTransactions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              !snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final transactions = snapshot.data ?? [];

          if (transactions.isEmpty) {
            return const Center(child: Text("No Transaction Found!"));
          }

          return ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final transaction = transactions[index];

              return Builder(
                builder: (tileContext) {
                  return TransactionTile(
                    transaction: transaction,
                    onLongPressed: () {
                      showPopOverMenu(tileContext, transaction);
                    },
                  );
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
