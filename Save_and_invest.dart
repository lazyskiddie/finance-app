import 'package:financetalk07/Accounts.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(SaveInvestApp());
}

class SaveInvestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SaveInvestPage(),
    );
  }
}

class SaveInvestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Save & Invest'),
        backgroundColor: Colors.grey[400],
        leading: BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          children: [
            InvestmentOption(
              iconPath: 'assets/stock_market.png',
              label: 'Stock Market',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => StockApp()));
              },
            ),
            InvestmentOption(
              iconPath: 'assets/crypto_currency.png',
              label: 'Crypto Currency',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => CryptoCurrencyPage()));
              },
            ),
            InvestmentOption(
              iconPath: 'assets/mutual_funds.png',
              label: 'Mutual Funds',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => MutualFundsPage()));
              },
            ),
            InvestmentOption(
              iconPath: 'assets/fd_account.png',
              label: 'FD Account',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => BankAccountHome()));
              },
            ),
            InvestmentOption(
              iconPath: 'assets/corporate_bonds.png',
              label: 'Corporate Bonds',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => CorporateBondsPage()));
              },
            ),
            InvestmentOption(
              iconPath: 'assets/ipo.png',
              label: 'IPO',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => IPOPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class InvestmentOption extends StatelessWidget {
  final String iconPath;
  final String label;
  final VoidCallback onTap;

  InvestmentOption({required this.iconPath, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(iconPath, height: 50),
            const SizedBox(height: 10),
            Text(label, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

class StockMarketPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stock Market'),
        leading: BackButton(),
        ),
      body: const Center(child: Text('Stock Market Information')),
    );
  }
}

class CryptoCurrencyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crypto Currency'),
        leading: BackButton(),
        ),
      body: const Center(child: Text('Crypto Currency Information')),
    );
  }
}

class MutualFundsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mutual Funds'),
        leading: BackButton(),
        ),
      body: const Center(child: Text('Mutual Funds Information')),
    );
  }
}

class FDAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FD Account'),
        leading: BackButton(),
        ),
      body: const Center(child: Text('Account')),
    );
  }
}

class CorporateBondsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Corporate Bonds'),
        leading: BackButton(),
        ),
      body: const Center(child: Text('Corporate Bonds Information')),
    );
  }
}

class IPOPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IPO'),
        leading: BackButton(),
        ),
      body: const Center(child: Text('IPO Information')),
    );
  }
}
