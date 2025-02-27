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
        title: Text("Chat"),
        backgroundColor: Colors.grey[400],
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

  ChatTile({required this.name, required this.pricePerMinute});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[300],
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
            ],
          ),
        ],
      ),
    );
  }
}

// Data of people available for chat
final List<Map<String, String?>> chatData = [
  {'name': 'Dhruv', 'pricePerMinute': '₹ 29/min'},
  {'name': 'Jatin', 'pricePerMinute': '₹ 19/min'},
  {'name': 'Shi', 'pricePerMinute': '₹ 39/min'},
  {'name': 'John', 'pricePerMinute': '₹ 99/min'},
  {'name': 'Taxak', 'pricePerMinute': '₹ 59/min'},
  {'name': 'Tiona', 'pricePerMinute': '₹ 49/min'},
  {'name': 'William Aird', 'pricePerMinute': '₹ 19/min'},
  {'name': 'Nokhil', 'pricePerMinute': '₹ 29/min'},
];
