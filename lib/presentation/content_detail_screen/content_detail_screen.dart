import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/model/medium.dart';
import '../../core/app_export.dart';
import './widgets/action_buttons_widget.dart';
import './widgets/cast_section_widget.dart';
import './widgets/genre_chips_widget.dart';
import './widgets/hero_section_widget.dart';
import './widgets/streaming_platforms_widget.dart';
import './widgets/synopsis_section_widget.dart';
import './widgets/user_ratings_widget.dart';

class ContentDetailScreen extends StatelessWidget {
  final Medium medium;

  const ContentDetailScreen({
    super.key,
    required this.medium,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryDark,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppTheme.primaryDark.withValues(alpha: 0.95),
            elevation: 0,
            pinned: true,
            expandedHeight: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: AppTheme.contentWhite,
                size: 24,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              medium.title,
              style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                color: AppTheme.contentWhite,
                fontWeight: FontWeight.w600,
              ),
            ),
            actions: [
              IconButton(
                  icon: Icon(
                    Icons.favorite_border,
                    color: AppTheme.contentWhite,
                    size: 24,
                  ),
                  onPressed: () {
                    
                  }),
              IconButton(
                  icon: Icon(
                    Icons.share,
                    color: AppTheme.contentWhite,
                    size: 24,
                  ),
                  onPressed: () {
                    
                  }),
              SizedBox(width: 2.w),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeroSectionWidget(
                  contentData: medium,
                ),
                GenreChipsWidget(
                  genres: medium.genres,
                ),
                SynopsisSectionWidget(
                  synopsis: medium.synopsis,
                ),
                SizedBox(height: 2.h),
                CastSectionWidget(
                  mediumId: medium.id,
                ),
                SizedBox(height: 2.h),
                StreamingPlatformsWidget(
                  platforms: medium.streamingPlatforms,
                ),
                SizedBox(height: 2.h),
                UserRatingsWidget(
                  mediumId: medium.id,
                ),
                SizedBox(height: 2.h),
                ActionButtonsWidget(
                  isInWatchlist: false,
                  onWatchlistToggle: () {
                    
                  },
                  onShare: () {
                    
                  },
                ),
                SizedBox(height: 4.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
