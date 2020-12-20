import 'package:chat/pages/register_page.dart';
import 'package:chat/theme/theme.dart';
import 'package:chat/widgets/button_gold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnBoardingSelector extends StatefulWidget {
  final List<Widget> pages;

  const OnBoardingSelector({
    Key key,
    this.pages,
  }) : super(key: key);

  @override
  _OnBoardingSelectorState createState() => _OnBoardingSelectorState();
}

class _OnBoardingSelectorState extends State<OnBoardingSelector> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<ThemeChanger>(context).currentTheme;

    bool _isLastPage = widget.pages.length == this._currentPage + 1;

    Size _size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: _size.height,
          alignment: Alignment.center,
          child: PageView(
            physics: ClampingScrollPhysics(),
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                this._currentPage = page;
              });
            },
            children: widget.pages,
          ),
        ),
        (!_isLastPage)
            ? Positioned(
                left: _size.width / 2.5,
                top: _size.height * 0.7,
                child: Row(
                  children: _buildPageIndicator(),
                ),
              )

            /* : StyledButton(
                label: "Ingresar",
                borderColor: Colors.transparent,
                press: () => {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/login', (route) => false)
                },
              ), */
            /*  (_isLastPage)
            ? StyledButton(
                label: "Create Account",
                backgroundColor: Colors.transparent,
                borderColor: Color(0xff3374F8),
                fontColor: Color(0xff3374F8),
                borderWidth: 2,
                press: () => {
     
                },
              )
            : */
            : Container(
                padding: EdgeInsets.only(
                    top: _size.height * 0.7, left: 60, right: 60),
                child: ButtonGold(
                    color: currentTheme.accentColor,
                    text: 'Start now!',
                    onPressed: () => {Navigator.push(context, _createRute())}),
              ),
        SizedBox(
          height: (_isLastPage) ? 115 : 150,
        ),
        Center(
          child: Container(
              padding: EdgeInsets.only(top: _size.height * 0.9),
              child: StyledLogoCustom()),
        ),
      ],
    );
  }

  Route _createRute() {
    return PageRouteBuilder(
        pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) =>
            RegisterPage(),
        transitionDuration: Duration(seconds: 1),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final curvedAnimation =
              CurvedAnimation(parent: animation, curve: Curves.easeInOut);

          // return SlideTransition(
          //   position: Tween<Offset>(begin: Offset(0.0, -1.0), end: Offset.zero ).animate(curvedAnimation),
          //   child: child,
          // );

          // return ScaleTransition(
          //   child: child,
          //   scale: Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation)
          // );

          // RotationTransition
          // return RotationTransition(
          //   child: child,
          //   turns: Tween<double>(begin: 0.0, end: 1.0 ).animate(curvedAnimation)
          // );

          // return FadeTransition(
          //   child: child,
          //   opacity: Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation)
          // );

          return FadeTransition(
              child: child,
              opacity:
                  Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation));
        });
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    int numberOfPages = widget.pages.length;
    for (int i = 0; i < numberOfPages; i++) {
      list.add(_indicator(numberOfPages, i));
    }
    return list;
  }

  Widget _indicator(int numberOfPages, int index) {
    final currentTheme = Provider.of<ThemeChanger>(context).currentTheme;

    double _size;

    Color _color;

    if (_currentPage >= index - 0.5 && _currentPage < index + 0.5) {
      _size = 20;
      _color = currentTheme.primaryColor;
    } else {
      _size = 15;
      _color = currentTheme.scaffoldBackgroundColor;
    }
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      height: _size,
      width: _size,
      margin: EdgeInsets.symmetric(horizontal: 3),
      child: Container(
        decoration: new BoxDecoration(
          color: _color,
          shape: BoxShape.circle,
          border: new Border.all(
            color: Colors.white.withOpacity(0.30),
            width: 1.5,
          ),
        ),
        child: Container(
          decoration: new BoxDecoration(
            color: _color,
            shape: BoxShape.circle,
            border: new Border.all(
              color: Colors.black,
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}

class StyledLogoCustom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<ThemeChanger>(context).currentTheme;

    return RichText(
      textAlign: TextAlign.center,
      text: new TextSpan(
        children: [
          TextSpan(
            text: "examp",
            style: TextStyle(
              fontFamily: 'GTWalsheimPro',
              color: Color(0xff4b3232),
              fontSize: 27,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
            ),
          ),
          TextSpan(
            text: "Logo",
            style: TextStyle(
              fontFamily: 'GTWalsheimPro',
              fontStyle: FontStyle.normal,
              color: currentTheme.accentColor,
              fontSize: 27,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
