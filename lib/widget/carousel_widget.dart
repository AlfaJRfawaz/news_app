import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_app/model/article.dart';
import 'package:news_app/screen/detailpage.dart';
import 'package:news_app/utils/utils.dart';

class CarouselWidget extends StatefulWidget {
  /**
   * kita buat ListView karena kita ngambil data dari luar
   * kalau GridView itu kita bisa ngwbuat sendiri/disebut gv_bulider
   */
  final List<Article> articleList;

  CarouselWidget(this.articleList);

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  /** ImageSlider itu widget buatan kita
   * ImageSlider akan bersisikan berbagai list dari articleList
  */
  late List<Widget> imageSlider;

  @override
  void initState() {
    /**
     * kita harus mengkonversi daftar string ke dlm daftar widget ImageSlider
     * kita dpt menggunakan method map() dan tolist(),
     * dgn method map() kita dpt menggunakan setiap string yang ada di articleList utk menghasilkan widget IS baru
     * dgn method tolist() kita dpt mengonversi object Iterable yg dikembalikan oleh method map()
     * ke dlm object List sebenarnya
    */
    imageSlider = widget.articleList.map((article) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage(
                article: article,
              ),
            ),
          );
        },
        child: Container(
          margin: EdgeInsets.all(10),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                        image: NetworkImage(article.urlToImage),
                        fit: BoxFit.cover)),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(101),
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        stops: [
                          0.1,
                          0.9
                        ],
                        colors: [
                          Colors.black.withOpacity(0.8),
                          Colors.white.withOpacity(0.1)
                        ])),
              ),
              /** 
               * supaya kita bica mengcustom tata letak widget 
              */
              Positioned(
                bottom: 30,
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  width: 250,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article.title,
                        style: titleArticleHeadline.copyWith(fontSize: 12),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        article.author,
                        style: authorDateArticleHeadline.copyWith(fontSize: 10),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }).toList();
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider(
        items: imageSlider,
        options: CarouselOptions(
          autoPlay: true,
          viewportFraction: 1
        ),
      ),
    );
  }
}
