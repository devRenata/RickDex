import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick/src/ui/themes/app_colors.dart';
import 'package:rick/src/ui/viewmodels/character_viewmodel.dart';
import 'package:rick/src/ui/widgets/build_error_widget.dart';
import 'package:rick/src/ui/widgets/build_loading_widget.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({super.key});

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewmodel = context.read<CharacterViewmodel>();
      if (viewmodel.characters.isEmpty) {
        viewmodel.getCharacters();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        centerTitle: true,
        title: const Text(
          'Characters',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Consumer<CharacterViewmodel>(
        builder: (context, viewmodel, child) {
          if (viewmodel.isLoading && viewmodel.characters.isEmpty) {
            return const BuildLoadingWidget();
          }

          if (viewmodel.error != null) {
            return BuildErrorWidget(
              exception: viewmodel.error!,
              onRetry: () => viewmodel.getCharacters(),
            );
          }

          return RefreshIndicator(
            onRefresh: () async => await viewmodel.refresh(),
            color: AppColors.primary,
            child: ListView.builder(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: viewmodel.characters.length,
              itemBuilder: (context, index) {
                final character = viewmodel.characters[index];
                return ListTile(
                  title: Text(character.name),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      final viewmodel = context.read<CharacterViewmodel>();
      if (viewmodel.hasMore && !viewmodel.isLoadidngMore) {
        viewmodel.loadMore();
      }
    }
  }
}
