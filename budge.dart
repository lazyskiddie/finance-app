import 'package:flutter/material.dart';

void main() {
  runApp(SavingGoalApp());
}

class SavingGoalApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SavingGoalScreen(),
    );
  }
}

class SavingGoalScreen extends StatefulWidget {
  @override
  _SavingGoalScreenState createState() => _SavingGoalScreenState();
}

class _SavingGoalScreenState extends State<SavingGoalScreen> {
  String? selectedGoal;
  String? selectedSaving;

  void _showGoalPopup(String goalName) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => GoalPopup(goalName: goalName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            const SizedBox(height: 16),

            // Goals Section with Styled Title
            _sectionTitle('Goals'),
            _buildSection(
              ['Home', 'Car', 'Travel'],
              selectedGoal,
              (String? value) {
                setState(() {
                  selectedGoal = value;
                });
                if (value != null) {
                  _showGoalPopup(value);
                }
              },
            ),
            const SizedBox(height: 16),

            // Savings Section with Styled Title
            _sectionTitle('Savings'),
            _buildSection(
              ['Vacation', 'Emergency Fund', 'Education', 'Loan'],
              selectedSaving,
              (String? value) {
                setState(() {
                  selectedSaving = value;
                });
                if (value != null) {
                  _showGoalPopup(value);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  // Styled Section Title Widget
  Widget _sectionTitle(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  // Build Section with Radio Buttons
  Widget _buildSection(
      List<String> items, String? selectedValue, Function(String?) onChanged) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.grey, blurRadius: 4),
        ],
      ),
      child: Column(
        children: items.map((String item) {
          return RadioListTile<String>(
            title: Text(item),
            value: item,
            groupValue: selectedValue,
            onChanged: onChanged,
            activeColor: Colors.blue,
          );
        }).toList(),
      ),
    );
  }
}

// ==============================
// POPUP - GoalPopup
// ==============================
class GoalPopup extends StatefulWidget {
  final String goalName;

  const GoalPopup({Key? key, required this.goalName}) : super(key: key);

  @override
  _GoalPopupState createState() => _GoalPopupState();
}

class _GoalPopupState extends State<GoalPopup> {
  double _years = 5.0;
  int _currentYear = DateTime.now().year;

  @override
  Widget build(BuildContext context) {
    int targetYear = _currentYear + _years.toInt();

    return Container(
      height: 260,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Goal Name Section
          const Text(
            'Set Your Goal',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Goal Name: ${widget.goalName}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),

          // Year Planning Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Planned for $targetYear',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Text(
                '$targetYear',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Slider(
            value: _years,
            min: 1,
            max: 10,
            divisions: 9,
            label: '${_years.toInt()} yrs',
            onChanged: (value) {
              setState(() {
                _years = value;
              });
            },
          ),

          // Continue Button
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Continue',
                  style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
