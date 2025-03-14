import 'package:flutter/material.dart';

void main() {
  runApp(BudgetingApp());
}

class BudgetingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BudgetingPage(),
    );
  }
}

class BudgetingPage extends StatefulWidget {
  @override
  _BudgetingPageState createState() => _BudgetingPageState();
}

class _BudgetingPageState extends State<BudgetingPage> {
  final TextEditingController _expenseController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();
  double _totalExpenses = 0.0;
  double _budgetLimit = 0.0;

  void _addExpense() {
    if (_expenseController.text.isNotEmpty) {
      setState(() {
        _totalExpenses += double.parse(_expenseController.text);
      });
      _expenseController.clear();
    }
  }

  void _setBudget() {
    if (_budgetController.text.isNotEmpty) {
      setState(() {
        _budgetLimit = double.parse(_budgetController.text);
      });
      _budgetController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Budgeting & Expense Tracking"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input field to enter the budget
            TextField(
              controller: _budgetController,
              decoration: InputDecoration(
                labelText: "Set Budget Limit",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _setBudget,
              child: Text('Set Budget'),
            ),
            SizedBox(height: 20),

            // Input field to enter expenses
            TextField(
              controller: _expenseController,
              decoration: InputDecoration(
                labelText: "Enter Expense Amount",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addExpense,
              child: Text('Add Expense'),
            ),
            SizedBox(height: 20),

            // Display total expenses and progress bar
            Text('Total Expenses: ₹$_totalExpenses'),
            SizedBox(height: 20),
            LinearProgressIndicator(
              value: _budgetLimit > 0 ? _totalExpenses / _budgetLimit : 0,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            ),
            SizedBox(height: 10),
            Text('Budget Limit: ₹$_budgetLimit'),
          ],
        ),
      ),
    );
  }
}
