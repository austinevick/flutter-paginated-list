import 'package:flutter/material.dart';
import 'package:flutter_pagination/main_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final controller = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance
        .scheduleFrameCallback((_) => ref.read(mainViewModel).getArticles());
    controller.addListener(
        () => ref.read(mainViewModel).loadMoreArticles(controller));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final v = ref.watch(mainViewModel);
      return Scaffold(
          appBar: AppBar(
            title: Text('Latest Articles ${v.articles.length}'),
          ),
          body: switch (v.uiState) {
            UIState.ERROR => const Center(
                child: Text('Something went wrong'),
              ),
            UIState.LOADING => const Center(child: CircularProgressIndicator()),
            UIState.SUCCESS => ListView.builder(
                key: const PageStorageKey('page'),
                controller: controller,
                itemCount: v.articles.length,
                itemBuilder: (context, i) {
                  if (v.articles[i] == v.articles.last) {
                    if (v.isLoading) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 8),
                        child: OutlinedButton.icon(
                            onPressed: () => v.loadMoreArticles(controller),
                            label: const Text('Load more article')),
                      );
                    }
                  }
                  return ListTile(
                    leading: Image.network(v.articles[i].imageUrl!),
                    title: Text(v.articles[i].title!),
                  );
                },
              ),
          });
    });
  }
}
