import 'package:get/get.dart';
import '../../../data/models/article_model.dart';

class ArticleDetailController extends GetxController {
  late Article article;
  final isBookmarked = false.obs;

  @override
  void onInit() {
    super.onInit();
    article = Get.arguments as Article;
    isBookmarked.value = article.isBookmarked;
  }

  void toggleBookmark() {
    isBookmarked.value = !isBookmarked.value;
    Get.snackbar(
      'Success',
      isBookmarked.value ? 'Article bookmarked' : 'Bookmark removed',
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
    );
  }

  void shareArticle() {
    Get.snackbar(
      'Share',
      'Share functionality would be implemented here',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
