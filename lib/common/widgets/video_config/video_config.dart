import 'package:flutter/widgets.dart';

//inheritedWidget: 위젯 최상위 트리에서 정의된 값도 접근할 수 있다
//primaryColor 지정과 같은 논리다

/*
1. 위젯을 현 최상단위젯을 감싸서 최상단트리로 만들어줘서 state를 접근할 수 있게하고
2. context를 사용하여 inheritedWidget에 직접적인 링크 요청을 한다.
3. of 생성자를 이용하여 .of(context)를 이용한다.
*/

// inheritWidget은 데이터는 제공하지만 연결된 위젯에서 수정할수 없다 -> 나중에 changeNotifier를 이용한다
// VideoConfigData는 데이터통로라고 보면 된다.
// 이런식으로 하면 앱 전체를 rebuild하게 되므로 비효율적이다
// 필요한 부분만 국소적 rebuild하도록 changeNotifier를 이용한다.

/* -> changeNotifier
changeNotifier: 데이터가 변경되었다고 알려주는 클래스이며 내가 원하는 클래스를 상속받게하여 커스텀할 수 있다 또한 변경되었다면 notifyListener()를 사용에 데이터를 변경하려는 부분이 듣도록한다
1.  데이터를 변경하려는 부분에 animatedBuilder를  활용하여 데이터가 변경되었다고 듣도록 한다.
2.  데이터를 변경하려는 부분에 이벤트리스너를 활용하여 데이터가 변경되었다고 듣도록 한다. 
*/

//값이 하나일 땐 valunotifier를 활용한다.
// final videoConfig = ValueNotifier(false);

//Provider
//provider: 데이터를 제공하고 어디서나 들어볼 수 있게 함
//inheritWidget처럼 최상단위젯을 감싸고 context.watch와 read를통해 값과 메소드를 불러와 들을수 있게 한다.
class VideoConfig extends ChangeNotifier {
  bool isMuted = false;
  bool isAutoplay = false;

  void toggleIsMuted() {
    isMuted = !isMuted;
    notifyListeners();
  }

  void toggleAutoplay() {
    isAutoplay = !isAutoplay;
    notifyListeners();
  }
}
