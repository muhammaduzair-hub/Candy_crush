import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_application/levels.dart';
//import 'package:flutter_application/start_1.dart';
import 'package:flutter_application2/pages/home_page.dart';



class GlowingButton extends StatefulWidget {
  
  final Color color1;
  final Color color2;
  final String text;
  final Icon icon;
 
  const GlowingButton(
      {Key key, this.color1 = Colors.cyan, this.color2 = Colors.greenAccent, this.text, this.icon, MainAxisAlignment mainAxisAlignment,})
      : super(key: key);
  @override
  _GlowingButtonState createState() => _GlowingButtonState(text,icon);
}

class _GlowingButtonState extends State<GlowingButton> {
  final String text;
  final Icon icon;
  
  
  var glowing = true;
  var scale = 1.0;

  _GlowingButtonState(this.text, this.icon);
  @override
  Widget build(BuildContext context) {
    
    //On mobile devices, gesture detector is perfect
    //However for desktop and web we can show this effect on hover too
    return GestureDetector(
      
      onTapUp: (val) {
       // Navigator.push(context, route(MaterialPage))
        setState(() {
          
          if(text=="PLAY")
             Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
           if(text=="EXIT")
           showDialog(
              context: context,
              builder: (BuildContext context) => _buildPopupDialog1(context),
              
            );
            else if(text=='YES')
            SystemNavigator.pop();
            else if(text=='NO')
           // Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));

               Navigator.pop(context);
          else if(text=='Level 1' )
           showDialog(
              context: context,
              builder: (BuildContext context) => _buildPopupDialog(context),
            );
          else if(text=='PLAY.' )
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
              else if(text=='BACK')
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => Homee()));
                   Navigator.pop(context);
                   else if(text=='BACK.')
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                  Navigator.pop(context);            
           // Navigator.push(context, MaterialPageRoute(builder: (context) =>  ()));
           
            
              // Navigator.push(context, MaterialPageRoute(builder: (context) => Levelf()));

          
           glowing = true;
          scale = 1.0;      
          
        });
      },
      onTapDown: (val) {
        setState(() {
          glowing = true;
          scale = 1.1;
        });
      },
      
      child: Container( 
        ///Button ka size
      
        width: 190,
        height: 50,
        child: AnimatedContainer(
            alignment: Alignment.center,
          transform: Matrix4.identity()..scale(scale),
          duration: Duration(milliseconds: 20),
          height: 48,
          width: 160,
          
          decoration: BoxDecoration(
            
              borderRadius: BorderRadius.circular(40),
              
              gradient: LinearGradient(
                colors: [
                  widget.color1,
                  widget.color2,
                ],
              ),
              boxShadow: glowing
                  ? [
                      BoxShadow(
                        color: widget.color1.withOpacity(0.6),
                        spreadRadius: 1,
                        blurRadius: 16,
                        offset: Offset(-8, 0),
                      ),
                      BoxShadow(
                        color: widget.color2.withOpacity(0.6),
                        spreadRadius: 1,
                        blurRadius: 16,
                        offset: Offset(8, 0),
                      ),
                      BoxShadow(
                        color: widget.color1.withOpacity(0.2),
                        spreadRadius: 16,
                        blurRadius: 32,
                        offset: Offset(-8, 0),
                      ),
                      BoxShadow(
                        color: widget.color2.withOpacity(0.2),
                        spreadRadius: 16,
                        blurRadius: 32,
                        offset: Offset(8, 0),
                      )
                    ]
                  : []),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
           //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              // Icon(
                
              //  // glowing ? Icons.play_arrow : Icons.lightbulb_outline,
              //   color: Colors.white,
              
              //   size: 30,
              // ),
              icon,
              Text(
                text,
                style: TextStyle(
                    color: Colors.white,
                   // height: 10,
                    fontSize: 50,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
      ),
    );
    
  }
}

Widget _buildPopupDialog(BuildContext context) {

        // ignore: unnecessary_statements
        Colors.black;
        
      
  return new AlertDialog(
    //  content: Container(
    //     padding: const EdgeInsets.only(left: 70,right: 70,top: 20,bottom: 30),
    //     decoration: new BoxDecoration(
    //         gradient: new LinearGradient(
    //             colors: Colors.accents,
    //             begin: Alignment.topCenter,
    //             end: Alignment.bottomCenter)
    //             ),
    //  ),
  
    
    //  child: Container(
    //        decoration:BoxDecoration(
    //         image: DecorationImage(
    //            image: AssetImage('assets/images/kaam.jpg'),
    //           fit:BoxFit.cover
    title: Center(child: Text('Level 1')),
    content: new Column(
      
       
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        
      Padding(
        padding: const EdgeInsets.all(1.0),
        child: Center(child: Text("Smash 10 Green Candies",)),
      ),
      ],
    ),
    actions: <Widget>[
     GestureDetector(
             onTap: (){
          Navigator.of(context).pop();
         
          // Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
        },

       // textColor: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(80, 30, 80, 20),
          child: GlowingButton(
          
            
          
            icon: Icon(Icons.play_arrow,color: Colors.green[500],size: 0,),

              text: 'PLAY.',

                   
                  color1: Colors.purple[200],
                  color2: Colors.deepOrangeAccent,
                ),
        ),
        
      ),
      
          GestureDetector(
             onTap: (){
       
            
        },

       // textColor: Theme.of(context).primaryColor,
         child: Padding(
         padding: const EdgeInsets.fromLTRB(80, 30, 80, 20),
        child: GlowingButton(
          
          icon: Icon(Icons.play_arrow,color: Colors.green[500],size: 0,),

              text: "BACK",

                  
                  color1: Colors.red,
                  color2: Colors.deepOrangeAccent,
              ),
         ),   
        
      ),
    ],
  );
}
// ignore: unused_element
// exit button wali class
Widget _buildPopupDialog1(BuildContext context) {
  return new AlertDialog(
    //title: Text('Level 1'),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(child: Text("Do You Really Want To Exit ?",)),
      ],
    ),
    actions: <Widget>[
     GestureDetector(
             onTap: (){
          Navigator.of(context).pop();
            
        },
        
        

       // textColor: Theme.of(context).primaryColor,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(80, 30, 80, 20),
            child: GlowingButton(
              icon: Icon(Icons.play_arrow,color: Colors.green[500],size: 0,),

                  text: "YES",

                      
                      color1: Colors.orangeAccent,
                      color2: Colors.deepPurpleAccent,
                  ),
          ),
        ),
              
        
      ),
          GestureDetector(
             onTap: (){
          Navigator.of(context).pop();
            
        },

       // textColor: Theme.of(context).primaryColor,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(80, 10, 80, 10),
            child: GlowingButton(
              icon: Icon(Icons.play_arrow,color: Colors.green[500],size: 0,),
              
                  text: "NO",

                      
                      color1: Colors.orangeAccent,
                      color2: Colors.deepPurpleAccent,
                  ),
          ),
        ),
              
        
      ),
    ],
  );
}
