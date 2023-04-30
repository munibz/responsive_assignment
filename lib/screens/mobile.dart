import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_assignment/extensions/size_extenstions.dart';
import 'package:responsive_assignment/model/responsive_data_model.dart';

import '../constants/size_constants.dart';
import '../screenutils/screen_util.dart';
import '../widgets/project_image.dart';
import '../widgets/social_widget.dart';
import '../widgets/user_stats_widget.dart';

class MobileUI extends StatefulWidget {
  const MobileUI({super.key});

  @override
  State<MobileUI> createState() => _MobileUIState();
}

class _MobileUIState extends State<MobileUI> {
  Future<ResponsiveData> loadAsset() async {
    final responseStr =
        await rootBundle.loadString('assets/data.json');
    final result = ResponsiveData.fromJson(json.decode(responseStr));
    return result;
  }

  ResponsiveData? dataModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
            return SafeArea(
              child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: SingleChildScrollView(
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      _buildMobileBimGraph(),
                      SizedBox(
                        height: ScreenUtil.screenHeight * 0.3,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                                flex: 1,
                                child: _buildProfileMobileWidget(
                                    user.data!.profilephoto)),
                            Flexible(
                              flex: 1,
                              child: Column(
                                children: [
                                  _buildNameTextMobile(user.data!.name),
                                  _buildLocationTextMobile(user.data!.location),
                                  const _buildSocialRowMobile(),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      _buildStatMobile(
                          user.data!.yoe.toString(),
                          user.data!.projects.toString(),
                          user.data!.clients.toString()),
                      _buildHireMobileText(),
                      _buildPortfolioContainerMobile(),
                      _buildResumeContainerMobile(user.data!.aboutUser)
                    ]),
                  )),
            );
          }
        }
      },
    );
  }

  SizedBox _buildStatMobile(String yoe, String project, String client) {
    return SizedBox(
      height: ScreenUtil.screenHeight * 0.15,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: UserStatWidget(
                isMobile: true,
                color: Color(0xff00c399),
                subtitle: 'Years of Experience',
                title: yoe,
                textColor: Colors.white),
          ),
          Expanded(
            flex: 3,
            child: UserStatWidget(
                isMobile: true,
                color: Color(0xffffc13c),
                subtitle: 'Handled Project',
                title: project,
                textColor: Colors.black),
          ),
          Expanded(
            flex: 3,
            child: UserStatWidget(
                isMobile: true,
                color: Color(0xffff6d7a),
                subtitle: 'Clients',
                title: client,
                textColor: Colors.white),
          ),
        ],
      ),
    );
  }

  SizedBox _buildResumeContainerMobile(String aboutUser) {
    return SizedBox(
      height: ScreenUtil.screenHeight * .225,
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
                        fontSize: Sizes.dimen_18.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                  Text(
                    'Resume',
                    style: TextStyle(
                        fontSize: Sizes.dimen_18.sp, color: Colors.white),
                  )
                ],
              ),
            ),
            Flexible(
              flex: 4,
              child: AutoSizeText(
                maxLines: 7,
                aboutUser,
                style:
                    TextStyle(fontSize: Sizes.dimen_14.sp, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox _buildPortfolioContainerMobile() {
    return SizedBox(
        height: ScreenUtil.screenHeight * 0.25,
        child: Flexible(
          flex: 5.5.toInt(),
          child: Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(15),
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
                          fontSize: Sizes.dimen_16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      'See all',
                      style: TextStyle(
                          fontSize: Sizes.dimen_16.sp, color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Flexible(
                flex: 8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                        flex: 2,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            const PortfolioImage(
                              image: 'https://i.ibb.co/J3K4P0s/portfolio2.png',
                            ),
                            Positioned.fill(
                                child: Container(
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                color: Colors.black.withOpacity(0.6),
                              ),
                              child: Center(
                                  child: Text(
                                'Read More',
                                style: TextStyle(
                                    fontSize: Sizes.dimen_14.sp,
                                    color: Colors.white),
                              )),
                            ))
                          ],
                        )),
                    const Expanded(
                        flex: 2,
                        child: PortfolioImage(
                          image: 'https://i.ibb.co/J3K4P0s/portfolio2.png',
                        )),
                    const Expanded(
                        flex: 2,
                        child: PortfolioImage(
                          image: 'https://i.ibb.co/Js6fYms/portfolio1.png',
                        )),
                  ],
                ),
              )
            ]),
          ),
        ));
  }

  Expanded _buildLocationTextMobile(String location) {
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
                        fontSize: Sizes.dimen_12.sp,
                        color: Colors.grey.shade400),
                  ),
                  Text(
                    location,
                    style: TextStyle(
                        fontSize: Sizes.dimen_12.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Flexible(
              flex: 4,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://i.ibb.co/vD541mP/image-map.png'))),
              ),
            )
          ],
        ),
      ),
    );
  }

  Expanded _buildNameTextMobile(String name) {
    return Expanded(
      flex: 2,
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_12.w),
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
                  fontSize: Sizes.dimen_12.sp, color: Colors.grey.shade400),
            ),
            Text(
              name,
              style: TextStyle(
                  fontSize: Sizes.dimen_12.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileMobileWidget(String photo) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Color(0xff8326fd),
          borderRadius: BorderRadius.all(Radius.circular(20)),
          image: DecorationImage(fit: BoxFit.fill, image: NetworkImage(photo))),
    );
  }

  Container _buildHireMobileText() {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: EdgeInsets.only(
          left: Sizes.dimen_12.w,
          top: Sizes.dimen_6.h,
          bottom: Sizes.dimen_6.h),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Color(0xFF252525),
      ),
      child: Row(
        children: [
          Flexible(
            flex: 7,
            child: AutoSizeText(
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
          ),
          Flexible(
            flex: 3,
            child: ElevatedButton(
              style: const ButtonStyle(
                  padding: MaterialStatePropertyAll(EdgeInsets.all(10)),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)))),
                  backgroundColor: MaterialStatePropertyAll(Color(0xFF9C27B0))),
              onPressed: () {},
              child: Text(
                'Hire me 👋',
                style: TextStyle(fontSize: Sizes.dimen_14.sp),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMobileBimGraph() {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(
          horizontal: Sizes.dimen_8.w, vertical: Sizes.dimen_6.h),
      decoration: const BoxDecoration(
          color: Color(0xFF252525),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
              text: TextSpan(
                  text: 'Bim',
                  style: TextStyle(
                      fontSize: Sizes.dimen_12.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade400),
                  children: [
                TextSpan(
                    text: 'Graph',
                    style: TextStyle(
                        fontSize: Sizes.dimen_12.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white))
              ])),
          Icon(
            size: Sizes.dimen_10.sp,
            Icons.menu,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}

// ignore: camel_case_types
class _buildSocialRowMobile extends StatelessWidget {
  const _buildSocialRowMobile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_12.w),
        decoration: const BoxDecoration(
          color: Color(0xFF252525),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SocialWidget(
              isMobile: true,
              backgroundColor: const Color(0xff2868b2),
              icon: Text(
                'in',
                style: TextStyle(
                    fontSize: Sizes.dimen_14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            SocialWidget(
                isMobile: true,
                backgroundColor: const Color.fromARGB(255, 53, 52, 52),
                icon: Icon(
                  Icons.sports_soccer,
                  color: Colors.white,
                  size: Sizes.dimen_14.sp,
                )),
            SocialWidget(
                isMobile: true,
                backgroundColor: const Color.fromARGB(255, 53, 52, 52),
                icon: Icon(
                  FontAwesomeIcons.instagram,
                  color: Colors.white,
                  size: Sizes.dimen_14.sp,
                )),
            SocialWidget(
                isMobile: true,
                backgroundColor: const Color.fromARGB(255, 53, 52, 52),
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
}
