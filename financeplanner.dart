import 'package:flutter/material.dart';

void main() {
  runApp(ExpenseCalculatorApp());
}

class ExpenseCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Monthly Expense Calculator',
      home: ExpenseCalculatorScreen(),
    );
  }
}

class ExpenseCalculatorScreen extends StatefulWidget {
  @override
  _ExpenseCalculatorScreenState createState() =>
      _ExpenseCalculatorScreenState();
}

class _ExpenseCalculatorScreenState extends State<ExpenseCalculatorScreen> {
  TextEditingController _incomeController = TextEditingController();
  String _results = '';

  void _calculateExpenses(int caseNumber) {
    double m = double.tryParse(_incomeController.text) ?? 0;
    if (m <= 0) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please enter a valid income')));
      return;
    }

    setState(() {
      final s = (m / 5).toStringAsFixed(2); // shaving
      final r = (m / 10).toStringAsFixed(2); // rent
      final e = (m / 5).toStringAsFixed(2); // education
      final g = (m / 20).toStringAsFixed(2); // grocery
      final p = (m / 20).toStringAsFixed(2); // personal
      final a = (m / 6.99678).toStringAsFixed(2); // emergency
      final l = (m / 10).toStringAsFixed(2); // liquid money

      if (caseNumber == 1) {
        final b = (m / 6.366294).toStringAsFixed(2); // loan (EMI)
        _results = '''
        Approx Shaving per month: ₹$s
        Rent expenses per month: ₹$r
        Education expense per month: ₹$e
        Grocery bill per month: ₹$g
        Personal expense per month: ₹$p
        Emergency savings fund per month: ₹$a
        Liquid money you should have: ₹$l
        Monthly EMI (loan) should be: ₹$b
        ''';
      } else {
        _results = '''
        Approx Shaving per month: ₹$s
        Rent expenses per month: ₹$r
        Education expense per month: ₹$e
        Grocery bill per month: ₹$g
        Personal expense per month: ₹$p
        Emergency savings per month: ₹$a
        Liquid money you must have: ₹$l
        ''';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            width: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Enter Your Monthly Income',
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _incomeController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Enter your monthly income',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () => _calculateExpenses(1),
                      child: Text('With Loan (EMI)'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => _calculateExpenses(2),
                      child: Text('No Loan (EMI)'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  _results,
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
