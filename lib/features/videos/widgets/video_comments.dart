import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/utils.dart';

class VideoComments extends StatefulWidget {
  const VideoComments({super.key});

  @override
  State<VideoComments> createState() => _VideoCommentsState();
}

class _VideoCommentsState extends State<VideoComments> {
  final ScrollController _scrollController = ScrollController();
  bool _isWriting = false;
  void _onClosePressed() {
    Navigator.of(context).pop();
  }

  void _dismissKeyboard() {
    FocusScope.of(context).unfocus();
    setState(() {
      _isWriting = false;
    });
  }

  void _onStartWriting() {
    setState(() {
      _isWriting = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; //MediaQuery: 유저의 폰의 정보를 제공해줌
    final isDark = isDarkMode(context);
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        height: size.height * 0.75,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizes.size14),
        ),
        child: Scaffold(
          backgroundColor: isDark ? null : Colors.grey.shade50,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: isDark ? null : Colors.grey.shade50,
            title: Text(
              "2796 comments",
              style: TextStyle(
                fontSize: Sizes.size12,
                fontWeight: FontWeight.w600,
              ),
            ),
            actions: [
              IconButton(
                onPressed: _onClosePressed,
                icon: FaIcon(FontAwesomeIcons.xmark),
              ),
            ],
          ),
          body: GestureDetector(
            onTap: _dismissKeyboard,
            child: Stack(
              children: [
                Scrollbar(
                  controller: _scrollController,
                  child: ListView.separated(
                    controller: _scrollController,
                    padding: EdgeInsets.only(
                      top: 10,
                      bottom: Sizes.size96 + Sizes.size28,
                      left: Sizes.size16,
                      right: Sizes.size16,
                    ),
                    separatorBuilder: (context, index) => Gaps.v12,
                    itemCount: 10,
                    itemBuilder: (context, index) => Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: Sizes.size16,
                          child: Text(
                            "Name",
                            style: TextStyle(fontSize: Sizes.size10),
                          ),
                        ),
                        Gaps.h8,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "gamapsfun",
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: Sizes.size12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                "That's not it l've seen the same thing but also in a cave",
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: Sizes.size14,
                                ),
                              ),
                              Gaps.v2,
                              Row(
                                children: [
                                  Text(
                                    "createdAt",
                                    style: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontSize: Sizes.size12,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  Gaps.h4,
                                  Text(
                                    "Reply",
                                    style: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontSize: Sizes.size12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              Gaps.v8,
                              Row(
                                children: [
                                  Text(
                                    "View replies(194)",
                                    style: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontSize: Sizes.size12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Gaps.h4,
                                  FaIcon(
                                    FontAwesomeIcons.angleDown,
                                    size: Sizes.size12,
                                    color: Colors.grey.shade700,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Gaps.h10,
                        Column(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.heart,
                              size: Sizes.size20,
                              color: Colors.grey.shade500,
                            ),
                            Text(
                              "52.2k",
                              style: TextStyle(color: Colors.grey.shade700),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  width: constraints.maxWidth,
                  child: BottomAppBar(
                    // height: Sizes.size52,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: Sizes.size16,

                            child: Text(
                              "Name",
                              style: TextStyle(fontSize: Sizes.size10),
                            ),
                          ),
                          Gaps.h8,
                          Expanded(
                            child: TextField(
                              onTap: _onStartWriting,
                              expands: true,
                              minLines: null,
                              maxLines: null,
                              textInputAction: TextInputAction.newline,
                              cursorColor: Theme.of(context).primaryColor,
                              decoration: InputDecoration(
                                hintText: "Add comment...",
                                hintStyle: TextStyle(
                                  fontSize: Sizes.size14,
                                  fontWeight: FontWeight.w300,
                                  color: isDark ? Colors.white : null,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    Sizes.size12,
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: isDark
                                    ? Colors.grey.shade800
                                    : Colors.grey.shade200,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.at,
                                        color: isDark
                                            ? Colors.grey.shade500
                                            : Colors.grey.shade900,
                                        size: Sizes.size20,
                                      ),
                                      Gaps.h16,
                                      FaIcon(
                                        FontAwesomeIcons.gift,
                                        color: isDark
                                            ? Colors.grey.shade500
                                            : Colors.grey.shade900,
                                        size: Sizes.size20,
                                      ),
                                      Gaps.h16,
                                      FaIcon(
                                        FontAwesomeIcons.faceSmile,
                                        color: isDark
                                            ? Colors.grey.shade500
                                            : Colors.grey.shade900,
                                        size: Sizes.size20,
                                      ),
                                      Gaps.h16,
                                      if (_isWriting)
                                        GestureDetector(
                                          onTap: _dismissKeyboard,
                                          child: FaIcon(
                                            FontAwesomeIcons.circleArrowUp,
                                            color: Theme.of(
                                              context,
                                            ).primaryColor,
                                            size: Sizes.size20,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
