import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../../locator.dart';

import '../../../core/app_export.dart';
import '../../../core/model/actor.dart';

class CastSectionWidget extends StatefulWidget {
  final int mediumId;
  const CastSectionWidget({super.key, required this.mediumId});

  @override
  State<CastSectionWidget> createState() => _CastSectionWidgetState();
}

class _CastSectionWidgetState extends State<CastSectionWidget> {
  final MediaService _mediaService = locator<MediaService>();
  List<Actor>? _cast;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCast().then((cast) {
      if (!mounted) return;
      setState(() {
        _cast = cast;
        _isLoading = false;
      });
    });
  }

  Future<List<Actor>?> _loadCast() async {
    try {
      return await _mediaService.getMediumCast(widget.mediumId);
    } catch (e) {
      if (mounted) {
        Fluttertoast.showToast(
          msg: 'Erro ao carregar elenco: $e',
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
    final castHeight = 20.h;
    final titleHeight = 3.h;
    final spacing = 2.h;

    final hasError = !_isLoading && (_cast == null);
    if (hasError) return const SizedBox.shrink();
    
    if (_isLoading)
      return Container(
        width: double.infinity,
        height: castHeight + titleHeight + spacing,
        color: AppTheme.secondaryDark.withValues(alpha: 0.3),
        child: Center(
          child: CircularProgressIndicator(
            color: AppTheme.accentColor,
          ),
        ),
      );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Text(
              'Elenco Principal',
              style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                color: AppTheme.contentWhite,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 2.h),
          SizedBox(
            height: castHeight,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              itemCount: _cast!.length,
              itemBuilder: (context, index) {
                final castMember = _cast![index];
                return Container(
                  width: 25.w,
                  margin: EdgeInsets.only(right: 3.w),
                  child: Column(
                    children: [
                      Container(
                        width: 20.w,
                        height: 12.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppTheme.borderColor.withValues(alpha: 0.3),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CustomImageWidget(
                            imageUrl:
                                castMember.photo ?? 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3',
                            width: 20.w,
                            height: 12.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        castMember.name,
                        style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                          color: AppTheme.contentWhite,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        castMember.role,
                        style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.mutedText,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
