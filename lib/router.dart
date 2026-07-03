import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/common/widgets/main_navigation/main_navigation_screen.dart';
import 'package:tiktok_clone/features/authentication/login_screen.dart';
import 'package:tiktok_clone/features/authentication/sign_up_screen.dart';
import 'package:tiktok_clone/features/onboarding/interests_screen.dart';
//navigator 2.0은 1.0의 웹 브라우저에서 앞으로가기기능 보완과 url의 변수를 사용할 수 있도록 하여 웹, 앱 모두 작동하기 위해 사용된다.

/* Router
/ sign up
	/username
	/email
	/password
	/birthday
	

/login
	/login form

/onboarding
	/onboarding Interesting
	/onboarding Tutorial

(index => url)
/home -> home
/discover -> discover
/inbox -> inbox
/profile -> profile
—————————————————— */
final router = GoRouter(
  routes: [
    GoRoute(
      name: SignUpScreen.routeName,
      path: SignUpScreen.routeURL,
      builder: (context, state) => SignUpScreen(),
    ),
    GoRoute(
      name: LoginScreen.routeName,
      path: LoginScreen.routeURL,
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      name: InterestsScreen.routeName,
      path: InterestsScreen.routeURL,
      builder: (context, state) => InterestsScreen(),
    ),
    GoRoute(
      path:
          "/:tab(home|discover|inbox|profile)", //“/:tab”이라 하면 모든 스트링이 적용되므로 제한한다.
      name: MainNavigationScreen.routeName,
      builder: (context, state) {
        var tab = state.params["tab"]!;
        return MainNavigationScreen(tab: tab);
      },
    ),
  ],
);





/*  ROUTER
"/"=>SignUpScreen
  "username"=>UsernameScreen
    "email"=>EmailScreen
*/
    /* GoRoute(
      name: SignUpScreen.routeName,
      path: SignUpScreen.routeURL,
      builder: (context, state) => SignUpScreen(),
      routes: [
        GoRoute(
          path: UsernameScreen.routeURL,
          name: UsernameScreen.routeName,
          builder: (context, state) => UsernameScreen(),
          routes: [
            GoRoute(
              name: EmailScreen.routeName,
              path: EmailScreen.routeURL,
              builder: (context, state) {
                final args = state.extra as EmailScreenArgs;
                return EmailScreen(username: args.username);
              },
            ),
          ],
        ),
      ],
    ),

    /* 
    GoRoute(
      path: LoginScreen.routeName,
      builder: (context, state) => const LoginScreen(),
    ),
    */

    /* add Animation
    GoRoute(
      name: "username_screen",
      path: UsernameScreen.routeName,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: UsernameScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(scale: animation, child: child),
            );
          },
        );
      },
    ), */
    GoRoute(
      path: "/users/:username",
      builder: (context, state) {
        final username = state.params['username'];
        final tab = state.queryParams['show'];
        return UserProfileScreen(username: username!, tab: tab!);
      },
    ), */
