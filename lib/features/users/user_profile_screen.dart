import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/settings/settings_screen.dart';
import 'package:tiktok_clone/features/users/widgets/accoun_property.dart';
import 'package:tiktok_clone/features/users/widgets/persistent_tab_bar.dart';

class UserProfileScreen extends StatefulWidget {
  final String username;
  final String tab;
  const UserProfileScreen({
    super.key,
    required this.username,
    required this.tab,
  });

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  void _onGearPressed() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => SettingScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: widget.tab == "likes" ? 1 : 0,
      length: 2,
      //NestScrollView : ScrollView안에 또 다른 ScrollView가 중첩되어 있을 때 사용된다
      //Sliver 파라미터가 없고 hedaerSliverBuilder는 sliver들을 list로 반환해준다
      child: Scaffold(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        body: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  title: Text(widget.username),
                  actions: [
                    IconButton(
                      onPressed: _onGearPressed,
                      icon: FaIcon(FontAwesomeIcons.gear, size: Sizes.size20),
                    ),
                  ],
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        foregroundImage: NetworkImage(
                          "https://avatars.githubusercontent.com/u/102948397?v=4",
                        ),
                        child: Text("호석"),
                      ),
                      Gaps.v12,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "@${widget.username}",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: Sizes.size18,
                            ),
                          ),
                          Gaps.h5,
                          FaIcon(
                            FontAwesomeIcons.solidCircleCheck,
                            size: Sizes.size16,
                            color: Colors.blue.shade300,
                          ),
                        ],
                      ),
                      Gaps.v12,
                      SizedBox(
                        //verticlaDivider: 특정 높이를 가진 father를 필요로 함
                        height: Sizes.size52,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AccounProperty(number: "37", title: "Following"),
                            VerticalDivider(
                              width: Sizes.size32,
                              thickness: Sizes.size1,
                              color: Colors.grey.shade300,
                              indent: Sizes.size10,
                              endIndent: Sizes.size10,
                            ),
                            AccounProperty(number: "10.5M", title: "Followers"),
                            VerticalDivider(
                              width: Sizes.size32,
                              thickness: Sizes.size1,
                              color: Colors.grey.shade300,
                              indent: Sizes.size10,
                              endIndent: Sizes.size10,
                            ),
                            AccounProperty(number: "149.3M", title: "Likes"),
                          ],
                        ),
                      ),
                      Gaps.v12,
                      FractionallySizedBox(
                        widthFactor: 0.33,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: Sizes.size12),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(Sizes.size4),
                            ),
                          ),
                          child: Text(
                            "Follow",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Gaps.v12,
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: Sizes.size32),
                        child: Text(
                          "All highlights and where to watch live matches on FIFA+ I wonder how it would loook",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Gaps.v14,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          FaIcon(FontAwesomeIcons.link, size: Sizes.size12),
                          Gaps.h4,
                          Text(
                            "https://nomadcoders.co",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      Gaps.v14,
                    ],
                  ),
                ),
                SliverPersistentHeader(
                  delegate: PersistentTabBar(),
                  pinned: true,
                ),
              ];
            },
            body: TabBarView(
              children: [
                //gridView: delegate는 controller와 다르게 도우미 역할이다
                GridView.builder(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: EdgeInsets.only(top: Sizes.size5),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    // 가로로 몇개의 column을 가질지를 정해준다
                    crossAxisCount: 3,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                    childAspectRatio: 9 / 12,
                  ),
                  itemCount: 20,
                  itemBuilder: (context, index) => Column(
                    children: [
                      //AspectRatio: 특정한 비율을 따르는 위젯을 만들어준다 fit을 써서 부모요소에 어떤방식으로 적용할 지 정함
                      AspectRatio(
                        aspectRatio: 9 / 12,
                        //FadeInImage: 네트워크를통해 받아오는 동안 로컬에 있는 이미지를 보여주고 완료되면 네트워크 이미지를 보여준다
                        child: FadeInImage.assetNetwork(
                          fit: BoxFit.cover,
                          placeholder: "assets/images/test.jpg",
                          image:
                              "https://images.unsplash.com/photo-1673844969019-c99b0c933e90?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1480&q=80",
                        ),
                      ),
                    ],
                  ),
                ),
                const Center(child: Text('Page two')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
