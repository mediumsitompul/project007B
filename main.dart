import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:convert/convert.dart';
import 'package:charts_flutter_new/flutter.dart' as charts;
import 'package:project007b/data_model.dart';
import 'data_model.dart';
import 'dart:async';
import 'dart:convert';


        void main() {
          runApp(const MyApp());
        }

        class MyApp extends StatelessWidget {
          const MyApp({Key? key}) : super(key: key);

          @override
          Widget build(BuildContext context) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                appBar: AppBar(
                  title: const Center(child: Text("Data in Chart"),
                  ),

                ),
                body: MyProject(),
              ),
            );
          }
        }





class MyProject extends StatefulWidget {
  MyProject({Key? key}) : super(key: key);

  @override
  State<MyProject> createState() => _MyProjectState();
}

class _MyProjectState extends State<MyProject> {
  List<DataModel> dataList=[];
  Timer? _timer;



  void _getData() async{
    var response = await http.get(
      Uri.parse("http://192.168.100.100:8087/radio/data_chart.php?auth=kjgdkhdfldfguttedfgr")
    );

    List data = jsonDecode(response.body);
    print(data);


    setState(() {
      dataList = dataModelFromJson1(data);
    });

  }

@override
  void initState() {
    // TODO: implement initState
    _timer = Timer.periodic(Duration(seconds: 5), (timer) => _getData());
    super.initState();
  }

List<charts.Series<DataModel, String>> _createDataChart(){
  return[
    charts.Series<DataModel, String>(
      data: dataList,
      id: 'name',
      domainFn: (DataModel dataModel, _) => dataModel.name1,
      measureFn: (DataModel dataModel, _) => dataModel.count1,
      labelAccessorFn: (DataModel dataModel, _) => '# ${dataModel.count1.toString()}',
      colorFn: (DataModel dataModel, _) => charts.ColorUtil.fromDartColor(Colors.red),
      )

  ];
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: 400,
            padding: EdgeInsets.all(15),
            child: Card(
              child: Column(
                children: [
                  Text('Which Operating System are your currently using?'),
                  Expanded(child: charts.BarChart(
                    barRendererDecorator: charts.BarLabelDecorator<String>(),
                    domainAxis: charts.OrdinalAxisSpec(),
                    vertical: false,
                    _createDataChart(),
                    animate: false,)
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
