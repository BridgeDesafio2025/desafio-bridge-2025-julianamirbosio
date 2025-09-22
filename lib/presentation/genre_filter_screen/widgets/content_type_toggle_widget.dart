import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class ContentTypeToggleWidget extends StatelessWidget {
  final String selectedType;
  final Function(String) onTypeChanged;

  const ContentTypeToggleWidget({
    super.key,
    required this.selectedType,
    required this.onTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final contentTypes = ['Todos', 'Filmes', 'Séries'];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: AppTheme.secondaryDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.borderColor.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: contentTypes.map((type) {
          final isSelected = selectedType == type;
          final isFirst = type == contentTypes.first;
          final isLast = type == contentTypes.last;

          final int index = contentTypes.indexOf(type);

          return Expanded(
            child: Semantics(
              selected: isSelected,
              // Talkback anuncia se o item está selecionado
              hint: 'Opção ${index + 1} de ${contentTypes.length}',
              child: GestureDetector(
                onTap: () => onTypeChanged(type),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.symmetric(vertical: 3.h),
                  decoration: BoxDecoration(
                    color: isSelected ? AppTheme.accentColor : Colors.transparent,
                    borderRadius: BorderRadius.horizontal(
                      left: isFirst ? const Radius.circular(12) : Radius.zero,
                      right: isLast ? const Radius.circular(12) : Radius.zero,
                    ),
                  ),
                  child: Text(
                    type,
                    textAlign: TextAlign.center,
                    style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                      color:
                          isSelected ? AppTheme.contentWhite : AppTheme.mutedText,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
