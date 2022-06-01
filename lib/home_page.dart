import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Duration _duration = new Duration();
  Duration _position = new Duration();
  bool isPlaying = false;
  bool isPaused = false;
  bool isRepeat = false;
  Color color = Colors.black;
  bool isDarked = false;
  bool isLiked = false;

  String path1 =
      "https://commondatastorage.googleapis.com/codeskulptor-demos/pyman_assets/ateapill.ogg";
  String path2 =
      "https://st.bslmeiyu.com/uploads/%e6%9c%97%e6%96%87%e5%9b%bd%e9%99%85SBS%e7%b3%bb%e5%88%97/%e6%9c%97%e6%96%87%e5%9b%bd%e9%99%85%e8%8b%b1%e8%af%ad%e6%95%99%e7%a8%8b%e7%ac%ac1%e5%86%8c_V2/%e5%ad%a6%e7%94%9f%e7%94%a8%e4%b9%a6/P149_Chapter%2016_Vocabulary%20Preview.mp3";

  List<IconData> _icons = [
    Icons.play_circle_fill,
    Icons.pause_circle_filled,
  ];
  AudioPlayer advancedPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    this.advancedPlayer.onDurationChanged.listen((d) {
      setState(() {
        _duration = d;
      });
    });
    this.advancedPlayer.onAudioPositionChanged.listen((p) {
      setState(() {
        _position = p;
      });
    });

    this.advancedPlayer.setUrl(path1);
    this.advancedPlayer.onPlayerCompletion.listen((event) {
      setState(() {
        _position = Duration(seconds: 0);
        if (isRepeat == true) {
          isPlaying = true;
        } else {
          isPlaying = false;
          isRepeat = false;
        }
      });
    });
  }

//design
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: NeumorphicTheme.baseColor(context),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(20),
            // color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // mainAxisSize: MainAxisSize.min,
              children: [
                // option buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //favoirite buton
                    NeumorphicButton(
                      padding: EdgeInsets.all(12),
                      onPressed: (() {
                        setState(() {
                          isLiked = !isLiked;
                        });
                      }),
                      style: NeumorphicStyle(
                        shape: NeumorphicShape.concave,
                      ),
                      child: Icon(
                        (!isLiked) ? Icons.favorite_border : Icons.favorite,
                        size: 40,
                        color: _iconsColor(context),
                      ),
                    ),
                    //dark button buton
                    NeumorphicButton(
                      padding: EdgeInsets.all(12),
                      onPressed: (() {
                        NeumorphicTheme.of(context)!.themeMode =
                            (!isDarked) ? ThemeMode.dark : ThemeMode.light;
                        isDarked = !isDarked;
                        print(isDarked);
                        setState(() {});
                      }),
                      style: NeumorphicStyle(
                        shape: NeumorphicShape.flat,
                      ),
                      child: Icon(
                        (isDarked)
                            ? Icons.toggle_on_outlined
                            : Icons.toggle_off_outlined,
                        size: 40,
                        color: _iconsColor(context),
                      ),
                    ),
                  ],
                ),
                // SizedBox(height: 20),

                // image
                NeumorphicButton(
                  padding: EdgeInsets.all(12),
                  onPressed: (() {}),
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.concave,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Image.asset("assets/images/pic-3.png"),
                    ),
                  ),
                ),
                // SizedBox(height: 20),
                // slider
                NeumorphicButton(
                  padding: EdgeInsets.all(12),
                  onPressed: (() {}),
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.concave,
                  ),
                  child: Container(
                    // padding: EdgeInsets.all(),
                    child: slider(),
                  ),
                ),
                // SizedBox(height: 20),
                // sound option buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NeumorphicButton(
                      padding: EdgeInsets.all(12),
                      onPressed: (() {}),
                      style: NeumorphicStyle(
                        shape: NeumorphicShape.concave,
                      ),
                      child: Container(
                        // padding: EdgeInsets.all(),
                        child: btnSlow(),
                      ),
                    ),
                    NeumorphicButton(
                      padding: EdgeInsets.all(12),
                      onPressed: (() {}),
                      style: NeumorphicStyle(
                        shape: NeumorphicShape.concave,
                      ),
                      child: Container(
                        // padding: EdgeInsets.all(),
                        child: btnStart(),
                      ),
                    ),
                    NeumorphicButton(
                      padding: EdgeInsets.all(12),
                      onPressed: (() {}),
                      style: NeumorphicStyle(
                        shape: NeumorphicShape.concave,
                      ),
                      child: Container(
                        // padding: EdgeInsets.all(),
                        child: btnFast(),
                      ),
                    ),
                  ],
                ),
                // SizedBox(height: 20),
                //load asset
                NeumorphicButton(
                  padding: EdgeInsets.all(12),
                  onPressed: (() {}),
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.concave,
                  ),
                  child: Container(
                    // padding: EdgeInsets.all(),
                    child: loadAsset(),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  // Buttons
  Widget btnStart() {
    return IconButton(
      padding: const EdgeInsets.only(bottom: 10),
      icon: isPlaying == false
          ? Icon(_icons[0], size: 50, color: Colors.blue)
          : Icon(_icons[1], size: 50, color: Colors.blue),
      onPressed: () {
        if (isPlaying == false) {
          this.advancedPlayer.play(path1);
          setState(() {
            isPlaying = true;
          });
        } else if (isPlaying == true) {
          this.advancedPlayer.pause();
          setState(() {
            isPlaying = false;
          });
        }
      },
    );
  }

  Widget btnFast() {
    return IconButton(
      icon: ImageIcon(
        AssetImage('assets/images/forward.png'),
        size: 15,
        color: Colors.black,
      ),
      onPressed: () {
        this.advancedPlayer.setPlaybackRate(1.5);
      },
    );
  }

  Widget btnSlow() {
    return IconButton(
      icon: ImageIcon(
        AssetImage('assets/images/backword.png'),
        size: 15,
        color: Colors.black,
      ),
      onPressed: () {
        this.advancedPlayer.setPlaybackRate(0.5);
      },
    );
  }

  Widget btnStop() {
    return IconButton(
      icon: ImageIcon(
        AssetImage('assets/images/stop.png'),
        size: 15,
        color: Colors.black,
      ),
      onPressed: () {
        advancedPlayer.stop();
        _position.inSeconds != 0;
        _position = Duration(seconds: 0);

        advancedPlayer.setUrl(path1);
        isPlaying = false;
        setState(() {});
      },
    );
  }

  Widget btnRepeat() {
    return IconButton(
      icon: ImageIcon(
        AssetImage('assets/images/repeat.png'),
        size: 15,
        color: color,
      ),
      onPressed: () {
        if (isRepeat == false) {
          this.advancedPlayer.setReleaseMode(ReleaseMode.LOOP);
          setState(() {
            isRepeat = true;
            color = Colors.blue;
          });
        } else if (isRepeat == true) {
          this.advancedPlayer.setReleaseMode(ReleaseMode.RELEASE);
          color = Colors.black;
          isRepeat = false;
        }
      },
    );
  }

  Widget slider() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          getTime(_position),
          style: TextStyle(
            color: (isDarked) ? Colors.blue : Colors.black,
          ),
        ),
        Container(
          padding: EdgeInsets.all(0),
          width: MediaQuery.of(context).size.width * .59,
          child: Slider(
              activeColor: _iconsColor(context),
              inactiveColor: Colors.grey,
              value: _position.inSeconds.toDouble(),
              min: 0.0,
              max: _duration.inSeconds.toDouble(),
              onChanged: (double value) {
                setState(() {
                  changeToSecond(value.toInt());
                  value = value;
                });
              }),
        ),
        Text(
          getTime(_duration),
          style: TextStyle(
            color: (isDarked) ? Colors.blue : Colors.black,
          ),
        ),
      ],
    );
  }

  String getTime(Duration duration) {
    // print("duration is:" + duration.toString());
    String time = "";
    if (duration.inSeconds.toInt() > 3600) {
      time = duration.toString().substring(0, 7);
    } else {
      time = duration.toString().substring(2, 7);
    }
    return time;
  }

  void changeToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    this.advancedPlayer.seek(newDuration);
  }

  Widget loadAsset() {
    return Container(
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
          btnRepeat(),
          btnSlow(),
          btnStart(),
          btnFast(),
          btnStop()
        ]));
  }

  Color? _iconsColor(BuildContext context) {
    final theme = NeumorphicTheme.of(context);
    if (theme!.isUsingDark) {
      return theme.current!.accentColor;
    } else {
      return null;
    }
  }

  Color _textColor(BuildContext context) {
    if (NeumorphicTheme.isUsingDark(context)) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }
}
