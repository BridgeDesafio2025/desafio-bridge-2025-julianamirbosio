import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/model/streaming_platform.dart';
import '../../../core/app_export.dart';

class StreamingPlatformsWidget extends StatelessWidget {
  final List<StreamingPlatform> platforms;

  const StreamingPlatformsWidget({
    super.key,
    required this.platforms,
  });

  @override
  Widget build(BuildContext context) {
    // retorna um widget vazio se a media não existe em nenhuma plataforma
    if (platforms.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Text(
            'Disponível em',
            style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
              color: AppTheme.contentWhite,
              fontWeight: FontWeight.w600,
            ),
          ),

          SizedBox(height: 2.h),

          
          Wrap(
            spacing: 3.w,
            runSpacing: 2.h,
            children: platforms.map((platform) {
              return GestureDetector(
                onTap: () => _openPlatformApp(context, platform),
                child: Container(
                  width: 42.w,
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: AppTheme.secondaryDark,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppTheme.borderColor.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      
                      Container(
                        width: 10.w,
                        height: 5.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CustomImageWidget(
                            imageUrl: platform.logoUrl,
                            width: 10.w,
                            height: 5.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      SizedBox(width: 3.w),

                      
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              platform.name,
                              style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                                color: AppTheme.contentWhite,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 0.5.h),
                            Text(
                              platform.type,
                              style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                                color: AppTheme.mutedText,
                              ),
                            ),
                          ],
                        ),
                      ),

                      
                      Icon(
                        Icons.open_in_new,
                        color: AppTheme.accentColor,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  void _openPlatformApp(BuildContext context, StreamingPlatform platform) {
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Abrindo ${platform.name}...'),
        backgroundColor: AppTheme.accentColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
