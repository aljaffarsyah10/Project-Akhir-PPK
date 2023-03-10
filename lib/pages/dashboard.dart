import 'package:autentikasi/pages/side_navbar.dart';
import 'package:flutter/material.dart';
import 'package:autentikasi/utils/static_data.dart';
import 'package:autentikasi/widgets/mini_news_card.dart';
import 'package:autentikasi/widgets/single_news_card.dart';
import '../providers/products.dart';
import '../providers/auth.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatelessWidget {
  static const route = "/dashboard";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideNavbar(),
      appBar: AppBar(
        title: Text("Homepage"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => Provider.of<Auth>(context, listen: false).logout(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 20.0,
              ),
            SingleNewsCard(),
              SizedBox(
                height: 30.0,
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: StaticData.news.length,
                itemBuilder: (BuildContext context, int index) {
                  return MiniNewsCard(news: StaticData.news[index]);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 10.0,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
