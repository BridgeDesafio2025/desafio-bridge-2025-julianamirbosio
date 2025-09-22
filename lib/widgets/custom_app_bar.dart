import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final VoidCallback? onSearchTap;
  final String? searchHint;
  final bool showBackButton;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double elevation;

  const CustomAppBar({
    super.key,
    this.title,
    this.actions,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.onSearchTap,
    this.searchHint,
    this.showBackButton = false,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 0,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title != null ? Text(title!) : null,
      backgroundColor: const Color(0xFF1A1A2E),
      foregroundColor: _getForegroundColor(),
      elevation: elevation,
      centerTitle: false,
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: _buildLeading(context),
      actions: actions,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: _getForegroundColor(),
      ),
      iconTheme: IconThemeData(
        color: _getForegroundColor(),
        size: 24,
      ),
      actionsIconTheme: IconThemeData(
        color: _getForegroundColor(),
        size: 24,
      ),
    );
  }

  Widget? _buildLeading(BuildContext context) {
    if (leading != null) return leading;

    if (showBackButton || (automaticallyImplyLeading && Navigator.canPop(context))) {
      return IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () => Navigator.pop(context),
        tooltip: 'Voltar',
      );
    }

    return null;
  }

  Color _getForegroundColor() => foregroundColor ?? const Color(0xFFFFFFFF);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
