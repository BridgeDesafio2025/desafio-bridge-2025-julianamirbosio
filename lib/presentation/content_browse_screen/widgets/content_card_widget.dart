import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';
import '../../../core/model/medium.dart';

class ContentCardWidget extends StatelessWidget {
  final Medium content;
  final VoidCallback? onTap;
  final VoidCallback? onFavorite;
  final VoidCallback? onShare;

  const ContentCardWidget({
    super.key,
    required this.content,
    this.onTap,
    this.onFavorite,
    this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: () => _showQuickActions(context),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        decoration: BoxDecoration(
          color: AppTheme.darkTheme.cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPosterImage(),
            _buildContentInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildPosterImage() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: CustomImageWidget(
          imageUrl: content.poster,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildContentInfo() {
    return Padding(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            content.title,
            style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 1.h),
          _buildGenreTags(),
          SizedBox(height: 1.h),
          Row(
            children: [
              _buildRatingStars(),
              const Spacer(),
              _buildPlatformLogo(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGenreTags() {
    final genres = content.genres;

    return Wrap(
      spacing: 2.w,
      runSpacing: 0.5.h,
      children: genres.take(3).map((genre) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
          decoration: BoxDecoration(
            color: AppTheme.successColor.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppTheme.successColor.withValues(alpha: 0.3),
            ),
          ),
          child: Text(
            genre,
            style: AppTheme.darkTheme.textTheme.labelSmall?.copyWith(
              color: AppTheme.successColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildRatingStars() {
    final rating = content.rating;
    final fullStars = rating.floor();
    final hasHalfStar = rating - fullStars >= 0.5;

    return Row(
      children: [
        ...List.generate(5, (index) {
          if (index < fullStars) {
            return Icon(
              Icons.star,
              color: AppTheme.warningColor,
              size: 16,
            );
          } else if (index == fullStars && hasHalfStar) {
            return Icon(
              Icons.star_half,
              color: AppTheme.warningColor,
              size: 16,
            );
          } else {
            return Icon(
              Icons.star_border,
              color: AppTheme.mutedText,
              size: 16,
            );
          }
        }),
        SizedBox(width: 2.w),
        Text(
          rating.toStringAsFixed(1),
          style: AppTheme.darkTheme.textTheme.labelMedium?.copyWith(
            color: AppTheme.mutedText,
          ),
        ),
      ],
    );
  }

  Widget _buildPlatformLogo() {
    final platform = 'Amazon';

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
      decoration: BoxDecoration(
        color: AppTheme.accentColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        platform,
        style: AppTheme.darkTheme.textTheme.labelSmall?.copyWith(
          color: AppTheme.accentColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  void _showQuickActions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.darkTheme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(6.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12.w,
              height: 0.5.h,
              decoration: BoxDecoration(
                color: AppTheme.borderColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: 3.h),
            ListTile(
              leading: Icon(
                Icons.favorite_border,
                color: AppTheme.accentColor,
                size: 24,
              ),
              title: Text(
                'Adicionar aos Favoritos',
                style: AppTheme.darkTheme.textTheme.bodyMedium,
              ),
              onTap: () {
                Navigator.pop(context);
                onFavorite?.call();
              },
            ),
            ListTile(
              leading: Icon(
                Icons.share,
                color: AppTheme.successColor,
                size: 24,
              ),
              title: Text(
                'Compartilhar Conteúdo',
                style: AppTheme.darkTheme.textTheme.bodyMedium,
              ),
              onTap: () {
                Navigator.pop(context);
                onShare?.call();
              },
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }
}
