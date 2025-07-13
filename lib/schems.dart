import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SchemesPage(),
    );
  }
}

class SchemesPage extends StatelessWidget {
  final List<Map<String, String>> schemes = [
    {
      "title": "Pradhan Mantri Jeevan Jyoti Bima Yojana",
      "image": "assets/pmjjby.png"
    },
    {"title": "Mahila Samman Savings Certificate", "image": "assets/mssc.png"},
    {
      "title": "National Savings Certificates (VIII-Issue) Scheme",
      "image": "assets/nsc.png"
    },
    {
      "title": "Internship Programme Of The Department...",
      "image": "assets/internship1.png"
    },
    {
      "title": "Internship Scheme Of The Department Of...",
      "image": "assets/internship2.png"
    },
    {
      "title": "Pradhan Mantri Garib Kalyan Anna Yojana",
      "image": "assets/pmgkay.png"
    },
    {
      "title": "CBIC (Indirect Tax Internship Scheme)",
      "image": "assets/cbic.png"
    },
    {"title": "Pradhan Mantri Jan Dhan Yojana", "image": "assets/pmjdy.png"},
    {"title": "Stand-Up India", "image": "assets/standup.png"},
    {
      "title": "SMILE- Comprehensive Rehabilitation...",
      "image": "assets/smile.png"
    },
    {"title": "Atal Pension Yojana", "image": "assets/apy.png"},
    {"title": "NPS Vatsalya Scheme", "image": "assets/nps.png"},
    {"title": "Senior Citizens Saving Scheme", "image": "assets/scss.png"},
    {
      "title": "Pradhan Mantri Suraksha Bima Yojana",
      "image": "assets/pmsby.png"
    },
    {"title": "Pradhan Mantri Mudra Yojana", "image": "assets/pmmy.png"},
    {"title": "Post Office Monthly Income Scheme", "image": "assets/pomis.png"},
    {"title": "SEBI ITD Internship Program", "image": "assets/sebi.png"},
    {"title": "Kisan Vikas Patra Scheme", "image": "assets/kvp.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Schemes"),
        backgroundColor: Colors.grey[300],
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(0),
            color: Colors.grey[300],
            width: double.infinity,
            child: const Text(
              "",
              style: TextStyle(fontSize: 0, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.9,
                  ),
                  itemCount: schemes.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // Navigate to details page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SchemeDetailPage(
                              title: schemes[index]['title']!,
                              imagePath: schemes[index]['image']!,
                            ),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Image.asset(
                                schemes[index]["image"]!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.image_not_supported,
                                        size: 50),
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            schemes[index]["title"]!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 12),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// New Page to Show Scheme Details
class SchemeDetailPage extends StatelessWidget {
  final String title;
  final String imagePath;

  const SchemeDetailPage(
      {super.key, required this.title, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scheme Details"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                height: 150,
                width: 150,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.image_not_supported, size: 100),
              ),
              const SizedBox(height: 20),
              Text(
                title,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}