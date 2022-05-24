import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:news_app/model/article.dart';
import 'package:news_app/service/data_service.dart';
import 'package:news_app/widget/news_item.dart';

class TabBarMenu extends StatefulWidget {
  final List<Article> article;

  TabBarMenu(this.article);

  @override
  State<TabBarMenu> createState() => _TabBarMenuState();
}

/**
 * kita akan menggunakan SingleTickerProviderStateMixin jika kita mempunyai satu animasi
 */
class _TabBarMenuState extends State<TabBarMenu>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<Tab> myTabs = <Tab>[
    Tab(
      text: 'Business',
    ),
    Tab(
      text: 'Entertainment',
    ),
    Tab(
      text: 'Genereal',
    ),
    Tab(
      text: 'Health',
    ),
    Tab(
      text: 'Science',
    ),
    Tab(
      text: 'Sports',
    ),
    Tab(
      text: 'Technology',
    ),
  ];

  @override
  void initState() {
    _tabController = TabController(length: myTabs.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    News news = News();
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          TabBar(
            tabs: myTabs,
            controller: _tabController,
            labelColor: Colors.deepOrangeAccent,
            unselectedLabelColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BubbleTabIndicator(
              indicatorColor: Colors.black,
              indicatorHeight: 30,
              tabBarIndicatorSize: TabBarIndicatorSize.tab),
            isScrollable: true,
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: myTabs.map((Tab tab){
                /**
                 * disini kita bisa menggunakan future builder karena
                 * kita bisa dengan mudah mendapatkan status dari prosses yg sedang kita jalankan
                 * menampilkan loading saat memuat data dari server menggunakan API
                 * lalu menampilkan datanya saat sudah diterima dan siap
                 * Hampir Mirip seperti 
                 */
                return FutureBuilder(
                  future: news.getNewsCategory(tab.text.toString()),
                  builder: (context, snapshot) => snapshot.data != null
                  ? _lisNewsCategory(snapshot.data as List<Article>)
                  : Center(child: CircularProgressIndicator(),)
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

Widget _lisNewsCategory(List<Article> articles) {
  return Container(
    height: MediaQuery.of(context).size.height,
    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    child: ListView.builder(itemBuilder: (context, index) => NewsItem(article: articles[index]))
  );
}

}

