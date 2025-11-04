import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../controllers/search_controller.dart' as my;

class SearchView extends GetView<my.SearchController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
        leading: IconButton(
          icon: Icon(LucideIcons.arrowLeft),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
            ),
            child: TextField(
              controller: controller.searchController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Search news...',
                prefixIcon: Icon(LucideIcons.search, size: 20),
                suffixIcon: IconButton(
                  icon: Icon(LucideIcons.x, size: 20),
                  onPressed: () => controller.searchController.clear(),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Color(0xFF2563EB), width: 2),
                ),
                filled: true,
                fillColor: Colors.grey.shade50,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
              onSubmitted: controller.search,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => controller.searchHistory.isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Recent Searches',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: controller.clearHistory,
                                    child: Text(
                                      'Clear All',
                                      style: TextStyle(
                                        color: Color(0xFF2563EB),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              ...controller.searchHistory.map((query) {
                                return ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  leading: Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      LucideIcons.clock,
                                      size: 20,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                  title: Text(
                                    query,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(
                                      LucideIcons.x,
                                      size: 18,
                                      color: Colors.grey.shade600,
                                    ),
                                    onPressed: () =>
                                        controller.removeFromHistory(query),
                                  ),
                                  onTap: () {
                                    controller.searchController.text = query;
                                    controller.search(query);
                                  },
                                );
                              }).toList(),
                              SizedBox(height: 32),
                            ],
                          )
                        : SizedBox(),
                  ),
                  Text(
                    'Popular Searches',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 16),
                  Obx(
                    () => Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: controller.popularSearches.map((search) {
                        return GestureDetector(
                          onTap: () {
                            controller.searchController.text = search;
                            controller.search(search);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  LucideIcons.trendingUp,
                                  size: 16,
                                  color: Color(0xFF2563EB),
                                ),
                                SizedBox(width: 6),
                                Text(
                                  search,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
