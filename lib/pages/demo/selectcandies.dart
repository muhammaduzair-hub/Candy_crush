import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application2/MyThings/demopage_things.dart';
import 'package:flutter_application2/bloc/bloc_provider.dart';
import 'package:flutter_application2/bloc/game_bloc.dart';
import 'package:flutter_application2/model/level.dart';
import 'package:flutter_application2/model/tile.dart';
import 'package:flutter_application2/pages/demo/demo_game_page.dart';

class SelectCandies extends StatefulWidget {

  final int level;
  const SelectCandies({Key key, this.level}) : super(key: key);

  @override
  _SelectCandiesState createState() => _SelectCandiesState();
}

class _SelectCandiesState extends State<SelectCandies> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      DemoPageThings.demo = true;
    });
    print(DemoPageThings.demo?"true":"false");
    Timer.run(() {popupresume();});
  }

  //custom candies selection
  bool red=false;
  bool purple = false;
  bool yellow = false;
  bool orange = false;
  bool blue = false;
  bool initend = false;

  popupresume(){
    GameBloc gameBloc = BlocProvider.of<GameBloc>(context);
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    Size screenSize = mediaQueryData.size;
    double levelsWidth = -100.0 + ((mediaQueryData.orientation == Orientation.portrait) ? screenSize.width : screenSize.height);
    showDialog(
      context: context,
      builder: (_)=> AlertDialog(
        // title: Text("MOB End", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20, color: Colors.white),),
        title: Container(
          height: 290,
          //color: Colors.green,
          child: Column(
            children: [
              ListTile(
                title: Text("Red", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                leading: CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage("assets/images/tiles/red.png",),
                  backgroundColor: Colors.blue,
                ),
                trailing:StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState){
                    return Checkbox(
                      activeColor: Colors.yellow,
                      checkColor: Colors.red,
                      value: this.red,
                      onChanged: (bool value) {
                        setState(() {
                          this.red = value;
                        });
                      },
                    );
                  },
                ),

              ),
              ListTile(
                title: Text("Yellow", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                leading: CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage("assets/images/tiles/yellow.png",),
                  backgroundColor: Colors.blue,
                ),
                trailing:StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState){
                    return Checkbox(
                      activeColor: Colors.yellow,
                      checkColor: Colors.red,
                      value: this.yellow,
                      onChanged: (bool value) {
                        setState(() {
                          this.yellow = value;
                        });
                      },
                    );
                  },
                ),

              ),
              ListTile(
                title: Text("Purple", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                leading: CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage("assets/images/tiles/purple.png",),
                  backgroundColor: Colors.blue,
                ),
                trailing:StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState){
                    return Checkbox(
                      activeColor: Colors.yellow,
                      checkColor: Colors.red,
                      value: this.purple,
                      onChanged: (bool value) {
                        setState(() {
                          this.purple = value;
                        });
                      },
                    );
                  },
                ),

              ),
              ListTile(
                title: Text("Blue", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                leading: CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage("assets/images/tiles/blue.png",),
                  backgroundColor: Colors.blue,
                ),
                trailing:StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState){
                    return Checkbox(
                      activeColor: Colors.yellow,
                      checkColor: Colors.red,
                      value: this.blue,
                      onChanged: (bool value) {
                        setState(() {
                          this.blue = value;
                        });
                      },
                    );
                  },
                ),

              ),
              ListTile(
                title: Text("Orange", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                leading: CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage("assets/images/tiles/orange.png",),
                  backgroundColor: Colors.blue,
                ),
                trailing:StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState){
                    return Checkbox(
                      activeColor: Colors.yellow,
                      checkColor: Colors.red,
                      value: this.orange,
                      onChanged: (bool value) {
                        setState(() {
                          this.orange = value;
                        });
                      },
                    );
                  },
                ),

              ),
            ],
          ),
        ),
        backgroundColor: Colors.blue,
        elevation: 2.0,
        buttonPadding: EdgeInsets.symmetric(horizontal: 15),
        //shape: CircleBorder(),
        actions: [
          ElevatedButton(
            child: Text('Yes', style: TextStyle(fontSize: 16, color: Colors.white)),
            onPressed: () async {
              setState(() {
                if(this.red)DemoPageThings.tiles.add(TileType.red);
                if(this.orange)DemoPageThings.tiles.add(TileType.orange);
                if(this.blue)DemoPageThings.tiles.add(TileType.blue);
                if(this.purple)DemoPageThings.tiles.add(TileType.purple);
                if(this.yellow)DemoPageThings.tiles.add(TileType.yellow);
                DemoPageThings.tiles.add(TileType.green);
              });
              print('lenght isssssssssssssssssssssss${DemoPageThings.tiles.length}');
               if(DemoPageThings.tiles.length == 3 || DemoPageThings.tiles.length == 2){
                 Level newLevel= await gameBloc.setLevel(widget.level);
                 Navigator.of(context).pop();
                 Navigator.of(context).push(DemoGamePage.route(newLevel));
               }
              if(DemoPageThings.tiles.length == 4){
                Level newLevel= await gameBloc.setLevel(widget.level+1);
                Navigator.of(context).pop();
                Navigator.of(context).push(DemoGamePage.route(newLevel));
              }
              if(DemoPageThings.tiles.length == 5){
                Level newLevel= await gameBloc.setLevel(widget.level+2);
                Navigator.of(context).pop();
                Navigator.of(context).push(DemoGamePage.route(newLevel));
              }
              if(DemoPageThings.tiles.length == 6){
                Level newLevel= await gameBloc.setLevel(widget.level+3);
                Navigator.of(context).pop();
                Navigator.of(context).push(DemoGamePage.route(newLevel));
              }
            },
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background/background4.jpg'),
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );
  }
}
