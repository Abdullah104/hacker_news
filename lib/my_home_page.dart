import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:playground/article_search.dart';
import 'package:url_launcher/url_launcher.dart';

import 'article_item.dart';
import 'hacker_news_bloc.dart';
import 'loading_info.dart';
import 'src/article/article.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage(this.hackerNewsBloc, {Key? key}) : super(key: key);

  final HackerNewsBloc hackerNewsBloc;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: LoadingInfo(widget.hackerNewsBloc.isLoading),
        title: const Text('Flutter Hacker News'),
        actions: [
          IconButton(
            onPressed: () async {
              final Article article = await showSearch(
                context: context,
                delegate: ArticleSearch(widget.hackerNewsBloc.articles),
              );

              final uri = Uri.parse(article.url!);

              if (await canLaunchUrl(uri)) launchUrl(uri);
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: StreamBuilder<UnmodifiableListView<Article>>(
        stream: widget.hackerNewsBloc.articles,
        initialData: UnmodifiableListView<Article>([]),
        builder: (_, snapshot) {
          final articles = snapshot.data!;

          return ListView.builder(
            itemCount: articles.length,
            itemBuilder: (_, index) => ArticleItem(articles[index]),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onBottomNavigationBarTap,
        currentIndex: _index,
        items: const [
          BottomNavigationBarItem(
            label: 'Top Stories',
            icon: Icon(Icons.arrow_drop_up),
          ),
          BottomNavigationBarItem(
            label: 'New Stories',
            icon: Icon(Icons.new_releases),
          ),
        ],
      ),
    );
  }

  void _onBottomNavigationBarTap(int index) {
    if (index == 0) {
      widget.hackerNewsBloc.storiesType.add(StoriesType.topStories);
    } else if (index == 1) {
      widget.hackerNewsBloc.storiesType.add(StoriesType.newStories);
    }

    setState(() => _index = index);
  }
}
