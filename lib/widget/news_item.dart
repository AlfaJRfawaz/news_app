import 'package:flutter/material.dart';
import 'package:news_app/model/article.dart';
import 'package:news_app/screen/detailpage.dart';
import 'package:news_app/utils/utils.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsItem extends StatelessWidget {
  /** ini parameter article buat nge-get object yg ada di class Article di folder model */
  final Article article;

  /** hampir sama kayak Function Named Argument di Kotlin */ // ini adalah perbedaan antara pakai required sama pakai this doang
  NewsItem({required this.article});

  @override
  Widget build(BuildContext context) {
    /** agar widget bisa di klik atau di tap */
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(
              article: article,
            ),
          ), // disisni kita pakai anonymous function agar saat ngeklik widget langsung menuju Detail Page
        );
      },
      child: Card(
        elevation: 5,
        color: Colors.white,
        margin: EdgeInsets.only(bottom: edgeDetail),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        child: Container(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 5,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.network(
                    article.urlToImage,
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover, // agar gambarnya dapat di cover
                  ),
                ), // widget ini untk mengcustom card-nya ada borderRadiusnya
              ),
              SizedBox(
                width: 5,
              ), // SizedBox juga bisa digunakan untuk memberi jarak
              // widget ini dipakai jika ada ruang yang masih kosong di dalam widget children maka ia akan mengisi ruang tersebut
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: titleArticle.copyWith(fontSize: 14),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 12,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Container(
                          width: 70,
                          child: Text(
                            timeUntil(DateTime.parse(article.publishedAt)),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: authorDateArticle.copyWith(fontSize: 12),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          size: 12,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Container(
                          width: 70,
                          child: Text(
                            article.author,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: authorDateArticle.copyWith(fontSize: 12),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String timeUntil(DateTime parse) {
  return timeago.format(parse, allowFromNow: true, locale: 'en');
}
