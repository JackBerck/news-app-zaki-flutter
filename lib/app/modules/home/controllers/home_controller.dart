import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../data/models/article_model.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  final currentTab = 0.obs;
  final isLoading = true.obs;
  final allArticles = <Article>[].obs;

  final List<String> tabs = ['Berita Utama', 'Teknologi', 'Olahraga', 'Bisnis'];

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: tabs.length, vsync: this);
    tabController.addListener(() {
      currentTab.value = tabController.index;
    });
    loadArticles();
  }

  Future<void> loadArticles() async {
    try {
      isLoading.value = true;
      final String jsonString = await rootBundle.loadString(
        'assets/new_data.json',
      );
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      allArticles.value = (jsonData['articles'] as List)
          .map(
            (article) => Article(
              id: article['id'],
              title: article['title'],
              author: article['author'],
              date: article['date'],
              category: article['category'],
              imageUrl: article['imageUrl'],
              content: article['content'],
              isBookmarked: false,
            ),
          )
          .toList();

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'Failed to load articles: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
      );
    }
  }

  List<Article> getArticles(String category) {
    return allArticles
        .where((article) => article.category == category)
        .toList();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
