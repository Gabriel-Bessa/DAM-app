import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:noticias/screens/article_screen.dart';
import 'package:noticias/widgets/image_container.dart';

import '../commons/firebase_collections.dart';
import '../models/article_model.dart';
import '../widgets/bottom_nav_bar.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  static const routeName = '/discover';

  @override
  Widget build(BuildContext context) {
    List<String> tabs = ['Saúde', 'Política', 'Arte', 'Comida', 'Ciência'];

    return DefaultTabController(
      initialIndex: 0,
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
          ),
        ),
        bottomNavigationBar: const BottomNavBar(index: 1),
        body: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [const _DiscoverNews(), _CategoryNews(tabs: tabs)],
        ),
      ),
    );
  }
}

class _CategoryNews extends StatefulWidget {
  _CategoryNews({Key? key, required this.tabs}) : super(key: key);

  final List<String> tabs;

  @override
  State<_CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<_CategoryNews> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<Article> news = [];

  _loadNews() async {
    List<Article> articles = [];
    QuerySnapshot query = await db
        .collection(FirebaseCollections.news)
        .where("category", isEqualTo: this.widget.tabs[0])
        .limit(6)
        .get();
    query.docs.forEach((element) {
      Article article = new Article(
          id: "nothing",
          title: element.get("title"),
          subtitle: element.get("subtitle"),
          body: element.get("body"),
          author: element.get("author"),
          authorImageUrl: element.get("authorImageUrl"),
          category: element.get("category"),
          imageUrl: element.get("imageUrl"),
          views: element.get("views"),
          createAt: DateTime.parse(element.get("createAt")));
      articles.add(article);
    });
    EasyLoading.dismiss();
    setState(() {
      news = articles;
    });
  }

  _filterByCategory(int value) async {
    List<Article> articles = [];
    QuerySnapshot query = await db
        .collection(FirebaseCollections.news)
        .where("category", isEqualTo: this.widget.tabs[value])
        .limit(6)
        .get();
    query.docs.forEach((element) {
      Article article = new Article(
          id: "nothing",
          title: element.get("title"),
          subtitle: element.get("subtitle"),
          body: element.get("body"),
          author: element.get("author"),
          authorImageUrl: element.get("authorImageUrl"),
          category: element.get("category"),
          imageUrl: element.get("imageUrl"),
          views: element.get("views"),
          createAt: DateTime.parse(element.get("createAt")));
      articles.add(article);
    });
    EasyLoading.dismiss();
    setState(() {
      news = articles;
    });
  }

  _serchByTerm() async {

  }

  @override
  void initState() {
    super.initState();
    EasyLoading.show(status: 'loading...');
    _loadNews();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          isScrollable: true,
          indicatorColor: Colors.black,
          onTap: (value) => {_filterByCategory(value)},
          tabs: widget.tabs
              .map(
                (tab) => Tab(
                  icon: Text(
                    tab,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              )
              .toList(),
        ),
        news.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Text("Nada encontrado!")],
              )
            : SizedBox(
                height: MediaQuery.of(context).size.height,
                child: TabBarView(
                    children: widget.tabs
                        .map((tab) => ListView.builder(
                              shrinkWrap: true,
                              itemCount: news.length,
                              itemBuilder: ((context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      ArticleScreen.routeName,
                                      arguments: news[index],
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      ImageContainer(
                                        width: 80,
                                        height: 80,
                                        margin: const EdgeInsets.all(10.0),
                                        borderRadius: 5,
                                        imageUrl: news[index].imageUrl,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              news[index].title,
                                              maxLines: 2,
                                              overflow: TextOverflow.clip,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.schedule,
                                                  size: 18,
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  '${DateTime.now().difference(news[index].createAt).inHours} horas atrás',
                                                  style: const TextStyle(
                                                      fontSize: 12),
                                                ),
                                                const SizedBox(width: 20),
                                                const Icon(
                                                  Icons.visibility,
                                                  size: 18,
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  '${news[index].views} views',
                                                  style: const TextStyle(
                                                      fontSize: 12),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ))
                        .toList()),
              )
      ],
    );
  }
}

class _DiscoverNews extends StatelessWidget {
  const _DiscoverNews({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.25,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Discover',
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: Colors.black, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 5),
          Text(
            'Notícias do mundo',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: ter,
            decoration: InputDecoration(
              hintText: 'Search',
              fillColor: Colors.grey.shade200,
              filled: true,
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.grey,
              ),
              suffixIcon: const RotatedBox(
                quarterTurns: 1,
                child: Icon(
                  Icons.tune,
                  color: Colors.grey,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide.none,
              ),
            ),
          )
        ],
      ),
    );
  }
}
