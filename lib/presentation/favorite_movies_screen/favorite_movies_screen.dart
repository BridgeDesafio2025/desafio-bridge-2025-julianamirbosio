import 'package:flutter/material.dart';
import 'package:movies__series_app/presentation/content_detail_screen/content_detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:movies__series_app/core/app_export.dart';
import 'package:movies__series_app/core/providers/favorites_provider.dart';

class FavoriteMoviesScreen extends StatelessWidget {
  const FavoriteMoviesScreen({super.key});

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
