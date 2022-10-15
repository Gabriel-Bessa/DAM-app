import 'package:equatable/equatable.dart';

class Article extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final String body;
  final String author;
  final String authorImageUrl;
  final String category;
  final String imageUrl;
  final int views;
  final DateTime createAt;

  const Article({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.body,
    required this.author,
    required this.authorImageUrl,
    required this.category,
    required this.imageUrl,
    required this.views,
    required this.createAt,
  });

  static List<Article> articles = [
    Article(
      id: '1',
      title: 'Lorem ipsum dolor sit amet, consectetur elit,',
      subtitle: 'Aliquan laoreet ante non diam suscipit accumsan.',
      body: 'Aliquan laoreet ante non diam suscipit accumsan',
      author: 'Anna G. Wright',
      authorImageUrl:
          'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
      category: 'Politics',
      views: 1204,
      imageUrl:
          'https://images.unsplash.com/photo-1502239608882-93b729c6af43?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
      createAt: DateTime.now().subtract(const Duration(hours: 5)),
    ),
    Article(
      id: '2',
      title: 'Lorem ipsum dolor sit amet, consectetur elit,',
      subtitle: 'Aliquan laoreet ante non diam suscipit accumsan.',
      body: 'Aliquan laoreet ante non diam suscipit accumsan',
      author: 'Anna G. Wright',
      authorImageUrl:
          'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
      category: 'Politics',
      views: 1204,
      imageUrl:
          'https://images.unsplash.com/photo-1502239608882-93b729c6af43?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
      createAt: DateTime.now().subtract(const Duration(hours: 5)),
    ),
    Article(
      id: '3',
      title: 'Lorem ipsum dolor sit amet, consectetur elit,',
      subtitle: 'Aliquan laoreet ante non diam suscipit accumsan.',
      body: 'Aliquan laoreet ante non diam suscipit accumsan',
      author: 'Anna G. Wright',
      authorImageUrl:
          'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
      category: 'Politics',
      views: 1204,
      imageUrl:
          'https://images.unsplash.com/photo-1502239608882-93b729c6af43?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
      createAt: DateTime.now().subtract(const Duration(hours: 5)),
    ),
  ];

  @override
  List<Object?> get props => [
        id,
        title,
        subtitle,
        body,
        author,
        authorImageUrl,
        category,
        imageUrl,
        views,
        createAt,
      ];
}
