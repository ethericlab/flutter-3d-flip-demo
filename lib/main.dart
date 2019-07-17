import 'dart:math';
import 'package:flutter/widgets.dart';
import './common.dart';

void main() => runApp(DemoFlip3DApp());

class DemoFlip3DApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      title: '3D Flip Demo App',
      color: Colors.black,
      home: Home(),
      pageRouteBuilder: <T>(RouteSettings settings, WidgetBuilder builder) =>
          PageRouteBuilder<T>(
              pageBuilder: (BuildContext context, _, __) => builder(context)),
    );
  }
}

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController _controller;
  var currentPageValue = 0.0;

  final List<Widget> _pages = [
    OnboardingPage(
      color: Colors.blue,
      title: "Read\nBooks\nEasy",
      text: "No matter where you go, your books are always with you.",
      image: AssetImage('assets/images/image1.png'),
    ),
    OnboardingPage(
      color: Colors.teal,
      title: "Share\nWith\nFriends",
      text:
          "Your reading list might be shared with your community and fellows.",
      image: AssetImage('assets/images/image2.png'),
    ),
    OnboardingPage(
      color: Colors.purple,
      title: "Track\nYour\nProgress",
      text:
          "Get insights into your reading preferences and analysis of time spent.",
      image: AssetImage('assets/images/image3.png'),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = PageController();

    _controller.addListener(() {
      setState(() {
        currentPageValue = _controller.page;
//        currentPageValue = 0.5;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        // BG layer
        Container(
          color: Colors.black,
        ),
        _buildCardLayer()
      ],
    );
  }

  Widget _buildCardLayer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(
          height: 84,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 60),
          child: PageIndicator(
            count: _pages.length,
            current: currentPageValue.round(),
          ),
        ),
        Expanded(
          child: PageView.builder(
            controller: _controller,
            itemCount: _pages.length,
            itemBuilder: (context, position) {
              final page = Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: _pages[position],
              );

              if (position == currentPageValue.floor()) {
                return Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.0015) // perspective
                    ..rotateY(-pi / 16 * (currentPageValue - position)),
                  child: page,
                );
              } else if (position == currentPageValue.floor() + 1) {
                return Transform(
                  alignment: FractionalOffset.topRight,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.0015) // perspective
                    ..rotateY(-pi / 16 * (currentPageValue - position)),
                  child: page,
                );
              } else {
                return page;
              }
            },
          ),
        ),
        SizedBox(
          height: 60,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class OnboardingPage extends StatelessWidget {
  const OnboardingPage(
      {Key key,
      @required this.text,
      @required this.color,
      @required this.title,
      @required this.image})
      : super(key: key);

  final String title;
  final String text;
  final Color color;
  final ImageProvider image;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(
          height: 50,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            title,
            style: TextStyles.sfProDisplayBold.copyWith(fontSize: 48),
          ),
        ),
        SizedBox(
          height: 37,
        ),
        Expanded(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: _buildCard()),
        ),
        SizedBox(
          height: 12,
        ),
      ],
    );
  }

  Widget _buildCard() {
    return Container(
      // height: 390,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(32)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              text,
              style: TextStyles.sfProTextRegular.copyWith(fontSize: 20),
            ),
          ),
          Expanded(
            child: SizedBox(),
          ),
          Image(
            height: 190,
            image: image,
            fit: BoxFit.contain,
          ),
          SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}

class PageIndicator extends StatelessWidget {
  const PageIndicator({Key key, this.count, this.current}) : super(key: key);

  final int count;
  final int current;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(count + (count - 1), (index) {
        // Build spacer on odd indexes
        if (index % 2 == 1) {
          return SizedBox(width: 10,);
        }
        // Other build indicator items
        if (index / 2 == current) {
          return _buildActive();
        }

        return _buildIInactive();
      }),
    );
  }

  Widget _buildActive() {
    return Container(
      height: 8,
      width: 8,
      decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(4)
      ),
    );
  }

  Widget _buildIInactive() {
    return Container(
      height: 8,
      width: 8,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(4)
      ),
    );
  }
}

