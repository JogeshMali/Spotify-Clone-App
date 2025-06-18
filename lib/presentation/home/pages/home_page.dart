import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/common/helper/is_dark_mode.dart';
import 'package:spotify/core/configs/assets/app_images.dart';
import 'package:spotify/core/configs/theme/app_color.dart';
import 'package:spotify/presentation/home/widget/get_news_playlist.dart';
import 'package:spotify/presentation/home/widget/news_songs.dart';

import '../../../common/widgets/basic_app_bar.dart';
import '../../../core/configs/assets/app_vectors.dart';
import '../../profile/page/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 40,
          width: 40,
        ),
        hideBack: true,
        action: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const ProfilePage()));
            },
            icon: const Icon(Icons.person)),
      ),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _topCard(),
          SizedBox(
            height: 35,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Songs',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
              height: 260,
              child: TabBarView(controller: _tabController, children: [
                NewsSongs(),
                Container(),
                Container(),
                Container()
              ])),
          GetNewsPlaylist()
        ],
      )),
    );
  }

  Widget _topCard() {
    return Container(
      height: 140,
      child: Stack(
        children: [
          Align(
              alignment: Alignment.bottomCenter,
              child: SvgPicture.asset(AppVectors.home_top_card)),
          Padding(
              padding: EdgeInsets.only(right: 50),
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: Image.asset(AppImages.home_artist)))
        ],
      ),
    );
  }

  // Widget _tabBar() {
  //   return TabBar(
  //       controller: _tabController,
  //       tabAlignment: TabAlignment.start,
  //       isScrollable: true,
  //       indicatorColor: Appcolor.primary,
  //       labelColor: context.isDarkMode ? Colors.white : Colors.black,
  //       padding: EdgeInsets.only(top: 40, right: 16, left: 16, bottom: 10),
  //       tabs: [
  //         Text(
  //           'News',
  //           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
  //         ),
  //         Text(
  //           'Videos',
  //           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
  //         ),
  //         Text(
  //           'Artists',
  //           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
  //         ),
  //         Text(
  //           'Podcasts',
  //           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
  //         )
  //       ]);
  // }
}
