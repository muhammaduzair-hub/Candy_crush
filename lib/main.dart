
import 'package:flutter_application2/application.dart';
import 'package:flutter_application2/helpers/audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  //
  // Initialize the audio
  //
  WidgetsFlutterBinding.ensureInitialized();
   await Audio.init();
  
  //
  // Remove the status bar
  //
  SystemChrome.setEnabledSystemUIOverlays([]);

  return runApp(
    Application(),
  );
}