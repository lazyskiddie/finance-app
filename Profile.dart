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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PrivacyPolicyScreen()),
                );
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

// Privacy Policy Screen
class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Last updated: [Insert Date]',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Finance Talk ("we," "our," or "us") operates the Finance Talk mobile application (the "App"). This Privacy Policy explains how we collect, use, and share your information when you use our App.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 15),
              Text(
                'By using the App, you agree to the collection and use of information in accordance with this Privacy Policy. If you do not agree with any part of this Privacy Policy, please do not use the App.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                '1. Information We Collect',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                '1.1 Personal Information\nWe may collect personally identifiable information that you provide to us directly, such as:\n\n• Name\n• Email address\n• Contact details\n• Age, gender, and occupation (if provided voluntarily)',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 15),
              Text(
                '1.2 Non-Personal Information\nWe may also collect non-personal information automatically, such as:\n\n• Device information (e.g., IP address, device model, operating system)\n• App usage data (e.g., pages viewed, actions taken in the app)\n• Log data (e.g., crash reports, app diagnostics)',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 15),
              Text(
                '1.3 Cookies and Tracking Technologies\nWe may use cookies and similar tracking technologies to track your activity on the App. Cookies are small data files stored on your device to enhance your experience. You can choose to disable cookies through your device settings, but this may affect the functionality of the App.',
                style: TextStyle(fontSize: 16),
              ),
              // Continue with the rest of the privacy policy text...
            ],
          ),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to Finance Talk!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'At Finance Talk, we aim to simplify personal finance and investment decisions for everyone, especially those who are new to the financial world. Whether you are a beginner or an experienced investor, our mission is to provide you with the tools and knowledge you need to achieve financial independence.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'We believe that everyone should have access to accurate and reliable financial advice, regardless of their background or experience. That\'s why we created this app – to help you make informed financial decisions and grow your wealth over time.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
