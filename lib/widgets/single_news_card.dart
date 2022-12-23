import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:autentikasi/pages/single_news_page.dart';
import 'package:autentikasi/utils/helper.dart';

class SingleNewsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Helper.nextScreen(context, SingleNewsPage());
      },
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 5,
            width: MediaQuery.of(context).size.height / 5,
            // height: ScreenUtil().setHeight(210.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  "assets/images/berita1.jpg",
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            "Update: Daftar Terbaru Sirup Obat yang Aman Menurut BPOM",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Row(
            children: [
              Text(
                "20 min ago",
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
              Text(
                " | ",
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
              Text(
                "Medical",
                style: TextStyle(
                  fontSize: 14.0,
                  color: Color.fromRGBO(251, 89, 84, 1),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
