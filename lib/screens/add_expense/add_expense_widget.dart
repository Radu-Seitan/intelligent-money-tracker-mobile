import 'dart:convert';

import 'package:fimber_io/fimber_io.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../../services/auth_service.dart';

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
  String? storeValue;
  List<dynamic>? stores;

  Future<List<dynamic>> _getStores() async {
    final String _baseUri = 'http://34.118.9.214:7165';
    final String _resourceName = 'api/Stores';

    try {
      var response = await get(Uri.parse('$_baseUri/$_resourceName'));
      var decodedBody = jsonDecode(response.body);
      stores = decodedBody;
      return decodedBody;
    } catch (ex, stackTrace) {
      Fimber.e('Unhandled exception', ex: ex, stacktrace: stackTrace);
      throw Exception('Failed to get user.');
    }
  }

  Future _postExpense(double quantity) async {
    final String _baseUri = 'http://34.118.9.214:7165';
    final String _resourceName = 'api/Expenses';

    final authService = Provider.of<AuthService>(context, listen: false);

    late int categoryInt;
    var store = stores?.firstWhere((element) => element['name'] == storeValue);
    int? storeId = store['id'];

    switch (dropdownValue) {
      case 'Bills':
        {
          categoryInt = 0;
        }
        break;

      case 'Shopping':
        {
          categoryInt = 1;
        }
        break;

      case 'Vacation':
        {
          categoryInt = 2;
        }
        break;

      case 'Entertainment':
        {
          categoryInt = 3;
        }
        break;

      case 'Stocks':
        {
          categoryInt = 4;
        }
        break;

      case 'CryptoCurrency':
        {
          categoryInt = 5;
        }
        break;

      case 'Other':
        {
          categoryInt = 6;
        }
        break;
    }

    try {
      // call backend api and post user entity in db
      var response = await post(
        Uri.parse('$_baseUri/$_resourceName'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, Object?>{
            'quantity': quantity,
            'category': categoryInt,
            'userId': authService.userId,
            'storeId': storeId,
          },
        ),
      );
    } catch (ex, stackTrace) {
      Fimber.e('Unhandled exception', ex: ex, stacktrace: stackTrace);
      throw Exception('Failed to post income.');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getStores(),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
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
                  items:
                      categories.map<DropdownMenuItem<String>>((String value) {
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
                DropdownButton<String>(
                  hint: const Text('Store'),
                  value: storeValue,
                  elevation: 16,
                  items: stores?.map<DropdownMenuItem<String>>((dynamic value) {
                    return DropdownMenuItem<String>(
                      value: value['name'],
                      child: Text(value['name']),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      storeValue = newValue!;
                    });
                  },
                ),
                ElevatedButton(
                  child: const Text(
                    'Add expense',
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () async {
                    await _postExpense(double.parse(expenseController.text));
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
