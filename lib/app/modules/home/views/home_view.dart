import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indian_hoax_news/controller/news_controller.dart';
import 'package:indian_hoax_news/utils/app_colors.dart';
import 'package:indian_hoax_news/widgets/news_card.dart';
import 'package:indian_hoax_news/widgets/category_chip.dart';
import 'package:indian_hoax_news/widgets/loading_shimer.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeView extends GetView<NewsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: Container(
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.3),
                blurRadius: 20,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: AppBar(
            toolbarHeight: 70,
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            leadingWidth: 70,
            leading: Center(
              child: Container(
                width: 48,
                height: 48,
                margin: EdgeInsets.only(left: 12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: Icon(Icons.home_rounded, color: Colors.white, size: 24),
                  onPressed: () {
                    // Reset to home - clear search and reset category
                    controller.resetToHome();
                  },
                  tooltip: 'Home',
                  padding: EdgeInsets.zero,
                ),
              ),
            ),
            title: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                Icon(Icons.newspaper_rounded, color: Colors.white, size: 28),
                SizedBox(width: 10),
                Text(
                  'News',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
            actions: [
              Center(
                child: Container(
                  width: 48,
                  height: 48,
                  margin: EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.search_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                    onPressed: () => _showSearchDialog(context),
                    tooltip: 'Search',
                    padding: EdgeInsets.zero,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          // Search Mode Indicator - Only visible when in search mode
          Obx(() {
            if (!controller.isSearchMode) return SizedBox.shrink();

            return Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.accent.withOpacity(0.1),
                    AppColors.accentLight.withOpacity(0.1),
                  ],
                ),
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.accent.withOpacity(0.3),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      gradient: AppColors.accentGradient,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.search_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Search Results',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          '"${controller.searchQuery}"',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close_rounded,
                      color: AppColors.textSecondary,
                    ),
                    onPressed: () {
                      controller.resetToHome();
                    },
                    tooltip: 'Clear search',
                  ),
                ],
              ),
            );
          }),

          // Categories with gradient background - Hidden in search mode
          Obx(() {
            if (controller.isSearchMode) return SizedBox.shrink();

            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.cardShadow,
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 16, 20, 8),
                    child: Text(
                      'Discover',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  Container(
                    height: 54,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      itemCount: controller.categories.length,
                      itemBuilder: (context, index) {
                        final category = controller.categories[index];
                        return Obx(
                          () => CategoryChip(
                            label: category.capitalize ?? category,
                            isSelected: controller.selectedCategory == category,
                            onTap: () => controller.selectCategory(category),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }),

          // News List
          Expanded(
            child: Obx(() {
              if (controller.isLoading) {
                return LoadingShimmer();
              }

              if (controller.error.isNotEmpty) {
                return _buildErrorWidget();
              }

              if (controller.articles.isEmpty) {
                return _buildEmptyWidget();
              }

              return RefreshIndicator(
                onRefresh: controller.refreshNews,
                color: AppColors.primary,
                backgroundColor: Colors.white,
                child: ListView.builder(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 16),
                  itemCount: controller.articles.length,
                  itemBuilder: (context, index) {
                    final article = controller.articles[index];
                    return NewsCard(
                      article: article,
                      onTap: () => _showNewsDetailModal(context, article),
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: AppColors.error),
          SizedBox(height: 16),
          Text(
            'Something went wrong',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Please check your internet connection',
            style: TextStyle(color: AppColors.textSecondary),
          ),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: controller.refreshNews,
            child: Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.newspaper, size: 64, color: AppColors.textHint),
          SizedBox(height: 16),
          Text(
            'No news available',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Please try again later',
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  void _showSearchDialog(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: AppColors.cardShadow,
              blurRadius: 20,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title with icon
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.search_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  'Search News',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Input Field
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Enter keyword...',
                hintStyle: TextStyle(color: AppColors.textTertiary),
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: AppColors.primary,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: AppColors.border, width: 1.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: AppColors.border, width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: AppColors.primary, width: 2),
                ),
                filled: true,
                fillColor: AppColors.backgroundDark,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
              ),
              autofocus: true,
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  controller.searchNews(value);
                  Get.back();
                }
              },
            ),
            SizedBox(height: 20),

            // Search Button
            SizedBox(
              width: double.infinity,
              child: Container(
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.4),
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    if (searchController.text.isNotEmpty) {
                      controller.searchNews(searchController.text);
                      Get.back();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Search',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  void _showNewsDetailModal(BuildContext context, article) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.95,
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            // Drag handle
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 4),
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            // Header with close button
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(color: AppColors.divider, width: 1),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Article Details',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                      letterSpacing: -0.3,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.backgroundDark,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.close_rounded,
                        color: AppColors.textPrimary,
                      ),
                      onPressed: () => Navigator.pop(context),
                      padding: EdgeInsets.all(8),
                      constraints: BoxConstraints(),
                    ),
                  ),
                ],
              ),
            ),
            // Article content
            Expanded(
              child: Container(
                color: Colors.white,
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Article Image
                      if (article.urlToImage != null &&
                          article.urlToImage!.isNotEmpty)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            article.urlToImage!,
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: double.infinity,
                                height: 200,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  Icons.image_not_supported,
                                  size: 50,
                                  color: Colors.grey[600],
                                ),
                              );
                            },
                          ),
                        ),
                      SizedBox(height: 16),

                      // Article Title
                      Text(
                        article.title ?? 'No Title',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                          height: 1.3,
                        ),
                      ),
                      SizedBox(height: 12),

                      // Source and Date
                      Row(
                        children: [
                          if (article.source?.name != null) ...[
                            Icon(
                              Icons.source,
                              size: 16,
                              color: AppColors.primary,
                            ),
                            SizedBox(width: 4),
                            Text(
                              article.source!.name!,
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 12),
                          ],
                          if (article.publishedAt != null) ...[
                            Icon(
                              Icons.access_time,
                              size: 16,
                              color: AppColors.textSecondary,
                            ),
                            SizedBox(width: 4),
                            Text(
                              _formatDate(article.publishedAt!),
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ],
                      ),
                      SizedBox(height: 16),

                      // Divider
                      Divider(color: Colors.grey[300]),
                      SizedBox(height: 16),

                      // Article Description
                      if (article.description != null &&
                          article.description!.isNotEmpty) ...[
                        Text(
                          article.description!,
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w500,
                            height: 1.6,
                          ),
                        ),
                        SizedBox(height: 20),
                      ],

                      // Read Full Article Button (link to original source)
                      if (article.url != null && article.url!.isNotEmpty)
                        Container(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            icon: Icon(Icons.open_in_new),
                            label: Text('Read Full Article at Source'),
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () async {
                              final Uri url = Uri.parse(article.url!);
                              try {
                                if (await canLaunchUrl(url)) {
                                  await launchUrl(
                                    url,
                                    mode: LaunchMode.externalApplication,
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Could not open the article URL',
                                      ),
                                      backgroundColor: AppColors.error,
                                    ),
                                  );
                                }
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Error opening URL: $e'),
                                    backgroundColor: AppColors.error,
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to format date
  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inDays == 0) {
        if (difference.inHours == 0) {
          return '${difference.inMinutes} minutes ago';
        }
        return '${difference.inHours} hours ago';
      } else if (difference.inDays == 1) {
        return 'Yesterday';
      } else if (difference.inDays < 7) {
        return '${difference.inDays} days ago';
      } else {
        return '${date.day}/${date.month}/${date.year}';
      }
    } catch (e) {
      return dateString;
    }
  }
}
