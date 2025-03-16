import 'package:flutter/material.dart';

void main() {
  runApp(FinanceTalkApp());
}

class FinanceTalkApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: UserProfileScreen(),
    );
  }
}

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  // Variables to hold user profile data
  String name = 'Sandeep Singh';
  String age = '20';
  String occupation = 'Student';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finance Talk'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String result) {
              if (result == 'About Us') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutUsScreen()),
                );
              } else if (result == 'Contact Us') {
                // Handle 'Contact Us'
              } else if (result == 'Privacy Policy') {
                // Handle 'Privacy Policy'
              } else if (result == 'Dark Mode') {
                // Handle 'Dark Mode'
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'About Us',
                child: Text('About Us'),
              ),
              const PopupMenuItem<String>(
                value: 'Contact Us',
                child: Text('Contact Us'),
              ),
              const PopupMenuItem<String>(
                value: 'Privacy Policy',
                child: Text('Privacy Policy'),
              ),
              const PopupMenuItem<String>(
                value: 'Dark Mode',
                child: Text('Dark Mode'),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 30,
                  child: Icon(Icons.person, size: 30),
                ),
                title: Text(name),
                subtitle: Text('$age\n$occupation'),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // Navigate to EditProfileScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfileScreen(
                          currentName: name,
                          currentAge: age,
                          currentOccupation: occupation,
                          onSave: (String newName, String newAge, String newOccupation) {
                            setState(() {
                              name = newName;
                              age = newAge;
                              occupation = newOccupation;
                            });
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            OptionTile(
              title: 'Account',
              subtitle: 'Security, notification, change email',
              icon: Icons.person_outline,
            ),
            OptionTile(
              title: 'Chats',
              subtitle: 'History, theme',
              icon: Icons.chat_outlined,
            ),
            OptionTile(
              title: 'App language',
              subtitle: 'English (device\'s language)',
              icon: Icons.language_outlined,
            ),
            OptionTile(
              title: 'FAQs',
              subtitle: 'Help center',
              icon: Icons.help_outline,
            ),
          ],
        ),
      ),
    );
  }
}

class OptionTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const OptionTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
        onTap: () {
          // Handle option tap
        },
      ),
    );
  }
}

// Edit Profile Screen
class EditProfileScreen extends StatefulWidget {
  final String currentName;
  final String currentAge;
  final String currentOccupation;
  final Function(String, String, String) onSave;

  const EditProfileScreen({
    Key? key,
    required this.currentName,
    required this.currentAge,
    required this.currentOccupation,
    required this.onSave,
  }) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _occupationController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentName);
    _ageController = TextEditingController(text: widget.currentAge);
    _occupationController = TextEditingController(text: widget.currentOccupation);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _occupationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _ageController,
              decoration: InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _occupationController,
              decoration: InputDecoration(labelText: 'Occupation'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                widget.onSave(
                  _nameController.text,
                  _ageController.text,
                  _occupationController.text,
                );
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

// About Us Screen
class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'About FinanceTalk',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              Text(
                'At FinanceTalk, we believe that financial literacy is the key to unlocking financial independence and achieving your long-term goals. Our app is designed to simplify complex financial concepts and empower individuals to take control of their money, investments, and financial future.',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 15),
              Text(
                'Whether you\'re a beginner looking to understand the basics of personal finance or an experienced investor seeking the latest market insights, FinanceTalk provides easy-to-understand guidance and expert advice tailored to your unique financial situation.',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 15),
              Text(
                'Our mission is to bridge the financial literacy gap by offering personalized, user-friendly tools that help you:',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 15),
              Text(
                '• Track Your Finances: Monitor your expenses, income, and savings effortlessly.',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                '• Grow Your Wealth: Receive curated investment suggestions based on your goals and risk tolerance.',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                '• Stay Informed: Access the latest market news, insights, and trends to make informed decisions.',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                '• Secure Your Future: Plan for long-term goals like retirement, homeownership, or education with our financial planning tools.',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 15),
              Text(
                'We are passionate about creating a platform where everyone, regardless of their financial knowledge, can learn, grow, and succeed in their financial journey. At FinanceTalk, we’re not just helping you manage your money—we’re helping you achieve financial freedom.',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 15),
              Text(
                'Join us in making smart financial decisions today for a better tomorrow!',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
