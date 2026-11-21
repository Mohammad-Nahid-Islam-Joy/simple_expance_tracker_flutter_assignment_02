import 'package:expance_tracker/models/transaction.dart';
import 'package:expance_tracker/widget/app_textfield.dart';
import 'package:material_ui/material_ui.dart';

class UpdateTransactionPage extends StatefulWidget {
  final Transaction transaction;
  const UpdateTransactionPage({super.key, required this.transaction});

  @override
  State<UpdateTransactionPage> createState() => _UpdateTransactionPageState();
}

class _UpdateTransactionPageState extends State<UpdateTransactionPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameTEController;
  late final TextEditingController _descriptionTEController;
  late final TextEditingController _amountTEController;

  String? _selectedType;

  @override
  void initState() {
    super.initState();
    _nameTEController = TextEditingController(text: widget.transaction.name);
    _descriptionTEController = TextEditingController(
      text: widget.transaction.description,
    );
    _amountTEController = TextEditingController(
      text: widget.transaction.amount.toString(),
    );

    _selectedType = widget.transaction.type;
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

    final updatedTransaction = Transaction(
      id: widget.transaction.id,
      name: _nameTEController.text.trim(),
      description: _descriptionTEController.text.trim(),
      type: _selectedType!,
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
                selected: {?_selectedType},
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

  @override
  void dispose() {
    super.dispose();
    _nameTEController.dispose();
    _descriptionTEController.dispose();
    _amountTEController.dispose();
  }
}
