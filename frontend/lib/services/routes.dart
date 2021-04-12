import 'package:flutter/material.dart';
import 'package:frontend/views/dreams.dart';
import 'package:frontend/views/info/info_internet.dart';
import 'package:frontend/views/survey/survey_dream.dart';
import 'package:frontend/views/survey/survey_psqi.dart';
import 'package:page_transition/page_transition.dart';
import 'package:frontend/initial_page.dart';
import 'package:frontend/views/add_dream.dart';
import 'package:frontend/views/intro/general_information.dart';
import 'package:frontend/views/home.dart';
import 'package:frontend/views/info/info_app.dart';
import 'package:frontend/views/info/info_privacy.dart';
import 'package:frontend/views/survey/survey_chronotype.dart';


class Routes {

  static Route<dynamic> routes(RouteSettings settings) {

    switch (settings.name) {

      case '/done':
        return PageTransition(
            type: PageTransitionType.fade,
            child: GeneralInformation()
        );
        break;

      case '/home':
        return PageTransition(
            type: PageTransitionType.fade,
            child: Home()
        );
        break;

      case '/privacy':
        return PageTransition(
            type: PageTransitionType.fade,
            child: InfoPrivacy()
        );
        break;


      case '/info':
        return PageTransition(
            type: PageTransitionType.fade,
            child: InfoApp()
        );
        break;

      case '/internet':
        return PageTransition(
            type: PageTransitionType.fade,
            child: InfoInternet()
        );
        break;

      case '/add':
        return PageTransition(
            type: PageTransitionType.fade,
            child: AddDream()
        );
        break;

      case '/chronotype':
        return PageTransition(
            type: PageTransitionType.fade,
            child: SurveyChronotype()
        );
        break;

      case '/psqi':
        return PageTransition(
            type: PageTransitionType.fade,
            child: SurveyPSQI()
        );
        break;

      case '/dreams':
        return PageTransition(
            type: PageTransitionType.fade,
            child: Dreams()
        );
        break;

      case '/report_dream':
        return PageTransition(
            type: PageTransitionType.fade,
            child: SurveyDream()
        );
        break;

      case '/':
        return PageTransition(
            type: PageTransitionType.leftToRight,
            child: InitialPage()
        );
        break;

      default:
        return errorPage();
    }
  }


  static Route<dynamic> errorPage() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Container(
            child: Center(
                child: Text(
                    'Page not found!',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    )
                )
            ),
          ),
        )
    );
  }

}
