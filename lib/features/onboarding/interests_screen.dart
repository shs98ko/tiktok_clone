import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

const interests = [
  "Daily Life",
  "Comedy",
  "Entertainment",
  "Animals",
  "Food",
  "Beauty & Style",
  "Drama",
  "Learning",
  "Talent",
  "Sports",
  "Auto",
  "Family",
  "Fitness & Health",
  "DIY & Life Hacks",
  "Arts & Crafts",
  "Dance",
  "Outdoors",
  "Oddly Satisfying",
  "Home & Garden",
  "Daily Life",
  "Comedy",
  "Entertainment",
  "Animals",
  "Food",
  "Beauty & Style",
  "Drama",
  "Learning",
  "Talent",
  "Sports",
  "Auto",
  "Family",
  "Fitness & Health",
  "DIY & Life Hacks",
  "Arts & Crafts",
  "Dance",
  "Outdoors",
  "Oddly Satisfying",
  "Home & Garden",
];

class InterestsScreen extends StatelessWidget {
  const InterestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Choose your interests")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: Sizes.size24,
            right: Sizes.size24,
            bottom: Sizes.size16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Choose your interests",
                style: TextStyle(
                  fontSize: Sizes.size36,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v12,
              Text(
                "Get better video recommendations",
                style: TextStyle(
                  fontSize: Sizes.size20,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Gaps.v48,
              Wrap(
                runSpacing: 15, //세로
                spacing: 12, //가로
                children: [
                  //위젯의 데이터를 보여줄 때 정보량이 많으면 사용자가 보는 부분들만 render를 하는 collection for 대신  ListvVewBuilder를 사용한다.
                  for (var interest in interests)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Sizes.size24,
                        vertical: Sizes.size16,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(Sizes.size32),
                        border: Border.all(
                          color: Colors.black.withOpacity(0.1),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 5,
                            spreadRadius: 5,
                          ),
                        ],
                      ),

                      child: Text(
                        interest,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 2,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: Sizes.size16),
          decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          child: Text(
            "Next",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: Sizes.size20,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
