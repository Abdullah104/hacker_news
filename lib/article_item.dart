import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'src/article/article.dart';

class ArticleItem extends StatelessWidget {
  const ArticleItem(this._article, {Key? key}) : super(key: key);

  final Article _article;

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: ValueKey(_article.id),
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 12),
      child: ExpansionTile(
        title: Text(
          _article.title,
          style: const TextStyle(fontSize: 24),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('${_article.descendants} comments'),
                const SizedBox(
                  width: 16,
                ),
                IconButton(
                  onPressed: _launchArticleUrl,
                  icon: const Icon(Icons.launch),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _launchArticleUrl() async {
    final url = _article.url;

    if (url != null) {
      final uri = Uri.parse(url);

      if (await canLaunchUrl(uri)) launchUrl(uri);
    }
  }
}
