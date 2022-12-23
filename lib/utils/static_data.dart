import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:autentikasi/models/category.dart';
import 'package:autentikasi/models/news.dart';

class StaticData {
  static List<Category> categories = [
    Category(
      id: 1,
      title: "Most Popular",
      icon: Icon(
        FlutterIcons.trending_up_fea,
      ),
    ),
    Category(
      id: 2,
      title: "World",
      icon: Icon(
        FlutterIcons.globe_ent,
      ),
    ),
    Category(
      id: 3,
      title: "Science",
      icon: Icon(
        FlutterIcons.react_faw5d,
      ),
    ),
    Category(
      id: 4,
      title: "Politics",
      icon: SvgPicture.asset("assets/svg/politics.svg"),
    ),
    Category(
      id: 5,
      title: "Business",
      icon: Icon(FlutterIcons.handshake_o_faw),
    ),
    Category(
      id: 6,
      title: "Sports",
      icon: Icon(FlutterIcons.soccer_ball_o_faw),
    ),
    Category(
      id: 7,
      title: "Arts",
      icon: SvgPicture.asset("assets/svg/arts.svg"),
    ),
    Category(
      id: 8,
      title: "Health",
      icon: Icon(FlutterIcons.stethoscope_faw5s),
    ),
    Category(
      id: 9,
      title: "Food",
      icon: SvgPicture.asset("assets/svg/food.svg"),
    ),
    Category(
      id: 10,
      title: "Technology",
      icon: SvgPicture.asset("assets/svg/technology.svg"),
    ),
  ];

  static List<News> news = [
    News(
      id: 1,
      category: "Health",
      title:
          "Mengenal 15 Efek Buruk Stres untuk Kesehatan dan Cara Mencegahnya",
      content:
          "Jika dibiarkan saja, stres tidak hanya akan berdampak pada kesehatan secara umum, namun juga pada...",
      timePosted: "10 hours ago",
      imagePath: "assets/images/berita2.jpg",
    ),
    News(
      id: 2,
      category: "Health",
      title: "Angka Kebutuhan Vitamin E dan Sumbernya",
      content:
          "Stres oksidatif adalah keadaan di mana jumlah radikal bebas di dalam tubuh sangat tinggi, biasanya akan memicu berbagai penyakit, termasuk penyakit jantung dan kanker. Namun, setiap orang...",
      timePosted: "1 day ago",
      imagePath: "assets/images/berita3.jpg",
    ),
    News(
      id: 3,
      category: "Health",
      title: "Mengenal Manfaat Jalan Kaki untuk Menurunkan Berat Badan",
      content:
          "Jalan kaki adalah salah satu jenis olahraga yang paling murah karena bisa dilakukan di mana saja dan tanpa menggunakan alat apapun. Ada banyak sekali",
      timePosted: "1 day ago",
      imagePath: "assets/images/berita4.jpg",
    ),
    News(
      id: 4,
      category: "Sports",
      title: "The True Cost Of Lionel Messi’s...",
      content:
          "The actor also played groundbreaking figures like the James Brown, Jackie Robinson and Thurgood Marshall,",
      timePosted: "10 hours ago",
      imagePath: "assets/images/messi.png",
    ),
  ];
}
