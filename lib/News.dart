import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: NewsPage(),
  ));
}

class NewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
        backgroundColor: Colors.grey[400],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Use ListView.builder for the news list
            ListView.builder(
              itemCount: newsData.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(), // Prevent ListView from scrolling independently
              itemBuilder: (context, index) {
                return NewsTile(
                  newsText: newsData[index], // Displaying each news
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// NewsTile Widget for individual news item
class NewsTile extends StatelessWidget {
  final String newsText;

  NewsTile({required this.newsText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[300],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.grey,
            child: Icon(Icons.person, color: Colors.white), // Placeholder icon for avatar
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              newsText,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

// Dummy data for the news items
final List<String> newsData = [
  'For long-term investors, time to be contrarian yet selective: 6 mid-cap stocks from different sectors with upside potential of up to 52%',
  'Stock picks of the week: 5 stocks with consistent score improvement and upside potential of more than 37%',
  'Staying bullish & volatility-ready is the solution: 7 large-caps from different sectors with an upside potential of up to 44%',
  'Necessary pill for portfolio during volatility and Trump tariff wars: 8 pharma stocks with an upside potential of up to 48%',
  'Stock Radar: MCX breaks out from double bottom pattern; should investors buy, sell or hold?',
  'These mid-cap stocks with ‘strong buy’ & ‘buy’ recos can rally over 30%, according to analysts',
  'These 6 banking stocks can give more than 27% returns in 1 year, according to analysts',
  'Cannot be underperformers beyond a point: 7 stocks from different financial services segments, with upside potential of more than 42%',
  'A little hard work in volatile times goes a long way in giving medium- to long-term returns: 5 small-caps that tick the right boxes',
];
