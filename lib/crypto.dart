import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const CryptoApp());
}

class CryptoApp extends StatelessWidget {
  const CryptoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cryptocurrency Market',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const CryptoScreen(),
    );
  }
}

class CryptoScreen extends StatefulWidget {
  const CryptoScreen({super.key});

  @override
  _CryptoScreenState createState() => _CryptoScreenState();
}

class _CryptoScreenState extends State<CryptoScreen> {
  List<Crypto> cryptoList = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchCryptoData();
  }

  Future<void> fetchCryptoData() async {
    const apiUrl =
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=15&page=1&sparkline=false';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          cryptoList = data.map((coin) => Crypto.fromJson(coin)).toList();
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Failed to load data: ${response.reasonPhrase}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: ${e.toString()}';
        isLoading = false;
      });
    }
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not launch URL')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Cryptocurrencies'),
        leading: ModalRoute.of(context)?.canPop == true
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context), // Back navigation
              )
            : null,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: fetchCryptoData,
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage))
              : ListView.builder(
                  itemCount: cryptoList.length,
                  itemBuilder: (context, index) {
                    final crypto = cryptoList[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      child: ListTile(
                        leading: Image.network(
                          crypto.image,
                          width: 32,
                          height: 32,
                        ),
                        title: Text(crypto.name),
                        subtitle: Text(
                            'Price: \$${crypto.price.toStringAsFixed(2)}\nMarket Cap: \$${crypto.marketCap.toStringAsFixed(0)}'),
                        trailing: ElevatedButton(
                          onPressed: () {
                            _launchURL(
                                'https://www.coingecko.com/en/coins/${crypto.id}');
                          },
                          child: const Text('View'),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}

class Crypto {
  final String id;
  final String name;
  final double price;
  final double marketCap;
  final String image;

  Crypto({
    required this.id,
    required this.name,
    required this.price,
    required this.marketCap,
    required this.image,
  });

  factory Crypto.fromJson(Map<String, dynamic> json) {
    return Crypto(
      id: json['id'],
      name: json['name'],
      price: (json['current_price'] ?? 0).toDouble(),
      marketCap: (json['market_cap'] ?? 0).toDouble(),
      image: json['image'] ?? '',
    );
  }
}