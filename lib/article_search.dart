import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:playground/src/article/article.dart';

class ArticleSearch extends SearchDelegate {
  ArticleSearch(this._articles);

  final Stream<UnmodifiableListView<Article>> _articles;

  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => query = '',
        )
      ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back),
      );

  @override
  Widget buildResults(BuildContext context) =>
      StreamBuilder<UnmodifiableListView<Article>>(
        stream: _articles,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final articles = snapshot.data!
                .where((article) => article.title.toLowerCase().contains(query))
                .toList();

            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];

                return ListTile(
                  leading: const Icon(Icons.book),
                  title: Text(
                    article.title,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(fontSize: 16),
                  ),
                  onTap: () => close(context, article),
                );
              },
            );
          } else {
            return const Text('No data');
          }
        },
      );

  @override
  Widget buildSuggestions(BuildContext context) =>
      StreamBuilder<UnmodifiableListView<Article>>(
        stream: _articles,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final articles = snapshot.data!
                .where((article) => article.title.toLowerCase().contains(query))
                .toList();

            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];

                return ListTile(
                  title: Text(
                    article.title,
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontSize: 16,
                          color: Colors.blue,
                        ),
                  ),
                  onTap: () => close(context, article),
                );
              },
            );
          } else {
            return const Text('No data');
          }
        },
      );
}
