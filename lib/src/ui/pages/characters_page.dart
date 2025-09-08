import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rick/src/ui/themes/app_assets.dart';
import 'package:rick/src/ui/themes/app_colors.dart';
import 'package:rick/src/ui/viewmodels/character_viewmodel.dart';
import 'package:rick/src/ui/widgets/build_character_card.dart';
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
    _setSystemColors();
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
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.backgroundGray,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundGray,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      drawer: _buildDrawer(),
      body: SafeArea(
        child: Consumer<CharacterViewmodel>(
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
              backgroundColor: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Text(
                      'Characters',
                      style: TextStyle(
                        color: AppColors.textBlack,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.05),
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: viewmodel.characters.length,
                      itemBuilder: (context, index) {
                        final character = viewmodel.characters[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: BuildCharacterCard(
                            onPress: () {
                              context.pushNamed(
                                '/character_details',
                                extra: character,
                              );
                            },
                            character: character,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      final viewmodel = context.read<CharacterViewmodel>();
      if (viewmodel.hasMore && !viewmodel.isLoadidngMore) {
        viewmodel.loadMore();
      }
    }
  }

  Widget _buildDrawer() {
    final size = MediaQuery.of(context).size;
    return Drawer(
      backgroundColor: AppColors.backgroundGray,
      width: size.width * 0.65,
      child: Column(
        children: [
          SizedBox(height: size.height * 0.1),
          Center(
            child: Image.asset(
              width: size.width * 0.5,
              fit: BoxFit.cover,
              AppAssets.logo,
            ),
          ),
          SizedBox(height: size.height * 0.08),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  tileColor: AppColors.primary.withAlpha(30),
                  leading: const Icon(
                    Icons.group,
                    color: AppColors.primary,
                  ),
                  trailing: const Icon(
                    Icons.arrow_back_ios_rounded,
                    color: AppColors.primary,
                    size: 18,
                  ),
                  title: const Text('Characters'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _setSystemColors() async {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: AppColors.backgroundGray,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
  }
}
