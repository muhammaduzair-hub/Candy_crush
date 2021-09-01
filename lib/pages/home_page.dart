import 'package:flutter_application2/animations/shine_effect.dart';
import 'package:flutter_application2/bloc/bloc_provider.dart';
import 'package:flutter_application2/bloc/game_bloc.dart';
import 'package:flutter_application2/game_widgets/double_curved_container.dart';
import 'package:flutter_application2/game_widgets/game_level_button.dart';
import 'package:flutter_application2/game_widgets/shadowed_text.dart';
import 'package:flutter_application2/model/level.dart';
import 'package:flutter_application2/pages/demo/selectcandies.dart';
import 'package:flutter_application2/pages/game_page.dart';
import 'package:flutter/material.dart';

import 'demo/demo_game_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3500),
    )
      ..addListener(() {
        setState(() {});
      });

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.6,
          1.0,
          curve: Curves.easeInOut,
        ),
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });

  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    GameBloc gameBloc = BlocProvider.of<GameBloc>(context);
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    Size screenSize = mediaQueryData.size;
    double levelsWidth = -100.0 + ((mediaQueryData.orientation == Orientation.portrait) ? screenSize.width : screenSize.height);
    return Scaffold(
      body: WillPopScope(
        //No way to get back
        onWillPop: () async => false,
        child: Stack(
          children: <Widget>[
            Container(

              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background/background5.jpg'),
                  fit: BoxFit.cover,

                ),
              ),
            ),
            // Container(
            // body: Center(
            //  child: Center(
            // child: ElevatedButton(
            // onPressed: () {
            //  Navigator.push(context, MaterialPageRoute(builder: (context) => MyTask()));
            // Navigator.pop(context);
            // print('VALUE')
            // Navigate back to first route when tapped.
            //},
            //child: Text('Demo'),
            // ),
            // ),
            // ),
            Container(
              // body: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  print('VALUE')
                  ;
                  // Navigate back to first route when tapped.
                },
                child: Text('Go back!'),
              ),
            ),

            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ShadowedText(
                  text: '  By : Junaid Awan ',
                  color: Colors.white,
                  fontSize: 12.0,
                  offset: Offset(1.0, 1.0),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: AspectRatio(
                aspectRatio: 1.0,
                child: Container(
                  width: levelsWidth,
                  height: levelsWidth,
                  child: GridView.builder(
                    itemCount: 6,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.01,
                    ),
                    itemBuilder: (BuildContext context, int index){
                      return GameLevelButton(
                        width: 80.0,
                        height: 60.0,
                        borderRadius: 50.0,
                        text: index+1==6?'Demo': 'Level ${index + 1}',
                        onTap: () async {
                          if(index+1==6)
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SelectCandies(level: index+1,),));
                          // Open the Game page
                          else
                            {
                              Level newLevel = await gameBloc.setLevel(index + 1);
                              Navigator.of(context).push(GamePage.route(newLevel));
                            }
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0.0,

              top: _animation.value * 100.0 + 80.0,

              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: DoubleCurvedContainer(

                  width: screenSize.width - 60.0,
                  height: 150.0,
                  outerColor: Colors.orangeAccent[700],
                  innerColor: Colors.orangeAccent,
                  child: Stack(
                    children: <Widget>[
                      ShineEffect(
                        offset: Offset(250.0, 150.0),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: ShadowedText(
                          text: '^ LEVELS ^',
                          color: Colors.purpleAccent,

                          fontSize: 40.0,
                          shadowOpacity: 1.0,
                          offset: Offset(1.0,1.0),
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
    );
  }
}