import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_model/search_history_provider/search_history.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SearchProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text('Search', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        actions: const [
          Icon(Icons.more_horiz, color: Colors.black),
          SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            _buildSearchBar(provider),
            const SizedBox(height: 24),
            const Text(
              'Search History',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: provider.searchHistory.length,
                itemBuilder: (context, index) {
                  return _buildHistoryItem(provider, provider.searchHistory[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(SearchProvider provider) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.grey),
          const SizedBox(width: 8),
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(fontWeight: FontWeight.w500),
                border: InputBorder.none,
              ),
            ),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              provider.selectProduct(value);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: "Shirt", child: Text("Shirt")),
              const PopupMenuItem(value: "Chair", child: Text("Chair")),
              const PopupMenuItem(value: "Smart TV", child: Text("Smart TV")),
              const PopupMenuItem(value: "Laptop", child: Text("Laptop")),
            ],
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xffE0E0E0)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    provider.selectedProduct,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xffA5A5AB),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Icon(Icons.keyboard_arrow_down, size: 18),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(SearchProvider provider, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          const Icon(Icons.access_time_outlined, color: Colors.grey),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.grey),
            onPressed: () {
              provider.removeHistory(text);
            },
          ),
        ],
      ),
    );
  }
}