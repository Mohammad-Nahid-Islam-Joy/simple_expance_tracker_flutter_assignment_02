import 'package:expance_tracker/models/transaction_entry.dart';
import 'package:expance_tracker/widget/app_textfield.dart';
import 'package:material_ui/material_ui.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({super.key});

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameTEController = TextEditingController();
  final _descriptionTEController = TextEditingController();
  String _selectedType = "Expense";
  final _amountTEController = TextEditingController();

  void _addTransaction() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final amount = double.tryParse(_amountTEController.text.trim());

    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Enter a Valid Amount")));
      return;
    }

    final transaction = TransactionEntry(
      name: _nameTEController.text.trim(),
      description: _descriptionTEController.text.trim(),
      type: _selectedType,
      amount: amount,
      time: DateTime.now(),
    );

    Navigator.pop(context, transaction);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Transaction")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              AppTextfield(
                controller: _nameTEController,
                label: "Transaction Name",
              ),

              const SizedBox(height: 15),

              AppTextfield(
                controller: _descriptionTEController,
                label: "Transaction Description",
                maxLines: 3,
              ),

              const SizedBox(height: 15),

              const Align(
                alignment: Alignment.center,
                child: Text("Transaction Type", style: TextStyle(fontSize: 16)),
              ),

              const SizedBox(height: 10),

              SegmentedButton<String>(
                segments: const [
                  ButtonSegment<String>(
                    value: "Income",
                    label: Text("Income"),
                    icon: Icon(Icons.trending_up),
                  ),
                  ButtonSegment<String>(
                    value: "Expense",
                    label: Text("Expense"),
                    icon: Icon(Icons.trending_down),
                  ),
                ],
                selected: {_selectedType},
                onSelectionChanged: (Set<String> selected) {
                  setState(() {
                    _selectedType = selected.first;
                  });
                },
              ),

              const SizedBox(height: 15),

              AppTextfield(
                controller: _amountTEController,
                label: "Transaction Ammount",
                keyboardType: TextInputType.numberWithOptions(),
              ),

              const SizedBox(height: 15),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _addTransaction,
                  child: const Text("Add Transaction"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
