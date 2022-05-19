import 'package:flutter/material.dart';

class AddExpenseWidget extends StatefulWidget {
  const AddExpenseWidget({Key? key}) : super(key: key);

  @override
  State<AddExpenseWidget> createState() => _AddExpenseWidgetState();
}

class _AddExpenseWidgetState extends State<AddExpenseWidget> {
  final TextEditingController expenseController = TextEditingController();
  List<String> categories = [
    'Bills',
    'Shopping',
    'Vacation',
    'Entertainment',
    'Stocks',
    'CryptoCurrency',
    'Other'
  ];
  String? dropdownValue;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: expenseController,
              decoration: const InputDecoration(
                labelText: 'Expense',
              ),
            ),
          ),
          DropdownButton<String>(
            hint: const Text('Category'),
            value: dropdownValue,
            elevation: 16,
            items: categories.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
            },
          ),
          ElevatedButton(
            child: const Text(
              'Add expense',
              style: TextStyle(fontSize: 16),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
