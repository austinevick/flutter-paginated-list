import 'package:flutter/material.dart';
import 'package:flutter_pagination/repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'article.dart';

final mainViewModel = ChangeNotifierProvider((ref) => MainViewModel());

class MainViewModel extends ChangeNotifier {
  List<ArticleData> articles = [];
  int limit = 10;

  UIState uiState = UIState.LOADING;

  void setUIState(UIState val) {
    uiState = val;
    notifyListeners();
  }

  bool isLoading = false;
  void loadMoreArticles(ScrollController controller) async {
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      try {
        isLoading = true;
        limit = limit + 1;
        notifyListeners();
        final response = await Repository.getArticles(limit);
        articles.addAll(response);
        isLoading = false;
      } catch (e) {
        isLoading = false;
        rethrow;
      }
    }
  }

  Future<List<ArticleData>> getArticles() async {
    try {
      setUIState(UIState.LOADING);
      final response = await Repository.getArticles(limit);
      articles = response;
      notifyListeners();
      setUIState(UIState.SUCCESS);
      return response;
    } catch (e) {
      setUIState(UIState.ERROR);
      print(e);
      rethrow;
    }
  }
}

enum UIState { ERROR, LOADING, SUCCESS }
