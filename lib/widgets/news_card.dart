import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:indian_hoax_news/models/news_article.dart';
import 'package:indian_hoax_news/utils/app_colors.dart';

class NewsCard extends StatelessWidget {
  final NewsArticle article;
  final VoidCallback onTap;

  const NewsCard({Key? key, required this.article, required this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 10,
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image with Badge
              if (article.urlToImage != null)
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: article.urlToImage!,
                        height: 220,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          height: 220,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.shimmerBase,
                                AppColors.shimmerHighlight,
                                AppColors.shimmerBase,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          height: 220,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.backgroundDark,
                                AppColors.background,
                              ],
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.newspaper,
                              size: 50,
                              color: AppColors.textTertiary,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Gradient overlay at bottom of image
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 80,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.7),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Source Badge
                    if (article.source?.name != null)
                      Positioned(
                        top: 12,
                        left: 12,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withOpacity(0.4),
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.language,
                                size: 14,
                                color: Colors.white,
                              ),
                              SizedBox(width: 4),
                              Text(
                                article.source!.name!,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),

              // Content
              Padding(
                padding: EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Time Badge
                    if (article.publishedAt != null)
                      Container(
                        margin: EdgeInsets.only(bottom: 12),
                        child: Row(
                          children: [
                            Icon(
                              Icons.access_time_rounded,
                              size: 14,
                              color: AppColors.accent,
                            ),
                            SizedBox(width: 4),
                            Text(
                              timeago.format(
                                DateTime.parse(article.publishedAt!),
                              ),
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),

                    // Title
                    if (article.title != null)
                      Text(
                        article.title!,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                          height: 1.4,
                          letterSpacing: -0.3,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),

                    SizedBox(height: 10),

                    // Description
                    if (article.description != null)
                      Text(
                        article.description!,
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                          height: 1.6,
                          letterSpacing: 0.1,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                    SizedBox(height: 12),

                    // Read More indicator
                    Row(
                      children: [
                        Text(
                          'Read more',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward_rounded,
                          size: 14,
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
