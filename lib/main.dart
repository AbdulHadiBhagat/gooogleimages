import 'dart:async';

import 'package:flutter/material.dart';
import 'package:map_view/figure_joint_type.dart';
import 'package:map_view/map_view.dart';
import 'package:map_view/polygon.dart';
import 'package:map_view/polyline.dart';

class Loc{
  static Location kiet = new Location( 24.928929, 67.040402);
  static Location mabsApps = new Location(24.871940, 66.988060);
  static Location home = new Location(24.940555, 67.076778);
}



var api_key = "AIzaSyCtESlUZ6LUtlGNTFo_SkRqbB4Vjnmuksw";
void main() {
  MapView.setApiKey(api_key);
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  MapView mapView = new MapView();
  CameraPosition cameraPosition;
  //var compositeSubscription = new CompositeSubscription();
  var staticMapProvider = new StaticMapProvider(api_key);
  Uri staticMapUri;

  //Marker bubble
  List<Marker> _markers = <Marker>[
    new Marker(
      "1",
      "Something fragile!",
      45.52480841512737,
      -122.66201455146073,
      color: Colors.blue,
      draggable: true, //Allows the user to move the marker.
      markerIcon: new MarkerIcon(
        "images/flower_vase.png",
        width: 112.0,
        height: 75.0,
      ),
    ),
  ];

  //Line
  List<Polyline> _lines = <Polyline>[
    new Polyline(
        "11",
        <Location>[
          new Location(45.52309483308097, -122.67339684069155),
          new Location(45.52298442915803, -122.66339991241693),
        ],
        width: 15.0,
        color: Colors.blue),
  ];

  //Drawing
  List<Polygon> _polygons = <Polygon>[
    new Polygon(
        "111",
        <Location>[
          new Location(45.5231233, -122.6733130),
          new Location(45.5231195, -122.6706147),
          new Location(45.5231120, -122.6677823),
          
        ],
        jointType: FigureJointType.bevel,
        strokeWidth: 5.0,
        strokeColor: Colors.red,
        fillColor: Color.fromARGB(75, 255, 0, 0)),
  ];

  @override
  initState() {
    super.initState();
    cameraPosition = new CameraPosition(Locations.portland, 2.0);
    staticMapUri = staticMapProvider.getStaticUri(Locations.portland, 12,
        width: 900, height: 400, mapType: StaticMapViewType.roadmap);
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
          appBar: new AppBar(
            title: new Text('Map View Example'),
          ),
          body: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Container(
                height: 250.0,
                child: new Stack(
                  children: <Widget>[
                    new Center(
                        child: new Container(
                      child: new Text(
                        "You are supposed to see a map here.\n\nAPI Key is not valid.\n\n"
                            "To view maps in the example application set the "
                            "API_KEY variable in example/lib/main.dart. "
                            "\n\nIf you have set an API Key but you still see this text "
                            "make sure you have enabled all of the correct APIs "
                            "in the Google API Console. See README for more detail.",
                        textAlign: TextAlign.center,
                      ),
                      padding: const EdgeInsets.all(20.0),
                    )),
                    new InkWell(
                      child: new Center(
                        child: new Image.network(staticMapUri.toString()),
                      ),
                      onTap: (){},
                    )
                  ],
                ),
              ),
              new Container(
                padding: new EdgeInsets.only(top: 10.0),
                child: new Text(
                  "Tap the map to interact",
                  style: new TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              new Container(
                padding: new EdgeInsets.only(top: 25.0),
                child:
                    new Text("Camera Position: \n\nLat: ${cameraPosition.center
                    .latitude}\n\nLng:${cameraPosition.center
                    .longitude}\n\nZoom: ${cameraPosition.zoom}"),
              ),
            ],
          )),
    );
  }

}