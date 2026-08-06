import 'package:flutter/material.dart';
import 'package:news_app/widgets/category_item.dart';
import 'package:news_app/widgets/newsData_item.dart';

class Homesreen extends StatelessWidget {
  Homesreen({super.key});
  final List<Map<String, String>> news = [
    {
      "image": "lib/assets/images/sample.png",
      "author": "Rana Mohy",
      "title": "Chhattisgarh Polls: Ex Cong MLA Blames TS Deo For Losing Power",
      "date": "June 13, 2024",
    },
    {
      "image": "lib/assets/images/sample.png",
      "author": "Rana Mohy",
      "title":
          "CM Announcement: Rajasthan BJP Chief on Delay in Govt Formation",
      "date": "June 12, 2024",
    },
    {
      "image": "lib/assets/images/sample.png",
      "author": "Rana Mohy",
      "title": "CM Announcement LIVE: BJP Legislative Party Meeting",
      "date": "June 11, 2024",
    },
    {
      "image": "lib/assets/images/sample.png",
      "author": "Rana Mohy",
      "title": "Breaking News About Politics Around The World",
      "date": "June 10, 2024",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xff001F3F),
        currentIndex: 0,
      selectedItemColor: Colors.orange,
      unselectedItemColor: Colors.white,
      items:[BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.search),label: 'Search'),
        BottomNavigationBarItem(icon: Icon(Icons.bookmark),label: 'Saved')
      
      ] ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.menu),
                    foregroundColor: Colors.black,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.search),
                        foregroundColor: Colors.black,
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.notifications_none),
                          foregroundColor: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Breaking News',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: Text(
                      'Show More',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff2C57F0),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Image.asset(
                'lib/assets/images/news.png',
                height: 139,
                width: 377,
              ),
              SizedBox(height: 8),
              SizedBox(
                height: 45,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    CategoryItem(title: 'All', selected: true),
                    CategoryItem(title: 'Politic', selected: false),
                    CategoryItem(title: 'Sport', selected: false),
                    CategoryItem(title: 'Education', selected: false),
                    CategoryItem(title: 'Science', selected: false),
                    CategoryItem(title: 'Health', selected: false),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'News For You',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: Text(
                      'Show More',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff2C57F0),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              Expanded(
                child: ListView.builder(
                  itemCount: news.length,
                  itemBuilder: (context, index) {
                    final item = news[index];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: NewsdataItem(
                        image: item["image"]!,
                        author: item["author"]!,
                        title: item["title"]!,
                        date: item["date"]!,
                      ),
                    );
                  },
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
