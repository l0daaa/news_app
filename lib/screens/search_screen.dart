import 'package:flutter/material.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/services/news_service.dart';
import 'package:news_app/widgets/search_result_card.dart';

class SearchScreen extends StatefulWidget {
  final VoidCallback onBack;

  const SearchScreen({super.key, required this.onBack});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  Future<List<ArticleModel>>? _futureArticles;

  void _performSearch() {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      setState(() {
        _futureArticles = NewsService().fetchNews(query: query);
      });
    } else {
      setState(() {
        _futureArticles = null;
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Custom Header matching the design
        Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0, bottom: 20.0),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: widget.onBack,
              ),
              const Expanded(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(right: 48.0), // offset for back button to keep text perfectly centered
                    child: Text(
                      'Search results',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Search Input Field
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextField(
            controller: _searchController,
            onSubmitted: (_) => _performSearch(),
            decoration: InputDecoration(
              hintText: 'Search for news...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _searchController.clear();
                  _performSearch();
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 20),
        // Search Results List
        Expanded(
          child: _futureArticles == null
              ? const Center(child: Text('Please enter a search term.'))
              : FutureBuilder<List<ArticleModel>>(
                  future: _futureArticles,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No results found.'));
                    }

                    final articles = snapshot.data!;
                    return ListView.builder(
                      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 100), // Padding for the bottom nav bar
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        return SearchResultCard(article: articles[index]);
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }
}

