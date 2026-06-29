import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/breakpoints.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

final tabs = ["Top", "Users", "Videos", "Sounds", "LIVE", "Shopping"];

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final TextEditingController _textEditingController = TextEditingController(
    text: "initial Text",
  );

  bool _hasText = false;

  void _onSearchChanged(String value) {
    print("changed $value");
  }

  void _onSearchSubmitted(String value) {
    print("submit $value");
  }

  void _dismissKeyboard() {
    FocusScope.of(context).unfocus();
  }

  void _onClearTap() {
    _textEditingController.clear();
    setState(() {
      _hasText = false;
    });
  }

  void _onWriting() {
    _hasText = _textEditingController.text.isNotEmpty;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(_onWriting);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: tabs.length,
      child: GestureDetector(
        onTap: _dismissKeyboard,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            // title: CupertinoSearchTextField(
            //   controller: _textEditingController,
            //   onChanged: _onSearchChanged,
            //   onSubmitted: _onSearchSubmitted,
            // ),

            //constrainedBox 를 감싸주므로 크기를 제한할 수 있다 하지만 container는 속성을 constraints속성을 이용하면된다.
            title: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: Breakpoints.sm),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: Sizes.size36,
                      child: TextField(
                        onChanged: _onSearchChanged,
                        onSubmitted: _onSearchSubmitted,
                        controller: _textEditingController,
                        cursorColor: Theme.of(context).primaryColor,
                        textAlignVertical: TextAlignVertical.top,
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FaIcon(
                              FontAwesomeIcons.magnifyingGlass,
                              size: Sizes.size16 + Sizes.size2,
                            ),
                          ),
                          suffixIcon: _hasText
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: _onClearTap,
                                    child: FaIcon(
                                      FontAwesomeIcons.circleXmark,
                                      size: Sizes.size16 + Sizes.size2,
                                    ),
                                  ),
                                )
                              : null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Sizes.size2),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Gaps.h8,
                  FaIcon(FontAwesomeIcons.toolbox),
                ],
              ),
            ),
            //bottom : preferredSizeWidget => 위젯 자체는 특정사이즈를 가지려고 하지만 그 위젯 안의 자식요소가 부모요소의 크기제한을 받지 않는다
            bottom: TabBar(
              onTap: (index) => _dismissKeyboard(),
              padding: EdgeInsets.only(left: 0),
              splashFactory: NoSplash.splashFactory,
              isScrollable: true,
              labelStyle: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: Sizes.size16,
              ),
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey.shade500,
              indicatorColor: Colors.black,
              tabs: [for (var tab in tabs) Tab(text: tab)],
            ),
          ),
          body: TabBarView(
            children: [
              //gridView: delegate는 controller와 다르게 도우미 역할이다
              GridView.builder(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: EdgeInsets.all(Sizes.size8),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  // 가로로 몇개의 column을 가질지를 정해준다
                  crossAxisCount: width > Breakpoints.lg ? 5 : 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 9 / 21,
                ),
                itemCount: 20,
                itemBuilder: (context, index) => LayoutBuilder(
                  builder: (context, constraints) => Column(
                    children: [
                      //AspectRatio: 특정한 비율을 따르는 위젯을 만들어준다 fit을 써서 부모요소에 어떤방식으로 적용할 지 정함
                      Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Sizes.size4),
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
                      Text(
                        "${constraints.maxWidth}This is a very long caption for my tiktok that im upload just now currently.",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: Sizes.size16 + Sizes.size2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gaps.v5,
                      if (constraints.maxWidth < 190 ||
                          constraints.maxWidth > 230)
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
              ),
              for (var tab in tabs.skip(1))
                Center(child: Text(tab, style: TextStyle(fontSize: 28))),
            ],
          ),
        ),
      ),
    );
  }
}
