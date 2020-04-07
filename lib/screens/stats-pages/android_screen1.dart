import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import '../../services/NetworkHelper.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

final GlobalKey<AnimatedCircularChartState> _chartKey = new GlobalKey<AnimatedCircularChartState>();

class AndroidFirstPage extends StatefulWidget {
  const AndroidFirstPage({Key key}) : super(key: key);

  @override
  _AndroidFirstPageState createState() => _AndroidFirstPageState();
}

class _AndroidFirstPageState extends State<AndroidFirstPage> {

  int totalCases = 0;
  int deaths = 0;
  int recovered = 0;
  int confirmed = 0;
  bool valueReceived = false;

  void getData() async {
    NetworkHelper covidData = NetworkHelper('https://pomber.github.io/covid19/timeseries.json');
    var globalData = await covidData.getData();
    print(globalData["India"].reversed.toList()[0]);

    setState(() {
    recovered = globalData["India"].reversed.toList()[0]["recovered"];
    deaths = globalData["India"].reversed.toList()[0]["deaths"];
    confirmed = globalData["India"].reversed.toList()[0]["confirmed"];
    totalCases = recovered + deaths + confirmed;
    valueReceived = true;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }


  @override
  Widget build(BuildContext context) {

    List<CircularStackEntry> data = <CircularStackEntry>[
      new CircularStackEntry(
        <CircularSegmentEntry>[
          new CircularSegmentEntry(deaths.toDouble(), Colors.red, rankKey: 'Q1'),
          new CircularSegmentEntry(recovered.toDouble(), Colors.green, rankKey: 'Q2'),
          new CircularSegmentEntry(confirmed.toDouble(), Colors.blue, rankKey: 'Q3'),
        ],
        rankKey: 'Quarterly Profits',
      ),
    ];

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 20.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'Todays Report',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 30.0,
                  fontWeight: FontWeight.w700
                ),
              ),
            ),
          ),
          Center(
            child: valueReceived ? AnimatedCircularChart(
              key: _chartKey,
              size: const Size(400.0, 400.0),
              initialChartData: data,
              chartType: CircularChartType.Radial,
            ) :
            SpinKitRotatingCircle(
              color: Colors.white,
              size: 50.0,
            )
          ),
          Row(
            children: <Widget>[
              Card(text: 'Recovered',value: '${recovered.toString()}',colour: Colors.green,),
              Card(text: 'Deaths',value: '${deaths.toString()}',colour: Colors.red,)
            ],
          ),
          Row(
            children: <Widget>[
              Card(text: 'Confirmed',value: '${confirmed.toString()}',colour: Colors.blue,),
              Card(text: 'Total cases',value: '${totalCases.toString()}',colour: Colors.grey,)
            ],
          )
        ],
      ),
    );
  }
}

class Card extends StatelessWidget {

  Card({@required this.text, @required this.value, this.colour});

  final String text;
  final String value;
  final Color colour;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: colour
        ),
        width: MediaQuery.of(context).size.width * 0.45,
        height: 100.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              text,
              style: TextStyle(
                fontSize: 17.0,
                color: Colors.white
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 17.0,
                color: Colors.white
              )
            ),
          ],
        ),
      ),
    );
  }
}
