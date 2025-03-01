import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: SaveInvestPage(),
  ));
}

class SaveInvestPage extends StatelessWidget {
  final List<Map<String, dynamic>> options = [
    {'icon': Icons.show_chart, 'label': 'Stock Market', 'image': 'assets/stock_market.png'},
    {'icon': Icons.currency_bitcoin, 'label': 'Crypto Currency', 'image': 'assets/crypto.png'},
    {'icon': Icons.monetization_on, 'label': 'Mutual Funds', 'image': 'assets/mutual_funds.png'},
    {'icon': Icons.account_balance, 'label': 'FD Account', 'image': 'assets/fd_account.png'},
    {'icon': Icons.business, 'label': 'Corporate Bonds', 'image': 'assets/corporate_bonds.png'},
    {'icon': Icons.account_balance_wallet, 'label': 'IPO', 'image': 'assets/ipo.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: Text(
          'Save & Invest',
          style: TextStyle(color: Colors.black),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 1,
          ),
          itemCount: options.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // You can handle onTap to navigate or show details
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      options[index]['image'],
                      height: 50,
                      width: 50,
                    ),
                    SizedBox(height: 10),
                    Text(
                      options[index]['label'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
