import 'package:flutter/material.dart';

class AddIncomeWidget extends StatefulWidget {
  const AddIncomeWidget({Key? key}) : super(key: key);

  @override
  State<AddIncomeWidget> createState() => _AddIncomeWidgetState();
}

class _AddIncomeWidgetState extends State<AddIncomeWidget> {
  final TextEditingController incomeController = TextEditingController();
  List<String> categories = [
    'Salary',
    'Stocks',
    'Sales',
    'CryptoCurrency',
    'Gambling',
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
              controller: incomeController,
              decoration: const InputDecoration(
                labelText: 'Income',
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
              'Add income',
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
