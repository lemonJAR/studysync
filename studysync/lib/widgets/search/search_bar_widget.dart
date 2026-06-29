import 'package:flutter/material.dart';
import '../../config/spacing.dart';

class SearchBarWidget extends StatelessWidget {
  final String? hintText;
  final String searchQuery;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback? onClear;

  const SearchBarWidget({
    Key? key,
    this.hintText = 'Search tasks...',
    required this.searchQuery,
    required this.onSearchChanged,
    this.onClear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Icon(Icons.search, color: Colors.grey[600]),
            AppSpacing.gapHorizontalMd,
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: hintText,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                ),
                onChanged: onSearchChanged,
              ),
            ),
            if (searchQuery.isNotEmpty)
              GestureDetector(
                onTap: onClear,
                child: Icon(Icons.clear, color: Colors.grey[600]),
              ),
          ],
        ),
      ),
    );
  }
}