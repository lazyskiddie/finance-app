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

class UserProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finance talk'),
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
                // Handle 'About Us'
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
                title: Text('Sandeep Singh'),
                subtitle: Text('20\nStudent'),
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
              title: 'Support',
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
