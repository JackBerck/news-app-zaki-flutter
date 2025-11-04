import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:news_app_zaki/app/data/models/article_model.dart';
import '../controllers/bookmark_controller.dart';
import '../../../routes/app_routes.dart';

class BookmarkView extends GetView<BookmarkController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookmarks'),
        leading: IconButton(
          icon: Icon(LucideIcons.arrowLeft),
          onPressed: () => Get.back(),
        ),
        actions: [
          Obx(
            () => controller.bookmarkedArticles.isNotEmpty
                ? IconButton(
                    icon: Icon(LucideIcons.trash2),
                    onPressed: controller.clearAllBookmarks,
                  )
                : SizedBox(),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(color: Color(0xFF2563EB)),
          );
        }
        if (controller.bookmarkedArticles.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    LucideIcons.bookmark,
                    size: 64,
                    color: Colors.grey.shade400,
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  'No Bookmarks Yet',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Start saving articles to read later',
                  style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => Get.offAllNamed(Routes.HOME),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2563EB),
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Browse Articles',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: controller.bookmarkedArticles.length,
          itemBuilder: (context, index) {
            final article = controller.bookmarkedArticles[index];
            return _buildBookmarkCard(article);
          },
        );
      }),
    );
  }

  Widget _buildBookmarkCard(Article article) {
    return Dismissible(
      key: Key(article.id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        controller.removeBookmark(article.id);
      },
      background: Container(
        margin: EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        child: Icon(LucideIcons.trash2, color: Colors.white, size: 24),
      ),
      child: GestureDetector(
        onTap: () => Get.toNamed(Routes.ARTICLE_DETAIL, arguments: article),
        child: Container(
          margin: EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(12),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(12),
                  ),
                  child: Image.network(
                    article.imageUrl,
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(12),
                          ),
                        ),
                        child: Icon(
                          LucideIcons.image,
                          size: 40,
                          color: Colors.grey.shade400,
                        ),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFF2563EB).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          article.category.toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2563EB),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        article.title,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            LucideIcons.clock,
                            size: 12,
                            color: Colors.grey.shade600,
                          ),
                          SizedBox(width: 4),
                          Text(
                            article.date,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
