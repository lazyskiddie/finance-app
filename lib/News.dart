import 'package:financetalk07/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(FinanceNewsApp());
}

class FinanceNewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Finance News',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: FinanceNewsPage(),
    );
  }
}

class FinanceNewsPage extends StatefulWidget {
  @override
  _FinanceNewsPageState createState() => _FinanceNewsPageState();
}

class _FinanceNewsPageState extends State<FinanceNewsPage> {
  final String apiKey = 'enter_your_api';
  final String apiUrl = 'https://newsapi.org/v2/everything?q=finance&apiKey=';

  List articles = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFinanceNews();
  }

  Future<void> fetchFinanceNews() async {
    final response = await http.get(Uri.parse('$apiUrl$apiKey'));

    if (response.statusCode == 200) {
      setState(() {
        articles = json.decode(response.body)['articles'];
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to load news');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finance News'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => FinanceTalkHome(),
              ),
            ); // Navigates back to the previous screen
          },
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : articles.isEmpty
              ? const Center(
                  child: Text(
                    'No finance news available.',
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : ListView.builder(
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    var article = articles[index];
                    return NewsCard(
                      title: article['title'] ?? 'No Title',
                      description: article['description'] ?? 'No Description',
                      urlToImage: article['urlToImage'] ??
                          'https://via.placeholder.com/150',
                      url: article['url'],
                    );
                  },
                ),
    );
  }
}

class NewsCard extends StatelessWidget {
  final String title;
  final String description;
  final String urlToImage;
  final String url;

  const NewsCard({
    Key? key,
    required this.title,
    required this.description,
    required this.urlToImage,
    required this.url,
  }) : super(key: key);

  void _openNewsUrl(BuildContext context, String url) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Opening: $url')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: InkWell(
        onTap: () => _openNewsUrl(context, url),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                urlToImage,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 180,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: const Center(child: Icon(Icons.broken_image)),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
