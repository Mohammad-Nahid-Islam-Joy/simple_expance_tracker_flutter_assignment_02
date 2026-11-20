import 'package:material_ui/material_ui.dart';

class TransactionActionMenu extends StatelessWidget {
  const TransactionActionMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text("Update"),
            onTap: () {
              Navigator.pop(context, "update");
            },
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.delete, color: Colors.red),
            title: const Text("Delete", style: TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.pop(context, "delete");
            },
          ),
        ],
      ),
    );
  }
}
