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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactUsScreen()),
                );
              } else if (result == 'Privacy Policy') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PrivacyPolicyScreen()),
                );
              } else if (result == 'FAQs') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FAQScreen()),
                );
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
                value: 'FAQs',
                child: Text('FAQs'),
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
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FAQScreen()),
                );
              },
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
  final VoidCallback? onTap;

  const OptionTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
        onTap: onTap,
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

// FAQ Screen with Expandable Questions
class FAQScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQs'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ExpansionTile(
              title: Text('How is this app helpful?'),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'FinanceTalk helps users, especially beginners, make informed financial decisions by simplifying personal finance and investment options. It provides tools and knowledge to improve financial literacy, making it easier to manage money and investments effectively.',
                  ),
                ),
              ],
            ),
            // Add more FAQ items here
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
                'Privacy Policy for Finance Talk',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Last updated: March 15, 2025',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 15),
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
                'Information We Collect',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              Text(
                '1.1 Personal Information',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 15),
              Text(
                'We may collect personally identifiable information that you provide to us directly, such as:',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 15),
              Text(
                '• Name',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 15),
              Text(
                '• Email address',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 15),
              Text(
                '• Contact details',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 15),
              Text(
                '• Age, gender and occupation (if provided voluntarily)',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 15),
              Text(
                'This information is used to provide you with personalized services and respond to your inquiries.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 15),
              Text(
                '1.2 Non-Personal Information',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 15),
              Text(
                'We may also collect non-personal information automatically such as:',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                '• Device information (e.g., IP address, device model, operating system)',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 15),
              Text(
                '• App Usage data (e.g., pages viewed, action taken in the App)',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 15),
              Text(
                '• Log data (e.g., crash reports, app diagnostics)',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 15),
              Text(
                'This information helps us improve the App and provide a better user experience.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 15),
              Text(
                '1.3 Cookies and Tracking Technologies',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'We may use cookies and similar tracking technologies to track your activity on the App. Cookies are small data files stored on your device to enhance your experience. You can choose to disable cookies through your device settings, but this may affect the functionality of the App.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 15),
              Text(
                'How We Use Your Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              Text(
                'We use the information we collect in the following ways:',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 15),
              Text(
                'We do not sell or share your personal information with third parties for their marketing purposes. Your information is only shared as described in this Privacy Policy or with your consent.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Contact Us',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              Text(
                'If you have any questions or concerns about our Privacy Policy, please contact us at',
                style: TextStyle(fontSize: 16),
              ),
              // More Privacy Policy content
            ],
          ),
        ),
      ),
    );
  }
}

// Contact Us Screen
class ContactUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Contact us at:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            SizedBox(height: 10),
            Text('Email: sandeepsingh08550@gmail.com'),
            Text('Phone: +91-93599XXXXX'),
            SizedBox(height: 20),
            Text('Address:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            SizedBox(height: 10),
            Text('UKA Tarsadia University'),
            Text('Bardoli, Gujarat, India'),
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
        title: const Text('About Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About Finance Talk',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'At FinanceTalk, we believe that financial literacy is the key to unlocking financial independence and achieving your long-term goals. Our app is designed to simplify complex financial concepts and empower individuals to take control of their money, investments, and financial future.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Whether you are a beginner looking to understand the basics of personal finance or an experienced investor seeking the latest market insights, FinanceTalk provides easy-to-understand guidance and expert advice tailored to your unique financial situation.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Our mission is to bridge the financial literacy gap by offering personalized, user-friendly tools that help you:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
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
              /*Text(
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
              ),*/
            // More About Us content
          ],
        ),
      ),
    );
  }
}
