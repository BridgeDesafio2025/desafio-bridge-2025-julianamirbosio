import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';

import '../../core/model/medium.dart';
import '../../core/app_export.dart';
import '../../core/providers/favorites_provider.dart';
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
    return Consumer<FavoritesProvider>(
      builder: (context, favoritesProvider, child) {
        final bool isFavorited = favoritesProvider.isFavorite(medium);

        return Scaffold(
          backgroundColor: AppTheme.primaryDark,
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: AppTheme.primaryDark.withAlpha(242),
                elevation: 0,
                pinned: true,
                expandedHeight: 0,
                leading: IconButton(
                  tooltip: 'Voltar', 
                  icon: const Icon(
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
                    tooltip: isFavorited ? 'Remover dos favoritos' : 'Adicionar aos favoritos',
                    icon: Icon(
                      isFavorited ? Icons.favorite : Icons.favorite_border,
                      color: isFavorited ? Colors.redAccent : AppTheme.contentWhite,
                      size: 24,
                    ),
                    onPressed: () {
                      favoritesProvider.toggleFavorite(medium);
                    },
                  ),
                  IconButton(
                    tooltip: 'Compartilhar', 
                    icon: const Icon(
                      Icons.share,
                      color: AppTheme.contentWhite,
                      size: 24,
                    ),
                    onPressed: () {},
                  ),
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
                      content: medium,
                      onShare: () {},
                    ),
                    SizedBox(height: 4.h),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}