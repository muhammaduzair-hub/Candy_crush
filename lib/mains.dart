import 'package:flutter/material.dart';
import 'package:flutter_application2/glowing_button.dart';



class HomePagee extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var white = Colors.white;
        
        return Material(
          child: Container(
           decoration:BoxDecoration(
            image: DecorationImage(
               image: AssetImage('assets/images/background/kaam.jpg'),
              fit:BoxFit.cover
              
             ),
           ) ,
            
        
           // color: Colors.black54,
              //alignment: Alignment.center,
            child: Column(
             // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              
              children: [
                
                Text('my app'),
              BackButtonIcon(),
                //Can change to any color you want.
              
                SizedBox(height: 350,),
                
                GestureDetector(
                  
              
                                  child: GlowingButton(
                    icon: Icon(Icons.play_arrow,color: white,size: 0,),
                    
              text: "PLAY", 
                  color1: Colors.orange,
                  color2: Colors.red,
              ),
                ),
           /* GlowingButton(
              color1: Colors.pinkAccent,
              color2: Colors.indigoAccent,
            ),*/
            SizedBox(height: 20,),
            // actions: <Widget>[
     GestureDetector(
             onTap: (){
          Navigator.of(context).pop();
            
        },
        

       // textColor: Theme.of(context).primaryColor,
        child: GlowingButton(
          icon: Icon(Icons.play_arrow,color: Colors.green[500],size: 0,),

              text: "EXIT",

                  
                  color1: Colors.deepPurple,
                  color2: Colors.lightBlueAccent,
              ),
              
        
      ),
          ],
        ),
      ),
    );
  }
}


