import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(StockApp());
}

class StockApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Finance Stocks',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: StockScreen(),
    );
  }
}

class StockScreen extends StatefulWidget {
  @override
  _StockScreenState createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  final String apiKey =
      'cvgvcgpr01qi76d5iq8gcvgvcgpr01qi76d5iq90'; // Add your Finnhub API key here
  final List<String> financeStocks = [
    'AAPL', // Apple
    'MSFT', // Microsoft
    'GOOGL', // Google
    'AMZN', // Amazon
    'TSLA', // Tesla
    'JPM', // JPMorgan Chase
    'V', // Visa
    'MA', // Mastercard
    'BAC', // Bank of America
    'PYPL', // PayPal
    'NFLX', // Netflix
    'FB', // Meta (Facebook)
    'INTC', // Intel
    'NVDA', // Nvidia
    'ADBE', // Adobe
  ];

  List<Map<String, dynamic>> stockData = [];
  List<Map<String, dynamic>> filteredStocks = [];
  bool isLoading = true;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchStockData();
  }

  Future<void> _fetchStockData() async {
    List<Map<String, dynamic>> tempStockData = [];

    for (String symbol in financeStocks) {
      final String url =
          'https://finnhub.io/api/v1/quote?symbol=$symbol&token=$apiKey';

      try {
        final response = await http.get(Uri.parse(url));

        if (response.statusCode == 200) {
          final data = json.decode(response.body);

          if (data != null && data['c'] != null) {
            tempStockData.add({
              'name': symbol,
              'symbol': symbol,
              'price': data['c'], // Current price
              'change':
                  ((data['c'] - data['pc']) / data['pc']) * 100, // % change
            });
          }
        }
      } catch (e) {
        print('Error fetching data for $symbol: $e');
      }
    }

    setState(() {
      stockData = tempStockData;
      filteredStocks = tempStockData;
      isLoading = false;
    });
  }

  void _filterStocks(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredStocks = stockData;
      } else {
        filteredStocks = stockData
            .where((stock) =>
                stock['name']
                    .toString()
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                stock['symbol']
                    .toString()
                    .toLowerCase()
                    .contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text(
          'Finance Stocks',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.grey[300],
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.black),
            onPressed: _fetchStockData,
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 5,
                    offset: const Offset(0, 2)),
              ],
            ),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                hintText: 'Search for stocks...',
                border: InputBorder.none,
                icon: Icon(Icons.search, color: Colors.grey),
              ),
              onChanged: _filterStocks,
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                    onRefresh: _fetchStockData,
                    child: ListView.builder(
                      itemCount: filteredStocks.length,
                      itemBuilder: (context, index) {
                        final stock = filteredStocks[index];
                        final double changePercent = stock['change'] ?? 0.0;

                        return Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(12),
                            leading: CircleAvatar(
                              backgroundColor: changePercent >= 0
                                  ? Colors.green
                                  : Colors.red,
                              child: Text(
                                stock['symbol'][0],
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                            title: Text(
                              stock['name'] ?? 'Unknown',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              'Symbol: ${stock['symbol']}',
                              style: const TextStyle(color: Colors.grey),
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '\$${stock['price'].toStringAsFixed(2)}',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${changePercent.toStringAsFixed(2)}%',
                                  style: TextStyle(
                                    color: changePercent >= 0
                                        ? Colors.green
                                        : Colors.red,
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
          ),
        ],
      ),
    );
  }
}