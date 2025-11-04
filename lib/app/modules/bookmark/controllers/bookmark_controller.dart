import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../data/models/article_model.dart';

class BookmarkController extends GetxController {
  final bookmarkedArticles = <Article>[].obs;
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadBookmarks();
  }

  Future<void> loadBookmarks() async {
    try {
      isLoading.value = true;
      final String jsonString = await rootBundle.loadString(
        'assets/new_data.json',
      );
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      // Ambil 5 artikel pertama sebagai contoh bookmark
      bookmarkedArticles.value = (jsonData['articles'] as List)
          .take(5)
          .map(
            (article) => Article(
              id: article['id'],
              title: article['title'],
              author: article['author'],
              date: article['date'],
              category: article['category'],
              imageUrl: article['imageUrl'],
              content: article['content'],
              isBookmarked: true,
            ),
          )
          .toList();

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'Failed to load bookmarks: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void removeBookmark(String articleId) {
    bookmarkedArticles.removeWhere((article) => article.id == articleId);
    Get.snackbar(
      'Success',
      'Article removed from bookmarks',
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
    );
  }

  void clearAllBookmarks() {
    Get.defaultDialog(
      title: 'Clear All Bookmarks',
      middleText: 'Are you sure you want to remove all bookmarks?',
      textConfirm: 'Yes',
      textCancel: 'No',
      confirmTextColor: Colors.white,
      onConfirm: () {
        bookmarkedArticles.clear();
        Get.back();
        Get.snackbar(
          'Success',
          'All bookmarks cleared',
          snackPosition: SnackPosition.BOTTOM,
        );
      },
    );
  }
}
