import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_assignment/extensions/size_extenstions.dart';

import '../constants/size_constants.dart';
import '../model/responsive_data_model.dart';
import '../screenutils/screen_util.dart';
import '../widgets/project_image.dart';
import '../widgets/social_widget.dart';
import '../widgets/user_stats_widget.dart';

class DesktopUI extends StatefulWidget {
  DesktopUI({super.key});

  @override
  State<DesktopUI> createState() => _DesktopUIState();
}

class _DesktopUIState extends State<DesktopUI> {
  Future<ResponsiveData> loadAsset() async {
    final responseStr = await rootBundle.loadString('data.json');
    final result = ResponsiveData.fromJson(json.decode(responseStr));
    return result;
  }

  ResponsiveData? dataModel;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadAsset(),
      builder: (ctx, AsyncSnapshot<ResponsiveData> user) {
        if (user.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else {
          if (user.error != null) {
            // ...
            // Do error handling stuff
            return const Center(
              child: Text('An error occurred!'),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  //Main Outer Column
                  Flexible(
                    flex: 6,
                    child: SizedBox(
                      height: ScreenUtil.screenHeight * 0.6,
                      child: Row(
                        // First inner row
                        children: [
                          Flexible(
                            flex: 5,
                            child: Column(
                              // First Inner column of first row that has  title, stats
                              children: [
                                _buildHireText(),
                                _buildProjectStat(user.data!.yoe,
                                    user.data!.projects, user.data!.clients)
                              ],
                            ),
                          ),
                          Flexible(
                            flex: 5,
                            child: Column(
                              // Second inner of first row  column that has user details portfolio profile , social network
                              children: [
                                _buildBimGraph(),
                                Expanded(
                                  flex: 8,
                                  child: Row(
                                    children: [
                                      _buildProfileWidget(
                                          user.data!.profilephoto),
                                      Expanded(
                                        flex: 5,
                                        child: Column(
                                          children: [
                                            _buildNameText(user.data!.name),
                                            _buildLocationText(
                                                user.data!.location),
                                            _buildSocialRow(),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 4,
                    child: Container(
                      height: ScreenUtil.screenHeight * 0.4,
                      color: Color(0xff0f0f0f),
                      child: Row(children: [
                        _buildPortfolioContainer(),
                        _buildResumeContainer(user.data!.aboutUser),
                      ]),
                    ),
                  ) // Second inner row containing portfolio and about the person
                ],
              ),
            );
          }
        }
      },
    );
  }
}

Flexible _buildResumeContainer(String about) {
  return Flexible(
    flex: 4.5.toInt(),
    child: Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(25),
      decoration: const BoxDecoration(
        color: Color(0xFF252525),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'About',
                  style: TextStyle(
                      fontSize: Sizes.dimen_10.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
                Text(
                  'Resume',
                  style: TextStyle(
                      fontSize: Sizes.dimen_10.sp, color: Colors.white),
                )
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: AutoSizeText(
              maxLines: 7,
              about,
              style: TextStyle(
                  height: 1.5, fontSize: Sizes.dimen_6.sp, color: Colors.white),
            ),
          ),
        ],
      ),
    ),
  );
}

Flexible _buildPortfolioContainer() {
  return Flexible(
    flex: 5.5.toInt(),
    child: Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Color(0xFF252525),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Column(children: [
        Flexible(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'UI Portfolio',
                style: TextStyle(
                    fontSize: Sizes.dimen_10.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                'See all',
                style: TextStyle(
                    fontSize: Sizes.dimen_10.sp,
                    fontWeight: FontWeight.w100,
                    color: Colors.white),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Flexible(
          flex: 8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                  flex: 3,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      PortfolioImage(
                        image: 'https://i.ibb.co/J3K4P0s/portfolio2.png',
                      ),
                      Positioned.fill(
                          child: Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.black.withOpacity(0.6),
                        ),
                        child: Center(
                            child: Text(
                          'Read More',
                          style: TextStyle(
                              fontSize: Sizes.dimen_10.sp, color: Colors.white),
                        )),
                      ))
                    ],
                  )),
              const Expanded(
                  flex: 3,
                  child: PortfolioImage(
                    image: 'https://i.ibb.co/J3K4P0s/portfolio2.png',
                  )),
              const Expanded(
                  flex: 3,
                  child: PortfolioImage(
                    image: 'https://i.ibb.co/Js6fYms/portfolio1.png',
                  )),
            ],
          ),
        )
      ]),
    ),
  );
}

Expanded _buildSocialRow() {
  return Expanded(
    flex: 3,
    child: Container(
      margin: const EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_1.w),
      decoration: const BoxDecoration(
        color: Color(0xFF252525),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SocialWidget(
            isMobile: false,
            backgroundColor: Color(0xff2868b2),
            icon: Text(
              'in',
              style: TextStyle(
                  fontSize: Sizes.dimen_10.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          SocialWidget(
              isMobile: false,
              backgroundColor: Color.fromARGB(255, 53, 52, 52),
              icon: Icon(
                Icons.sports_soccer,
                color: Colors.white,
                size: Sizes.dimen_10.sp,
              )),
          SocialWidget(
              isMobile: false,
              backgroundColor: Color.fromARGB(255, 53, 52, 52),
              icon: Icon(
                FontAwesomeIcons.instagram,
                color: Colors.white,
                size: Sizes.dimen_10.sp,
              )),
          SocialWidget(
              isMobile: false,
              backgroundColor: Color.fromARGB(255, 53, 52, 52),
              icon: Icon(
                FontAwesomeIcons.twitter,
                color: Colors.white,
                size: Sizes.dimen_10.sp,
              ))
        ],
      ),
    ),
  );
}

Expanded _buildLocationText(String location) {
  return Expanded(
    flex: 5,
    child: Container(
      margin: const EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(
          vertical: Sizes.dimen_6.h, horizontal: Sizes.dimen_8.w),
      decoration: const BoxDecoration(
        color: Color(0xFF252525),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        children: [
          Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Based In :',
                  style: TextStyle(
                      fontSize: Sizes.dimen_6.sp, color: Colors.grey.shade400),
                ),
                Text(
                  location,
                  style: TextStyle(
                      fontSize: Sizes.dimen_7.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://i.ibb.co/vD541mP/image-map.png'))),
            ),
          )
        ],
      ),
    ),
  );
}

Expanded _buildNameText(String name) {
  return Expanded(
    flex: 2,
    child: Container(
      margin: const EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_8.w),
      decoration: const BoxDecoration(
        color: Color(0xFF252525),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Name :',
            style: TextStyle(
                fontSize: Sizes.dimen_6.sp, color: Colors.grey.shade400),
          ),
          Text(
            'Bima Sakti ',
            style: TextStyle(
                fontSize: Sizes.dimen_7.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ],
      ),
    ),
  );
}

Expanded _buildProfileWidget(String image) {
  return Expanded(
    flex: 5,
    child: Stack(
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Color(0xff8326fd),
              borderRadius: BorderRadius.all(Radius.circular(20)),
              image: DecorationImage(
                  fit: BoxFit.cover, image: NetworkImage(image))),
        ),
      ],
    ),
  );
}

Expanded _buildBimGraph() {
  return Expanded(
    flex: 2,
    child: Container(
      margin: const EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_8.w),
      decoration: BoxDecoration(
          color: Color(0xFF252525),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
              text: TextSpan(
                  text: 'Bim',
                  style: TextStyle(
                      fontSize: Sizes.dimen_8.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade400),
                  children: [
                TextSpan(
                    text: 'Graph',
                    style: TextStyle(
                        fontSize: Sizes.dimen_8.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white))
              ])),
          Icon(
            size: Sizes.dimen_8.sp,
            Icons.menu,
            color: Colors.white,
          )
        ],
      ),
    ),
  );
}

Expanded _buildProjectStat(int yoe, int project, int clients) {
  return Expanded(
    flex: 4.5.toInt(),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 3,
          child: UserStatWidget(
              isMobile: false,
              color: Color(0xff00c399),
              subtitle: 'Years of Experience',
              title: yoe.toString(),
              textColor: Colors.white),
        ),
        Expanded(
          flex: 3,
          child: UserStatWidget(
              isMobile: false,
              color: Color(0xffffc13c),
              subtitle: 'Handled Project',
              title: project.toString(),
              textColor: Colors.black),
        ),
        Expanded(
          flex: 3,
          child: UserStatWidget(
              isMobile: false,
              color: Color(0xffff6d7a),
              subtitle: 'Clients',
              title: clients.toString(),
              textColor: Colors.white),
        ),
      ],
    ),
  );
}

Expanded _buildHireText() {
  return Expanded(
    flex: 5.5.toInt(),
    child: Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Color(0xFF252525),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          AutoSizeText(
            'Bringing Your Ideas To Life Through UI Design',
            maxLines: 3,
            style: TextStyle(
                letterSpacing: 0.4,
                height: 1.2,
                fontSize: Sizes.dimen_20.sp,
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w600,
                color: Colors.white),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: ElevatedButton(
              style: const ButtonStyle(
                  padding: MaterialStatePropertyAll(EdgeInsets.all(20)),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)))),
                  backgroundColor: MaterialStatePropertyAll(Color(0xFF9C27B0))),
              onPressed: () {},
              child: Text(
                'Hire me 👋',
                style: TextStyle(fontSize: Sizes.dimen_10.sp),
              ),
            ),
          )
        ],
      ),
    ),
  );
}
