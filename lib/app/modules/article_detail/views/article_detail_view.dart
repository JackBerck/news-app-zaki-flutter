import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../controllers/article_detail_controller.dart';

class ArticleDetailView extends GetView<ArticleDetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  LucideIcons.arrowLeft,
                  color: Colors.black87,
                  size: 20,
                ),
              ),
              onPressed: () => Get.back(),
            ),
            actions: [
              IconButton(
                icon: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    LucideIcons.share2,
                    color: Colors.black87,
                    size: 20,
                  ),
                ),
                onPressed: controller.shareArticle,
              ),
              SizedBox(width: 8),
              Obx(
                () => IconButton(
                  icon: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      controller.isBookmarked.value
                          ? LucideIcons.bookmark
                          : LucideIcons.bookmark,
                      color: controller.isBookmarked.value
                          ? Color(0xFF2563EB)
                          : Colors.black87,
                      size: 20,
                    ),
                  ),
                  onPressed: controller.toggleBookmark,
                ),
              ),
              SizedBox(width: 16),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                controller.article.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade200,
                    child: Center(
                      child: Icon(
                        LucideIcons.image,
                        size: 64,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Color(0xFF2563EB).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      controller.article.category.toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2563EB),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    controller.article.title,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      height: 1.3,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Color(0xFF2563EB).withOpacity(0.1),
                        child: Icon(
                          LucideIcons.user,
                          color: Color(0xFF2563EB),
                          size: 20,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.article.author,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 2),
                            Row(
                              children: [
                                Icon(
                                  LucideIcons.clock,
                                  size: 14,
                                  color: Colors.grey.shade600,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  controller.article.date,
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
                  SizedBox(height: 28),
                  Divider(color: Colors.grey.shade200, thickness: 1),
                  SizedBox(height: 24),
                  Text(
                    controller.article.content * 5,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.8,
                      color: Colors.black87,
                      letterSpacing: 0.2,
                    ),
                  ),
                  SizedBox(height: 32),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              LucideIcons.info,
                              color: Color(0xFF2563EB),
                              size: 20,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'About this article',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        _buildInfoRow('Published', controller.article.date),
                        SizedBox(height: 8),
                        _buildInfoRow('Author', controller.article.author),
                        SizedBox(height: 8),
                        _buildInfoRow('Category', controller.article.category),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 90,
          child: Text(
            label,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
        ),
        Text(': ', style: TextStyle(fontSize: 14, color: Colors.grey.shade600)),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}
