import 'package:financetalk07/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(FinanceTalkApp());
}

class FinanceTalkApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FinanceTalkHomePage(),
    );
  }
}

class FinanceTalkHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Finance Talk',
              style: TextStyle(
                fontSize: 50,
                color: Color(0xFFFFD700), // classic gold
                fontWeight: FontWeight.bold,
                fontFamily: 'Serif', // Optional for classic vibe
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 110),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => FinanceTalkHome(),
                  ),
                );
                // Navigate to the next screen
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFFD700),
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Get Started',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}