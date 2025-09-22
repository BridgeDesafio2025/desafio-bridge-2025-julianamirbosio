import 'package:flutter/material.dart';
import 'package:movies__series_app/core/enums/media_type.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';
import '../../../core/model/medium.dart';

class SynopsisSectionWidget extends StatefulWidget {
  final Medium medium;

  const SynopsisSectionWidget({
    super.key,
    required this.medium,
  });

  @override
  State<SynopsisSectionWidget> createState() => _SynopsisSectionWidgetState();
}

class _SynopsisSectionWidgetState extends State<SynopsisSectionWidget> {
  bool _isExpanded = false;
  static const int _maxLines = 3;

  Widget _buildSeriesDetailsTag() {
    if (widget.medium.type != MediaType.series) {
      return const SizedBox.shrink();
    }

    // Lógica para o texto visual (ex: "T5 • E62")
    final parts = <String>[];
    if (widget.medium.seasons != null) parts.add('T${widget.medium.seasons}');
    if (widget.medium.episodes != null) parts.add('E${widget.medium.episodes}');
    final tagText = parts.join(' • ');

    if (tagText.isEmpty) return const SizedBox.shrink();

    // TalkBack: (ex: "5 temporadas com 62 episódios")
    final semanticParts = <String>[];
    if (widget.medium.seasons != null) {
      final seasonText = widget.medium.seasons == 1 ? 'temporada' : 'temporadas';
      semanticParts.add('${widget.medium.seasons} $seasonText');
    }
    if (widget.medium.episodes != null) {
      semanticParts.add('com um total de ${widget.medium.episodes} episódios');
    }
    final semanticLabel = semanticParts.join(' ');

    return Semantics(
      label: semanticLabel,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
        decoration: BoxDecoration(
          color: AppTheme.secondaryDark.withAlpha(150),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          tagText,
          style: AppTheme.darkTheme.textTheme.labelMedium?.copyWith(
            color: AppTheme.mutedText,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Sinopse',
                style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                  color: AppTheme.contentWhite,
                  fontWeight: FontWeight.w600,
                ),
              ),
              _buildSeriesDetailsTag(),
            ],
          ),

          SizedBox(height: 1.5.h),

          AnimatedCrossFade(
            firstChild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.medium.synopsis,
                  style: AppTheme.darkTheme.textTheme.bodyLarge?.copyWith(
                    color: AppTheme.mutedText,
                    height: 1.5,
                  ),
                  maxLines: _maxLines,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 1.h),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isExpanded = true;
                    });
                  },
                  child: Text(
                    'Ver mais',
                    style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.accentColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            secondChild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.medium.synopsis,
                  style: AppTheme.darkTheme.textTheme.bodyLarge?.copyWith(
                    color: AppTheme.mutedText,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 1.h),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isExpanded = false;
                    });
                  },
                  child: Text(
                    'Ver menos',
                    style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.accentColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }
}
