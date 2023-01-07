import 'dart:typed_data';

import 'package:animated_floating_buttons/widgets/animated_floating_action_button.dart';
import 'package:drawing/Model/Painter.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

import '../Model/model.dart';

class DrawingScreen extends StatefulWidget {
  const DrawingScreen({Key? key}) : super(key: key);

  @override
  State<DrawingScreen> createState() => _DrawingScreenState();
}

class _DrawingScreenState extends State<DrawingScreen> {
  final GlobalKey<AnimatedFloatingActionButtonState> key =
      GlobalKey<AnimatedFloatingActionButtonState>();
  List<DrawingModel?> Points = [];
  var current = 0;
  double WidthFont = 3.0;
  Color myColor = Colors.black;
  final controller = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    return Screenshot(
        controller: controller,
        child: Scaffold(
            bottomNavigationBar: Container(
              height: 40,
              child: Slider(
                activeColor: Colors.deepOrange,
                inactiveColor: Colors.white,
                value: WidthFont,
                onChanged: (x) {
                  setState(() {
                    WidthFont = x;
                  });
                },
                max: 50.0,
                min: 0.5,
              ),
            ),
            floatingActionButton: AnimatedFloatingActionButton(
                //Fab list
                fabButtons: <Widget>[
                  Container(
                    child: FloatingActionButton(
                        child: myColor == Colors.black
                            ? Icon(Icons.close)
                            : Container(),
                        backgroundColor: Colors.black,
                        onPressed: () {
                          setState(() {
                            myColor = Colors.black;
                          });
                        }),
                  ),
                  Container(
                    child: FloatingActionButton(
                        child: myColor == Colors.red
                            ? Icon(Icons.close)
                            : Container(),
                        backgroundColor: Colors.red,
                        onPressed: () {
                          setState(() {
                            myColor = Colors.red;
                          });
                        }),
                  ),
                  Container(
                    child: FloatingActionButton(
                        child: myColor == Colors.green
                            ? Icon(Icons.close)
                            : Container(),
                        backgroundColor: Colors.green,
                        onPressed: () {
                          setState(() {
                            myColor = Colors.green;
                          });
                        }),
                  ),
                  Container(
                    child: FloatingActionButton(
                        child: myColor == Colors.blue
                            ? Icon(Icons.close)
                            : Container(),
                        backgroundColor: Colors.blue,
                        onPressed: () {
                          setState(() {
                            myColor = Colors.blue;
                          });
                        }),
                  ),
                  Container(
                    child: FloatingActionButton(
                        child: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        backgroundColor: Color.fromARGB(255, 255, 255, 255),
                        onPressed: () {
                          setState(() {
                            Points = [];
                          });
                        }),
                  ),
                  // ignore: avoid_unnecessary_containers
                  Container(
                    child: FloatingActionButton(
                        child: Icon(Icons.save_alt),
                        backgroundColor: Colors.deepOrangeAccent,
                        onPressed: () async {
                          // final image = await controller.capture();
                          final image2 =
                              await controller.captureFromWidget(myWidget());

                          if (image2 == null) return;
                          //     await saveImage(image);
                          await saveImage(image2);
                        }),
                  ),
                ],
                key: key,
                colorStartAnimation: Colors.deepOrange,
                colorEndAnimation: Colors.red,
                animatedIconData: AnimatedIcons.menu_close //To principal button
                ),
            body: SafeArea(child: myWidget())));
  }

  void onStart(DragStartDetails details) {
    print('User Start Drawing');
    //store ponts of screen Points
    setState(() {
      addPonts(details.globalPosition);
    });
  }

  void onUpdate(DragUpdateDetails details) {
    print(details.globalPosition);
    setState(() {
      addPonts(details.globalPosition);
    });
  }

  void onEnd(DragEndDetails details) {
    setState(() {
      Points.add(null);
    });
    print('User End Drawing');
  }

  void addPonts(Offset details) {
    Points.add(DrawingModel(
        ponts: details,
        paint: Paint()
          ..color = myColor
          ..strokeWidth = WidthFont
          ..strokeCap = StrokeCap.butt));
  }

  Widget myWidget() {
    return Container(
      color: Colors.white,
      child: GestureDetector(
        onPanStart: onStart,
        onPanUpdate: onUpdate,
        onPanEnd: onEnd,
        child: CustomPaint(
          size: Size.infinite,
          painter: MyPainter(
            Points: Points,
          ),
        ),
      ),
    );
  }

  Future<String> saveImage(Uint8List bytes) async {
    await [Permission.storage].request();
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '_')
        .replaceAll(':', '_');
    final name = 'screenshot_$time';
    final result = await ImageGallerySaver.saveImage(bytes, name: name);
    return result['filePath'];
  }
}
