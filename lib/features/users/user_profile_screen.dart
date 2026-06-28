import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/users/widgets/accoun_property.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text("HoSeok"),
            actions: [
              IconButton(
                onPressed: () {},
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
                      "@hoseok",
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
                Container(
                  decoration: BoxDecoration(
                    border: Border.symmetric(
                      horizontal: BorderSide(
                        color: Colors.grey.shade300,
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: TabBar(
                    splashFactory: NoSplash.splashFactory,
                    labelPadding: EdgeInsets.symmetric(vertical: Sizes.size10),
                    indicatorColor: Colors.black,
                    unselectedLabelColor: Colors.grey.shade500,
                    labelColor: Colors.black,
                    dividerColor: Colors.transparent,
                    tabs: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Sizes.size20,
                        ),
                        child: FaIcon(FontAwesomeIcons.gripVertical),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Sizes.size20,
                        ),
                        child: FaIcon(FontAwesomeIcons.heart),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  // TabBarView는 무한대의 크기를 가지기 때문에 크기를 정해줘야 한다.
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: TabBarView(
                    children: [
                      //gridView: delegate는 controller와 다르게 도우미 역할이다
                      GridView.builder(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        padding: EdgeInsets.all(Sizes.size8),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          // 가로로 몇개의 column을 가질지를 정해준다
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 9 / 21,
                        ),
                        itemCount: 20,
                        itemBuilder: (context, index) => Column(
                          children: [
                            //AspectRatio: 특정한 비율을 따르는 위젯을 만들어준다 fit을 써서 부모요소에 어떤방식으로 적용할 지 정함
                            Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  Sizes.size4,
                                ),
                              ),
                              child: AspectRatio(
                                aspectRatio: 9 / 16,
                                //FadeInImage: 네트워크를통해 받아오는 동안 로컬에 있는 이미지를 보여주고 완료되면 네트워크 이미지를 보여준다
                                child: FadeInImage.assetNetwork(
                                  fit: BoxFit.cover,
                                  placeholder: "assets/images/test.jpg",
                                  image:
                                      "https://images.unsplash.com/photo-1673844969019-c99b0c933e90?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1480&q=80",
                                ),
                              ),
                            ),
                            Gaps.v10,
                            const Text(
                              "This is a very long caption for my tiktok that im upload just now currently.",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: Sizes.size16 + Sizes.size2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Gaps.v5,
                            DefaultTextStyle(
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w600,
                              ),
                              child: Row(
                                children: [
                                  const CircleAvatar(
                                    radius: 12,
                                    backgroundImage: NetworkImage(
                                      "https://avatars.githubusercontent.com/u/3612017",
                                    ),
                                  ),
                                  Gaps.h4,
                                  const Expanded(
                                    child: Text(
                                      "My avatar is going to be very long",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Gaps.h4,
                                  FaIcon(
                                    FontAwesomeIcons.heart,
                                    size: Sizes.size16,
                                    color: Colors.grey.shade600,
                                  ),
                                  Gaps.h2,
                                  const Text("2.5M"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Center(child: Text('Page two')),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
