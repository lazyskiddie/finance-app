import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: ChatPage(),
  ));
}

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chats"),
        backgroundColor: Colors.grey[300],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              itemCount: chatData.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ChatTile(
                  name: chatData[index]['name'] ?? 'Unknown', // Check for null
                  pricePerMinute: chatData[index]['pricePerMinute'] ?? 'N/A', // Check for null
                  status: chatData[index]['status'] ?? 'Offline', // Check for null
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ChatTile extends StatelessWidget {
  final String name;
  final String pricePerMinute;
  final String status;

  ChatTile({required this.name, required this.pricePerMinute, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 0.15),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey,
            child: Icon(Icons.person, color: Colors.white),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                pricePerMinute,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              SizedBox(height: 5),
              Text(
                "Status: $status",
                style: TextStyle(fontSize: 14, color: Colors.green),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Data of people available for chat
final List<Map<String, String?>> chatData = [
  {'name': 'Dhruv', 'pricePerMinute': '₹ 29/min', 'status': 'Online'},
  {'name': 'Jatin', 'pricePerMinute': '₹ 19/min', 'status': 'Offline'},
  {'name': 'Shi', 'pricePerMinute': '₹ 39/min', 'status': 'Busy'},
  {'name': 'John', 'pricePerMinute': '₹ 99/min', 'status': 'Online'},
  {'name': 'Taxak', 'pricePerMinute': '₹ 59/min', 'status': 'Offline'},
  {'name': 'Tiona', 'pricePerMinute': '₹ 49/min', 'status': 'Online'},
  {'name': 'William Aird', 'pricePerMinute': '₹ 19/min', 'status': 'Busy'},
  {'name': 'Nokhil', 'pricePerMinute': '₹ 29/min', 'status': 'Online'},
];
