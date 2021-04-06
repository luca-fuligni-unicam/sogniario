import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';


class IntroPage extends StatefulWidget {

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {

  SwiperController _swiperController;
  final int _pageCount = 3;
  int _currentIndex = 0;

  final List<String> introTitles = [
    "Benvenuto su Sogniario!\nL'app creata per registrare i tuoi sogni!",
    "Prima di cominciare ad utilizzare l'app ti chiediamo alcune semplici informazioni.",
    "Tutto ciò che ci fornirai verrà memorizzato in modo anonimo e non sarà in alcun modo possibile risalire alla tua identità (vedi pagina 'Informativa sulla privacy')."
  ];

  List<String> intro = [
    'assets/intro/intro_1.jpg',
    'assets/intro/intro_2.jpg',
    'assets/intro/intro_3.jpg',
  ];

  @override
  void initState() {
    _swiperController = SwiperController();
    super.initState();
  }

  @override
  void dispose() {
    _swiperController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Stack(
            children: [

              Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/background.jpg',
                    fit: BoxFit.contain,
                  )
              ),

              Column(
                  children: [

                    Expanded(
                        child: Swiper(
                          index: _currentIndex,
                          controller: _swiperController,
                          itemCount: _pageCount,

                          onIndexChanged: (index) {
                            setState(() => _currentIndex = index);
                          },

                          loop: false,

                          itemBuilder: (context, index) {
                            return _buildPage(title: introTitles[index], image: intro[index]);
                          },
                        )
                    ),

                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 15, bottom: 15),
                        child: IconButton(
                          icon: Icon(
                            _currentIndex < _pageCount - 1
                                ? Icons.chevron_right : Icons.check,
                            size: 35,
                          ),
                          onPressed: () async {

                            if (_currentIndex < _pageCount - 1)
                              _swiperController.next();
                            else {
                              Navigator.pushNamed(context, '/done');
                            }
                          },
                        ),
                      ),
                    )

                  ]),
            ]),
      )
    );
  }


  Container _buildPage({String title, String image}) {

    final TextStyle titleStyle = TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0);

    return Container(
        margin: const EdgeInsets.fromLTRB(50, 40, 50, 40),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black38, BlendMode.multiply)
            ),

            boxShadow: [
              BoxShadow(
                  blurRadius: 10,
                  offset: Offset(5, 5),
                  color: Colors.black26
              )
            ]
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.end,

            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: titleStyle.copyWith(color: Colors.white),
              ),
            ])
    );
  }

}
