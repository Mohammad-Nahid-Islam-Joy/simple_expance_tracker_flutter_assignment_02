import 'package:expance_tracker/models/transaction_entry.dart';
import 'package:expance_tracker/widget/app_textfield.dart';
import 'package:material_ui/material_ui.dart';

class UpdateTransactionPage extends StatefulWidget {
  final TransactionEntry transactionEntry;
  const UpdateTransactionPage({super.key, required this.transactionEntry});

  @override
  State<UpdateTransactionPage> createState() => _UpdateTransactionPageState();
}

class _UpdateTransactionPageState extends State<UpdateTransactionPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameTEController;
  late final TextEditingController _descriptionTEController;
  late final TextEditingController _typeTEController;
  late final TextEditingController _amountTEController;

  @override
  void initState() {
    super.initState();
    _nameTEController = TextEditingController(
      text: widget.transactionEntry.name,
    );
    _descriptionTEController = TextEditingController(
      text: widget.transactionEntry.description,
    );
    _typeTEController = TextEditingController(
      text: widget.transactionEntry.type,
    );
    _amountTEController = TextEditingController(
      text: widget.transactionEntry.amount.toString(),
    );
  }

  void _updateTransaction() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final amount = double.tryParse(_amountTEController.text.trim());

    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Enter a Valid Amount")));
      return;
    }

    final updatedTransaction = TransactionEntry(
      name: _nameTEController.text.trim(),
      description: _descriptionTEController.text.trim(),
      type: _typeTEController.text.trim(),
      amount: amount,
      time: DateTime.now(),
    );

    Navigator.pop(context, updatedTransaction);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Update Transaction")),
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

              AppTextfield(
                controller: _typeTEController,
                label: "Transaction Type",
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
                  onPressed: _updateTransaction,
                  child: const Text("Update Transaction"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
