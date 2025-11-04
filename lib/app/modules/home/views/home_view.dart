import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:news_app_zaki/app/data/models/article_model.dart';
import '../controllers/home_controller.dart';
import '../../../routes/app_routes.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(LucideIcons.newspaper, color: Color(0xFF2563EB), size: 28),
            SizedBox(width: 12),
            Text('News Portal'),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(LucideIcons.search),
            onPressed: () => Get.toNamed(Routes.SEARCH),
          ),
          IconButton(
            icon: Icon(LucideIcons.bookmark),
            onPressed: () => Get.toNamed(Routes.BOOKMARK),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade200, width: 1),
              ),
            ),
            child: TabBar(
              controller: controller.tabController,
              isScrollable: true,
              labelColor: Color(0xFF2563EB),
              unselectedLabelColor: Colors.grey.shade600,
              labelStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              unselectedLabelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(color: Color(0xFF2563EB), width: 3),
                insets: EdgeInsets.symmetric(horizontal: 16),
              ),
              tabs: controller.tabs.map((tab) => Tab(text: tab)).toList(),
            ),
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(color: Color(0xFF2563EB)),
          );
        }

        return TabBarView(
          controller: controller.tabController,
          children: controller.tabs.map((category) {
            return _buildArticleList(category);
          }).toList(),
        );
      }),
    );
  }

  Widget _buildArticleList(String category) {
    final articles = controller.getArticles(category);

    if (articles.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(LucideIcons.fileText, size: 64, color: Colors.grey.shade300),
            SizedBox(height: 16),
            Text(
              'No articles available',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final article = articles[index];
        return _buildArticleCard(article);
      },
    );
  }

  Widget _buildArticleCard(Article article) {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.ARTICLE_DETAIL, arguments: article),
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                article.imageUrl,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 180,
                    width: double.infinity,
                    color: Colors.grey.shade200,
                    child: Icon(
                      LucideIcons.image,
                      size: 48,
                      color: Colors.grey.shade400,
                    ),
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    height: 180,
                    width: double.infinity,
                    color: Colors.grey.shade200,
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                            : null,
                        color: Color(0xFF2563EB),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Color(0xFF2563EB).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      article.category.toUpperCase(),
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2563EB),
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    article.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(
                        LucideIcons.user,
                        size: 14,
                        color: Colors.grey.shade600,
                      ),
                      SizedBox(width: 6),
                      Text(
                        article.author,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      SizedBox(width: 16),
                      Icon(
                        LucideIcons.clock,
                        size: 14,
                        color: Colors.grey.shade600,
                      ),
                      SizedBox(width: 6),
                      Text(
                        article.date,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
