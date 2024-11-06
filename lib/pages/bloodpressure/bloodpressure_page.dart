import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example/models/response/response_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_example/models/bloodpressure/bloodpressure_model.dart';

class BloodPressurePage extends StatefulWidget {
  const BloodPressurePage({super.key});

  @override
  State<BloodPressurePage> createState() => _BloodPressurePageState();
}

class _BloodPressurePageState extends State<BloodPressurePage> {
  late List<BloodPressureModel> bpmdata;

  @override
  void initState() {
    super.initState();
    bpmdata = <BloodPressureModel>[];
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter SfDataGrid'),
      ),
      body: Center(
          widthFactor: MediaQuery.of(context).size.width,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DataTable(
                    columnSpacing: 0,
                    columns: <DataColumn>[
                      DataColumn(
                          label: SizedBox(
                        width: MediaQuery.of(context).size.width / 6,
                        child: const Text('Date Time'),
                      )),
                      DataColumn(
                          label: SizedBox(
                        width: MediaQuery.of(context).size.width / 6,
                        child: const Text('Systolic(mmHg)'),
                      )),
                      DataColumn(
                          label: SizedBox(
                        width: MediaQuery.of(context).size.width / 6,
                        child: const Text('Diastolic(mmHg)'),
                      )),
                      DataColumn(
                          label: SizedBox(
                        width: MediaQuery.of(context).size.width / 6,
                        child: const Text('Pulse (bpm)'),
                      )),
                      DataColumn(
                          label: SizedBox(
                        width: MediaQuery.of(context).size.width / 6,
                        child: const Text('Mode'),
                      )),
                      DataColumn(
                          label: SizedBox(
                        width: MediaQuery.of(context).size.width / 6,
                        child: const Text('Irregular Pulse'),
                      )),
                    ],
                    rows: List<DataRow>.generate(
                        bpmdata.length,
                        (index) => DataRow(
                                color:
                                    MaterialStateProperty.resolveWith<Color?>(
                                        (Set<MaterialState> states) {
                                  if (index.isEven) {
                                    return Colors.grey.withOpacity(0.3);
                                  }
                                  return null;
                                }),
                                cells: <DataCell>[
                                  DataCell(SizedBox(
                                      width:
                                          (MediaQuery.of(context).size.width /
                                              6),
                                      child: Text(bpmdata[index]
                                          .updatedate
                                          .toString()))),
                                  DataCell(SizedBox(
                                      width:
                                          (MediaQuery.of(context).size.width /
                                              6),
                                      child:
                                          Text(bpmdata[index].sys.toString()))),
                                  DataCell(SizedBox(
                                      width:
                                          (MediaQuery.of(context).size.width /
                                              6),
                                      child:
                                          Text(bpmdata[index].dia.toString()))),
                                  DataCell(SizedBox(
                                      width:
                                          (MediaQuery.of(context).size.width /
                                              6),
                                      child:
                                          Text(bpmdata[index].pul.toString()))),
                                  DataCell(SizedBox(
                                      width:
                                          (MediaQuery.of(context).size.width /
                                              6),
                                      child: Text(bpmdata[index].mode == 0
                                          ? "-"
                                          : (bpmdata[index].mode == 1
                                              ? "AFIB"
                                              : (bpmdata[index].mode == 2
                                                  ? "MAM"
                                                  : "MAM(AFIB)"))))),
                                  DataCell(SizedBox(
                                      width:
                                          (MediaQuery.of(context).size.width /
                                              6),
                                      child: Text(
                                          bpmdata[index].afib.toString()))),
                                ]))),
                ElevatedButton(
                  key: const Key('loadButton'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () => _load(),
                  child: const Text('load'),
                )
              ])),
    );
  }

  void getData() async {
    var response = await http.get(Uri.https(
        'flutterexample.azurewebsites.net', '/api/BloodPressure/Get'));
    if (response.statusCode == 200) {
      ResponseModel responsedata =
          ResponseModel.fromJson(jsonDecode(response.body));
      setState(() {
        List<BloodPressureModel> savedata = responsedata.bpmData ?? [];
        _save(savedata);
      });
    }
  }

  void _save(List<BloodPressureModel> data) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> jsonlist = [];
    for (BloodPressureModel item in data) {
      jsonlist.add((jsonEncode(item)));
    }
    prefs.setStringList('bloodpressure', jsonlist);
  }

  void _load() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> jsonlist = prefs.getStringList('bloodpressure') ?? [];
    if (jsonlist.isNotEmpty) bpmdata.clear();
    List<BloodPressureModel> temp = [];
    for (String item in jsonlist) {
      temp.add((BloodPressureModel.fromJson(jsonDecode(item))));
    }
    setState(() {
      bpmdata = temp;
    });
  }
}
