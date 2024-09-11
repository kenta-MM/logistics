import 'package:flutter/material.dart';

class SearchFilterSection extends StatelessWidget {
  final TextEditingController searchController;
  final VoidCallback onSearch;

  SearchFilterSection({
    required this.searchController,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: '検索',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(width: 10),
          ElevatedButton(
            onPressed: onSearch,
            child: Text('検索'),
          ),
        ],
      ),
    );
  }
}
