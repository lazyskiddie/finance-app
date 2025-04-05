import 'package:financetalk07/Accounts.dart';
import 'package:flutter/material.dart';
import 'package:financetalk07/Chats.dart';
import 'package:financetalk07/Financeplanner.dart';
import 'package:financetalk07/News.dart';
import 'package:financetalk07/Notification.dart';
import 'package:financetalk07/Profile.dart';
import 'package:financetalk07/Saveandinvest.dart';
import 'package:financetalk07/gen.dart';

void main() {
  runApp(FinanceTalkApp());
}

class FinanceTalkApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finance Talk',
      home: FinanceTalkHome(),
    );
  }
}

class FinanceTalkHome extends StatefulWidget {
  @override
  _FinanceTalkHomeState createState() => _FinanceTalkHomeState();
}

class _FinanceTalkHomeState extends State<FinanceTalkHome> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeScreenContent(),
    ChatPage(),
    VideoPage(),
    BankAccountApp(),
    Placeholder(), // Replace this with real Scheme screen
  ];

  bool _shouldShowAppBar(int index) {
    return index == 0; // Show AppBar only on Home screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _shouldShowAppBar(_currentIndex)
          ? AppBar(
              title: Text('Finance talk'),
              actions: [
                IconButton(
                  icon: Icon(Icons.person_outline),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => UserProfileScreen(),
                      ),
                    );
                  },
                ),
              ],
              backgroundColor: Colors.white,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black),
              titleTextStyle: TextStyle(
                  color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
            )
          : null,
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.videocam), label: 'Video'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Account'),
          BottomNavigationBarItem(icon: Icon(Icons.build), label: 'Scheme'),
        ],
      ),
    );
  }
}

class HomeScreenContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search bar and notification icon
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search finance related products',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              IconButton(
                icon: Icon(Icons.notifications_none),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => NotificationPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),

        // Trending card
        Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(15),
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
              'Trending finance related things',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),

        // Grid of features
        Expanded(
          flex: 2,
          child: GridView.count(
            crossAxisCount: 3,
            padding: EdgeInsets.all(10),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => GeminiChatApp(),
                    ),
                  );
                },
                child: Text('Gemini'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ExpenseCalculatorApp(),
                    ),
                  );
                },
                child: Text('Financeplanner'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SaveInvestApp(),
                    ),
                  );
                },
                child: Text('Save & Invest'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => FinanceNewsApp(),
                    ),
                  );
                },
                child: Text('News'),
              ),
              financeFeatureTile(Icons.beach_access, 'Retirements'),
              financeFeatureTile(Icons.account_balance_wallet, 'Wallet'),
            ],
          ),
        ),

        // Chat suggestions
        SizedBox(height: 10),
        Container(
          height: 200,
          child: ListView(
            padding: EdgeInsets.all(8),
            children: [
              ChatWidget(name: 'Taxak', status: 'online'),
              ChatWidget(name: 'John', status: '19 min ago'),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ChatPage(),
                    ),
                  );
                },
                child: Text('+ more chats'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget financeFeatureTile(IconData icon, String title) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40),
            SizedBox(height: 10),
            Text(title, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class ChatWidget extends StatelessWidget {
  final String name;
  final String status;

  ChatWidget({required this.name, required this.status});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Icon(Icons.person),
      ),
      title: Text(name),
      subtitle: Text(status),
    );
  }
}

class VideoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Coming Soon: YouTube Finance Shorts!'),
    );
  }
}

