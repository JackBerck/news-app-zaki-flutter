import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  final searchController = TextEditingController();
  final searchHistory = <String>[
    'Breaking news today',
    'Technology updates',
    'Sports highlights',
    'Business trends',
    'World news',
  ].obs;

  final popularSearches = <String>[
    'COVID-19 Update',
    'Climate Change',
    'Stock Market',
    'Football World Cup',
    'AI Technology',
    'Cryptocurrency',
  ].obs;

  void search(String query) {
    if (query.isNotEmpty && !searchHistory.contains(query)) {
      searchHistory.insert(0, query);
      Get.snackbar(
        'Search',
        'Searching for: $query',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
      );
    }
  }

  void removeFromHistory(String query) {
    searchHistory.remove(query);
  }

  void clearHistory() {
    searchHistory.clear();
    Get.snackbar(
      'Success',
      'Search history cleared',
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
    );
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
