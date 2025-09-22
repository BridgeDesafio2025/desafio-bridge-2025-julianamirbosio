import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:movies__series_app/presentation/content_detail_screen/content_detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:movies__series_app/core/app_export.dart';
import 'package:movies__series_app/core/providers/favorites_provider.dart';
import '../../core/model/medium.dart';

class FavoriteMoviesScreen extends StatelessWidget {
  const FavoriteMoviesScreen({super.key});

  void _showQuickActions(BuildContext context, Medium content) {
    final favoritesProvider =
        Provider.of<FavoritesProvider>(context, listen: false);
    final bool isFavorited = favoritesProvider.isFavorite(content);

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
            ExcludeSemantics(
              child: Container(
                width: 12.w,
                height: 0.5.h,
                decoration: BoxDecoration(
                  color: AppTheme.borderColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            SizedBox(height: 3.h),
            ListTile(
              leading: Icon(
                isFavorited ? Icons.favorite : Icons.favorite_border,
                color: AppTheme.accentColor,
                size: 24,
              ),
              title: Text(
                isFavorited
                    ? 'Remover dos Favoritos'
                    : 'Adicionar aos Favoritos',
                style: AppTheme.darkTheme.textTheme.bodyMedium,
              ),
              onTap: () {
                Navigator.pop(context);
                favoritesProvider.toggleFavorite(content);
              },
            ),
            ListTile(
              leading: ExcludeSemantics(
                child: Icon(
                  Icons.share,
                  color: AppTheme.successColor,
                  size: 24,
                ),
              ),
              title: Text(
                'Compartilhar Conteúdo',
                style: AppTheme.darkTheme.textTheme.bodyMedium,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Meus Favoritos'),
          backgroundColor: AppTheme.primaryDark,
          elevation: 0,
        ),
        backgroundColor: AppTheme.primaryDark,
        body: Consumer<FavoritesProvider>(
            builder: (context, FavoritesProvider, child) {
          final favoritesList = FavoritesProvider.favorites;

          if (favoritesList.isEmpty) {
            return const Center(
              child: Text('Sua lista de favoritos está vazia.',
                  style: TextStyle(color: AppTheme.mutedText, fontSize: 16)),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: favoritesList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // 3 posters por linha
              childAspectRatio: 2 / 3, // Proporção do poster
              crossAxisSpacing: 8, // Espaçamento horizontal
              mainAxisSpacing: 8, // Espaçamento vertical
            ),
            itemBuilder: (context, index) {
              final medium = favoritesList[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContentDetailScreen(medium: medium),
                    ),
                  );
                },
                onLongPress: () {
                  _showQuickActions(context, medium);
                },
                // Acessibilidade
                child: Semantics(
                  label: medium.title,
                  onTapHint: 'ver detalhes',
                  button: true,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: CustomImageWidget(
                      imageUrl: medium.poster ?? '',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          );
        }));
  }
}
