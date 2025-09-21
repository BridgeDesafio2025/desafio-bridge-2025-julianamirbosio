import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../core/model/filter_data.dart';
import '../../core/model/medium.dart';
import '../../widgets/custom_app_bar.dart';
import './widgets/content_card_widget.dart';
import './widgets/content_skeleton_widget.dart';
import './widgets/empty_state_widget.dart';
import './widgets/error_retry_widget.dart';
import './widgets/genre_filter_widget.dart';

class ContentBrowseScreen extends StatefulWidget {
  final FilterData? initialFilter;
  const ContentBrowseScreen({super.key, this.initialFilter});

  @override
  State<ContentBrowseScreen> createState() => _ContentBrowseScreenState();
}

class _ContentBrowseScreenState extends State<ContentBrowseScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollController;

  bool _isLoading = false;
  bool _hasError = false;
  bool _isLoadingMore = false;
  late FilterData _selectedFilter;
  int _currentPage = 1;
  late int _totalItems;

  List<Medium> _content = [];

  final List<String> _genres = [
    'Todos',
    'Ação',
    'Aventura',
    'Comédia',
    'Drama',
    'Ficção Científica',
    'Terror',
    'Romance',
    'Thriller',
    'Documentário',
    'Animação',
    'Crime',
    'Fantasia',
    'Mistério',
    'Guerra',
    'Histórico',
    'Música',
    'Família',
    'Western',
    'Biografia',
    'Suspense',
    'Cyberpunk',
    'Sobrevivência',
    'Jovem Adulto',
    'Musical',
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _selectedFilter = widget.initialFilter ?? FilterData();
    _loadInitialContent();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200 &&
        !_isLoadingMore &&
        !_hasError &&
        _content.length < _totalItems) {
      _loadMoreContent();
    }
  }

  Future<void> _loadInitialContent() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      final contentPage = await getMediaPage();
      final content = contentPage.data;
      if (!mounted) return;

      setState(() {
        _content = content;
        _isLoading = false;
        _currentPage = contentPage.pagination.currentPage;
        _totalItems = contentPage.pagination.totalItems;
      });
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Erro ao carregar mídias: $e',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppTheme.darkTheme.colorScheme.surface,
        textColor: AppTheme.contentWhite,
      );
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
    }
  }

  Future<void> _loadMoreContent() async {
    if (_isLoadingMore || _hasError) return;

    setState(() {
      _isLoadingMore = true;
    });

    try {
      final newContentPage = await getMediaPage(
        page: _currentPage + 1,
        filterData: _selectedFilter,
      );
      final newContent = newContentPage.data;

      if (!mounted) return;
      setState(() {
        _content.addAll(newContent);
        _isLoadingMore = false;
        _currentPage++;
        _totalItems = newContentPage.pagination.totalItems;
      });
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Erro ao carregar mais mídias: $e',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppTheme.darkTheme.colorScheme.surface,
        textColor: AppTheme.contentWhite,
      );
      setState(() {
        _isLoadingMore = false;
      });
    }
  }

  Future<void> _refreshContent() async {
    await _loadInitialContent();
  }

  Future<void> _onGenreSelected(String genre) async {
    setState(() {
      _currentPage = 1;
      _isLoading = true;
      _hasError = false;
      _selectedFilter = genre != 'Todos' ? _selectedFilter.copyWith(genre: [genre]) : FilterData();
    });
    try {
      final contentPage = await getMediaPage(filterData: _selectedFilter);
      final content = contentPage.data;

      if (!mounted) return;
      setState(() {
        _content = content;
        _totalItems = contentPage.pagination.totalItems;
      });

      Fluttertoast.showToast(
        msg: genre == 'Todos' ? 'Mostrando todo o conteúdo' : 'Filtrado por: $genre',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppTheme.darkTheme.colorScheme.surface,
        textColor: AppTheme.contentWhite,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Erro ao filtrar por gênero: $e',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppTheme.darkTheme.colorScheme.surface,
        textColor: AppTheme.contentWhite,
      );
      setState(() {
        _hasError = true;
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _onFilterApplied(FilterData filterData) async {
    setState(() {
      _currentPage = 1;
      _isLoading = true;
      _hasError = false;
      _selectedFilter = filterData;
    });
    try {
      final contentPage = await getMediaPage(filterData: filterData);
      final content = contentPage.data;

      if (!mounted) return;
      setState(() {
        _content = content;
        _totalItems = contentPage.pagination.totalItems;
      });
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Erro ao aplicar filtro: $e',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppTheme.darkTheme.colorScheme.surface,
        textColor: AppTheme.contentWhite,
      );
      setState(() {
        _hasError = true;
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _onContentTap(Medium content) {
    Navigator.pushNamed(
      context,
      AppRoutes.contentDetail,
      arguments: content,
    );
  }

  void _onFavorite(Medium content) {
    Fluttertoast.showToast(
      msg: '${content.title} adicionado aos favoritos',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppTheme.accentColor,
      textColor: AppTheme.contentWhite,
    );
  }

  void _onShare(Medium content) {
    Fluttertoast.showToast(
      msg: 'Compartilhando: ${content.title}',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppTheme.successColor,
      textColor: AppTheme.primaryDark,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkTheme.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: 'CineList',
        actions: [
          IconButton(
            tooltip: 'Filter',
            icon: const Icon(Icons.filter_list),
            onPressed: () => Navigator.pushNamed<FilterData?>(context, AppRoutes.genreFilter).then(
              (FilterData) {
                if (FilterData != null) {
                  _onFilterApplied(FilterData);
                }
              },
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          GenreFilterWidget(
            selectedGenre: _selectedFilter.genre?.first ?? 'Todos',
            genres: _genres,
            onGenreSelected: _onGenreSelected,
          ),
          Expanded(
            child: _buildContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return _buildLoadingState();
    }

    if (_hasError) {
      return _buildErrorState();
    }

    if (_content.isEmpty) {
      return _buildEmptyState();
    }

    return _buildContentList();
  }

  Widget _buildLoadingState() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      itemCount: 6,
      itemBuilder: (context, index) => const ContentSkeletonWidget(),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: ErrorRetryWidget(
        message:
            'Não foi possível carregar o conteúdo. Verifique sua conexão com a internet.',
        onRetry: _loadInitialContent,
      ),
    );
  }

  Widget _buildEmptyState() {
    return EmptyStateWidget(
      message: _selectedFilter == 'Todos'
          ? 'Não há conteúdo disponível no momento.'
          : _selectedFilter.toReadableString(),
      actionText: 'Limpar Filtro',
      onAction: _selectedFilter != 'Todos' ? () => _onGenreSelected('Todos') : null,
    );
  }

  Widget _buildContentList() {
    return RefreshIndicator(
      onRefresh: _refreshContent,
      color: AppTheme.accentColor,
      backgroundColor: AppTheme.darkTheme.colorScheme.surface,
      child: ListView.builder(
        controller: _scrollController,
        padding: EdgeInsets.symmetric(vertical: 2.h),
        itemCount: _content.length + (_isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == _content.length) {
            return _buildLoadingMoreIndicator();
          }

          final content = _content[index];
          return ContentCardWidget(
            content: content,
            onTap: () => _onContentTap(content),
            onFavorite: () => _onFavorite(content),
            onShare: () => _onShare(content),
          );
        },
      ),
    );
  }

  Widget _buildLoadingMoreIndicator() {
    return Container(
      padding: EdgeInsets.all(4.w),
      child: Center(
        child: CircularProgressIndicator(
          color: AppTheme.accentColor,
          strokeWidth: 2,
        ),
      ),
    );
  }
}
