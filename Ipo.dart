import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class IPOScreen extends StatefulWidget {
  const IPOScreen({super.key});

  @override
  _IPOScreenState createState() => _IPOScreenState();
}

class _IPOScreenState extends State<IPOScreen> {
  List<IPO> ipoList = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchIPOData();
  }

  Future<void> fetchIPOData() async {
    try {
      // Simulated API response for demo
      await Future.delayed(const Duration(seconds: 1));
      final mockResponse = '''
      {
        "ipos": [
          {
            "id": "1",
            "company": "Tech Innovations Inc.",
            "symbol": "TII",
            "priceRange": "₹1200-₹1250",
            "lotSize": "12 shares",
            "issueSize": "₹5,000 Cr",
            "openDate": "2023-06-01",
            "closeDate": "2023-06-05",
            "brokerCodes": {
              "zerodha": "TII123",
              "upstox": "IPO456TII",
              "groww": "TIIIPO2023"
            }
          },
          {
            "id": "2",
            "company": "Green Energy Ltd.",
            "symbol": "GEL",
            "priceRange": "₹450-₹465",
            "lotSize": "15 shares",
            "issueSize": "₹2,500 Cr",
            "openDate": "2023-06-10",
            "closeDate": "2023-06-14",
            "brokerCodes": {
              "zerodha": "GEL456",
              "upstox": "IPO789GEL",
              "groww": "GELIPO2023"
            }
          }
        ]
      }
      ''';

      final data = json.decode(mockResponse);
      setState(() {
        ipoList =
            (data['ipos'] as List).map((ipo) => IPO.fromJson(ipo)).toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load IPO data. Please try again later.';
        isLoading = false;
      });
    }
  }

  Future<void> _launchBrokerApp(IPO ipo, String broker) async {
    String deepLink = '';
    String brokerCode = ipo.brokerCodes[broker] ?? '';

    switch (broker) {
      case 'zerodha':
        deepLink = 'kite://ipo/apply?ipo_id=$brokerCode';
        break;
      case 'upstox':
        deepLink = 'upstox://ipo/apply?code=$brokerCode';
        break;
      case 'groww':
        deepLink = 'groww://open/ipo/$brokerCode';
        break;
      default:
        deepLink = 'https://www.example.com/ipo/${ipo.id}';
    }

    if (await canLaunchUrl(Uri.parse(deepLink))) {
      await launchUrl(Uri.parse(deepLink));
    } else {
      await launchUrl(
        Uri.parse('https://www.example.com/ipo/${ipo.id}'),
        mode: LaunchMode.externalApplication,
      );
    }
  }

  void _showBrokerDialog(IPO ipo) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Apply for ${ipo.company} (${ipo.symbol})'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Image.asset('assets/zerodha.png', width: 40),
                title: const Text('Zerodha'),
                onTap: () {
                  Navigator.pop(context);
                  _launchBrokerApp(ipo, 'zerodha');
                },
              ),
              ListTile(
                leading: Image.asset('assets/upstox.png', width: 40),
                title: const Text('Upstox'),
                onTap: () {
                  Navigator.pop(context);
                  _launchBrokerApp(ipo, 'upstox');
                },
              ),
              ListTile(
                leading: Image.asset('assets/groww.png', width: 40),
                title: const Text('Groww'),
                onTap: () {
                  Navigator.pop(context);
                  _launchBrokerApp(ipo, 'groww');
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final canGoBack = Navigator.canPop(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Upcoming IPOs'),
        leading: canGoBack
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              )
            : null,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: fetchIPOData,
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage))
              : ListView.builder(
                  itemCount: ipoList.length,
                  itemBuilder: (context, index) {
                    final ipo = ipoList[index];
                    return Card(
                      margin: const EdgeInsets.all(8),
                      child: InkWell(
                        onTap: () => _showBrokerDialog(ipo),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ipo.company,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text('Symbol: ${ipo.symbol}'),
                              Text('Price Range: ${ipo.priceRange}'),
                              Text('Lot Size: ${ipo.lotSize}'),
                              Text('Issue Size: ${ipo.issueSize}'),
                              Text(
                                  'Open: ${ipo.openDate} - Close: ${ipo.closeDate}'),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () => _showBrokerDialog(ipo),
                                child: const Text('Apply for IPO'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}

class IPO {
  final String id;
  final String company;
  final String symbol;
  final String priceRange;
  final String lotSize;
  final String issueSize;
  final String openDate;
  final String closeDate;
  final Map<String, String> brokerCodes;

  IPO({
    required this.id,
    required this.company,
    required this.symbol,
    required this.priceRange,
    required this.lotSize,
    required this.issueSize,
    required this.openDate,
    required this.closeDate,
    required this.brokerCodes,
  });

  factory IPO.fromJson(Map<String, dynamic> json) {
    return IPO(
      id: json['id'],
      company: json['company'],
      symbol: json['symbol'],
      priceRange: json['priceRange'],
      lotSize: json['lotSize'],
      issueSize: json['issueSize'],
      openDate: json['openDate'],
      closeDate: json['closeDate'],
      brokerCodes: Map<String, String>.from(json['brokerCodes']),
    );
  }
}

