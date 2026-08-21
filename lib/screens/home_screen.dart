import 'package:flutter/material.dart';
import 'package:news_app/widgets/news_card.dart';
import 'package:news_app/widgets/category_chip_bar.dart';
import 'package:news_app/widgets/animated_bottom_nav.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/services/news_service.dart';
import 'package:news_app/screens/search_screen.dart';
import 'package:news_app/screens/news_detail_screen.dart';
import 'package:news_app/features/ai_chat/presentation/pages/ai_chat_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<ArticleModel>> futureArticles;
  String _selectedCategory = 'All';
  final List<String> _categories = ['All', 'Politic', 'Sport', 'Education'];
  int _bottomNavIndex = 0; // State for the bottom navigation bar

  @override
  void initState() {
    super.initState();
    _fetchNewsForCategory(_selectedCategory);
  }

  void _fetchNewsForCategory(String category) {
    setState(() {
      _selectedCategory = category;
      final query = category == 'All' ? 'news' : category;
      futureArticles = NewsService().fetchNews(query: query);
    });
  }

  Widget _placeholderImage() {
    return Container(
      height: 200,
      width: double.infinity,
      color: Colors.grey[300],
      child: const Icon(Icons.image, size: 50, color: Colors.grey),
    );
  }

  // The main news feed body
  Widget _buildHomeBody() {
    return FutureBuilder<List<ArticleModel>>(
      future: futureArticles,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No news available'));
        }

        final articles = snapshot.data!;
        final breakingNews = articles.first;
        final newsForYou = articles.skip(1).toList();

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Breaking News',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Show More', style: TextStyle(color: Colors.blue)),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewsDetailScreen(article: breakingNews),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: breakingNews.urlToImage != null && breakingNews.urlToImage!.isNotEmpty
                      ? Image.network(
                          breakingNews.urlToImage!,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => _placeholderImage(),
                        )
                      : _placeholderImage(),
                ),
              ),
              const SizedBox(height: 20),
              CategoryChipBar(
                categories: _categories,
                selectedCategory: _selectedCategory,
                onCategorySelected: _fetchNewsForCategory,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'News For You',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Show More', style: TextStyle(color: Colors.blue)),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: newsForYou.length,
                itemBuilder: (context, index) {
                  final article = newsForYou[index];
                  return NewsCard(article: article);
                },
              ),
              const SizedBox(height: 40),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Important for the curved bottom nav to look right
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.chat_outlined, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AiChatPage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {
              setState(() {
                _bottomNavIndex = 1;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: IndexedStack(
        index: _bottomNavIndex,
        children: [
          _buildHomeBody(),
          SearchScreen(
            onBack: () {
              setState(() {
                _bottomNavIndex = 0;
              });
            },
          ),
        ],
      ),
      bottomNavigationBar: AnimatedCurvedNavigationBar(
        selectedIndex: _bottomNavIndex,
        onItemTapped: (index) {
          setState(() {
            _bottomNavIndex = index;
          });
        },
      ),
    );
  }
}
