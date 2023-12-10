import 'dart:async';
import 'dart:collection';

import 'package:http/http.dart' as http;
import 'package:playground/hacker_news_api_error.dart';
import 'package:rxdart/rxdart.dart';

import 'src/article/article.dart';

enum StoriesType { topStories, newStories }

class HackerNewsBloc {
  HackerNewsBloc() : _cachedArticles = HashMap<int, Article>() {
    _initializeArticles();

    _storiesTypeController.stream.listen((storiestype) async {
      _getArticlesAndUpdate(await _getIds(storiestype));
    });
  }

  static const _baseUrl = 'https://hacker-news.firebaseio.com/v0/';

  final _articlesSubject = BehaviorSubject<UnmodifiableListView<Article>>();
  final _storiesTypeController = StreamController<StoriesType>();
  final _isLoadingSubject = BehaviorSubject<bool>();

  var _articles = <Article>[];
  final HashMap<int, Article> _cachedArticles;

  Stream<UnmodifiableListView<Article>> get articles => _articlesSubject.stream;
  Sink<StoriesType> get storiesType => _storiesTypeController.sink;
  Stream<bool> get isLoading => _isLoadingSubject.stream;

  Future<Article> _getArticleById(int id) async {
    if (!_cachedArticles.containsKey(id)) {
      final url = '${_baseUrl}item/$id.json';
      final result = await http.get(Uri.parse(url));

      if (result.statusCode == 200) {
        _cachedArticles[id] = parseArticle(result.body);
      } else {
        throw HackerNewsApiError('Article ID couldn\'t be fetched');
      }
    }

    return _cachedArticles[id]!;
  }

  Future<void> _updateArticles(List<int> ids) async {
    _articles = await Future.wait(ids.map(_getArticleById));
  }

  Future<void> _getArticlesAndUpdate(List<int> ids) async {
    _isLoadingSubject.add(true);

    await _updateArticles(ids);

    _articlesSubject.add(UnmodifiableListView(_articles));
    _isLoadingSubject.add(false);
  }

  void close() {
    _articlesSubject.close();
    _storiesTypeController.close();
    _isLoadingSubject.close();
  }

  Future<List<int>> _getIds(StoriesType type) async {
    final partUrl = type == StoriesType.newStories ? 'new' : 'top';
    final url = '$_baseUrl${partUrl}stories.json';
    final result = await http.get(Uri.parse(url));

    if (result.statusCode != 200) {
      throw HackerNewsApiError("Stories $type couldn't be fetched");
    }

    return parseTopStories(result.body).take(10).toList();
  }

  Future<void> _initializeArticles() async {
    final ids = await _getIds(StoriesType.topStories);

    await _getArticlesAndUpdate(ids);
  }
}
