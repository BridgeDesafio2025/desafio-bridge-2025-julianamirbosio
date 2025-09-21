import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../../locator.dart';

import '../../../core/app_export.dart';

class UserRatingsWidget extends StatefulWidget {
  final int mediumId;

  const UserRatingsWidget({
    super.key,
    required this.mediumId,
  });

  @override
  State<UserRatingsWidget> createState() => _UserRatingsWidgetState();
}

class _UserRatingsWidgetState extends State<UserRatingsWidget> {
  final MediaService _mediaService = locator<MediaService>();
  Map<String, dynamic>? _userRatings;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRatings().then((ratings) {
      if (!mounted) return;
      setState(() {
        _userRatings = ratings;
        _isLoading = false;
      });
    });
  }

  Future<Map<String, dynamic>?> _loadRatings() async {
    try {
      return await _mediaService.getMediumRatings(widget.mediumId);
    } catch (e) {
      if (mounted) {
        Fluttertoast.showToast(
          msg: 'Erro ao carregar avaliações: $e',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: AppTheme.darkTheme.colorScheme.surface,
          textColor: AppTheme.contentWhite,
        );
      }
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasError = !_isLoading && (_userRatings == null);
    if (hasError) return const SizedBox.shrink();

    if (_isLoading)
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        height: 22.h,
        color: AppTheme.secondaryDark.withValues(alpha: 0.3),
        child: Center(
          child: CircularProgressIndicator(
            color: AppTheme.accentColor,
          ),
        ),
      );

    final double averageRating = (_userRatings!['averageRating'] as num?)?.toDouble() ?? 8.5;
    final int totalReviews = _userRatings!['totalReviews'] ?? 1250;
    final List<Map<String, dynamic>> ratingBreakdown = (_userRatings!['breakdown'] as List?)?.cast<Map<String, dynamic>>() ?? [];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Avaliações dos Usuários',
            style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
              color: AppTheme.contentWhite,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2.h),
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: AppTheme.secondaryDark,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.borderColor.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              children: [
                Column(
                  children: [
                    Text(
                      averageRating.toStringAsFixed(1),
                      style: AppTheme.darkTheme.textTheme.headlineMedium?.copyWith(
                        color: AppTheme.warningColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 0.5.h),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(5, (index) {
                        if (index < averageRating.floor()) {
                          return Icon(
                            Icons.star,
                            color: AppTheme.warningColor,
                            size: 16,
                          );
                        } else if (index < averageRating &&
                            (averageRating - averageRating.floor()) >= 0.5) {
                          return Icon(
                            Icons.star_half,
                            color: AppTheme.warningColor,
                            size: 16,
                          );
                        } else {
                          return Icon(
                            Icons.star_border,
                            color: AppTheme.warningColor,
                            size: 16,
                          );
                        }
                      }),
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      '$totalReviews avaliações',
                      style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.mutedText,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 6.w),
                Expanded(
                  child: Column(
                    children: ratingBreakdown.map((rating) {
                      final int stars = rating['stars'] ?? 5;
                      final double percentage =
                          (rating['percentage'] as num?)?.toDouble() ?? 0.0;

                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 0.5.h),
                        child: Row(
                          children: [
                            Text(
                              '$stars',
                              style: AppTheme.darkTheme.textTheme.bodySmall
                                  ?.copyWith(
                                color: AppTheme.mutedText,
                              ),
                            ),
                            SizedBox(width: 2.w),
                            Icon(
                              Icons.star,
                              color: AppTheme.warningColor,
                              size: 12,
                            ),
                            SizedBox(width: 2.w),
                            Expanded(
                              child: Container(
                                height: 0.5.h,
                                decoration: BoxDecoration(
                                  color: AppTheme.borderColor
                                      .withValues(alpha: 0.3),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                child: FractionallySizedBox(
                                  alignment: Alignment.centerLeft,
                                  widthFactor: percentage / 100,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppTheme.warningColor,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 2.w),
                            Text(
                              '${percentage.toInt()}%',
                              style: AppTheme.darkTheme.textTheme.bodySmall
                                  ?.copyWith(
                                color: AppTheme.mutedText,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
