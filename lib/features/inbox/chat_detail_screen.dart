import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/utils.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({super.key});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final ScrollController _scrollController = ScrollController();

  void _dismissKeyboard() {
    FocusScope.of(context).unfocus();
  }

  void _onTextFieldTap() {
    // 키보드 올라온 후 스크롤 이동 (딜레이 필요)
    Future.delayed(Duration(milliseconds: 300), () {
      _scrollController.animateTo(
        _scrollController.position.minScrollExtent,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: Sizes.size10,
          leading: Stack(
            children: [
              CircleAvatar(
                radius: Sizes.size20,
                foregroundImage: NetworkImage(
                  "https://avatars.githubusercontent.com/u/3612017",
                ),
                child: Text('니꼬'),
              ),
              Positioned(
                bottom: 1,
                right: 0,
                width: Sizes.size16,
                height: Sizes.size16,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.lightGreen,
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                ),
              ),
            ],
          ),
          title: Text('니꼬', style: TextStyle(fontWeight: FontWeight.w600)),
          subtitle: Text('Active now'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(FontAwesomeIcons.flag, size: Sizes.size20),
              Gaps.h32,
              FaIcon(FontAwesomeIcons.ellipsis, size: Sizes.size20),
            ],
          ),
        ),
      ),
      body: GestureDetector(
        onTap: _dismissKeyboard,
        child: Column(
          children: [
            Expanded(
              child: Scrollbar(
                controller: _scrollController,
                child: ListView.separated(
                  reverse: true,
                  controller: _scrollController,
                  padding: EdgeInsets.symmetric(
                    vertical: Sizes.size20,
                    horizontal: Sizes.size14,
                  ),
                  itemBuilder: (context, index) {
                    final isMine = index % 2 == 0;
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: isMine
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(Sizes.size14),
                          decoration: BoxDecoration(
                            color: isMine
                                ? Colors.blue
                                : Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(Sizes.size20),
                              topRight: const Radius.circular(Sizes.size20),
                              bottomLeft: Radius.circular(
                                isMine ? Sizes.size20 : Sizes.size5,
                              ),
                              bottomRight: Radius.circular(
                                !isMine ? Sizes.size20 : Sizes.size5,
                              ),
                            ),
                          ),
                          child: const Text(
                            "this is a message!",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: Sizes.size16,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => Gaps.v10,
                  itemCount: 10,
                ),
              ),
            ),
            BottomAppBar(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      height: Sizes.size44,
                      child: TextField(
                        onTap: _onTextFieldTap,
                        expands: true,
                        maxLines: null,
                        minLines: null,
                        textInputAction: TextInputAction.newline,
                        decoration: InputDecoration(
                          hintText: "Send a message...",
                          hintStyle: TextStyle(
                            fontSize: Sizes.size14,
                            fontWeight: FontWeight.w300,
                            color: isDark ? Colors.white : null,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: Sizes.size16,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                              Radius.circular(Sizes.size20),
                            ),
                          ),
                          filled: true,
                          fillColor: isDark
                              ? Colors.grey.shade800
                              : Colors.white,
                          suffixIcon: Padding(
                            padding: EdgeInsets.only(top: 10, left: 10),
                            child: FaIcon(
                              FontAwesomeIcons.faceSmile,
                              color: isDark ? Colors.white : null,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Gaps.h16,
                  Container(
                    padding: EdgeInsets.only(left: 6, top: 8),
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.grey.shade500
                          : Colors.grey.shade200,
                      shape: BoxShape.circle,
                    ),
                    child: FaIcon(
                      FontAwesomeIcons.solidPaperPlane,
                      color: isDark ? Colors.black : Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
