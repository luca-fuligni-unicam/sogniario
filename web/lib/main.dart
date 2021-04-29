import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:web/services/routes.dart';
import 'package:web/views/auth/login_page.dart';
import 'package:web/views/candidates_page.dart';
import 'package:web/views/home.dart';


void main() async {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sogniario',
      builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget),
          maxWidth: MediaQuery.of(context).size.width,
          minWidth: 480,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(480, name: MOBILE),
            ResponsiveBreakpoint.resize(780, name: TABLET),
            ResponsiveBreakpoint.resize(1080, name: DESKTOP),
          ],
          background: Container(color: Colors.white)
      ),
      initialRoute: Routes.login,
      onGenerateRoute: (RouteSettings settings) {
        return Routes.fadeThrough(settings, (context) {
          switch (settings.name) {
            case Routes.login:
              return Login();

            case Routes.home:
              return Home();

            case Routes.candidates:
              return CandidatesPage();

            default:
              return SizedBox.shrink();
          }
        });
      },
      theme: Theme.of(context).copyWith(platform: TargetPlatform.windows),
      debugShowCheckedModeBanner: false,
    );
  }
}
