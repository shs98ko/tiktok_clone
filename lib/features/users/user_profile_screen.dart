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
    return CustomScrollView(
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
              Gaps.v16,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("@hoseok"),
                  Gaps.h5,
                  FaIcon(
                    FontAwesomeIcons.solidCircleCheck,
                    size: Sizes.size16,
                    color: Colors.blue.shade300,
                  ),
                ],
              ),
              Gaps.v16,
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
            ],
          ),
        ),
      ],
    );
  }
}
