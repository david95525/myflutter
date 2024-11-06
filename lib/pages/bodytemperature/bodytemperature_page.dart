import 'dart:convert';
import 'package:flutter_example/models/bodytemperature/bodytemperature_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class BodyTemperaturePage extends StatefulWidget {
  const BodyTemperaturePage({super.key});

  @override
  State<BodyTemperaturePage> createState() => _BodyTemperaturePageState();
}

class _BodyTemperaturePageState extends State<BodyTemperaturePage> {
  List<BodyTemperatureModel> btdata = <BodyTemperatureModel>[];
  @override
  void initState() {
    super.initState();
    _initDataSave();
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
                        width: MediaQuery.of(context).size.width / 3,
                        child: const Text('Date Time'),
                      )),
                      DataColumn(
                          label: SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: const Text('Temperature(°C)'),
                      )),
                    ],
                    rows: List<DataRow>.generate(
                        btdata.length,
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
                                              3),
                                      child: Text(btdata[index]
                                          .updateDate
                                          .toString()))),
                                  DataCell(SizedBox(
                                      width:
                                          (MediaQuery.of(context).size.width /
                                              3),
                                      child: Text(
                                          btdata[index].bodytemp.toString()))),
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

  void _initDataSave() async {
    List<BodyTemperatureModel> savedata = [
      const BodyTemperatureModel(
          btId: 1, updateDate: "2024-02-04 14:00", bodytemp: 37.2, note: ""),
      const BodyTemperatureModel(
          btId: 2, updateDate: "2024-02-05 14:00", bodytemp: 36.2, note: ""),
      const BodyTemperatureModel(
          btId: 2, updateDate: "2024-02-06 15:00", bodytemp: 36.7, note: "")
    ];
    final prefs = await SharedPreferences.getInstance();
    List<String> jsonlist = [];
    for (BodyTemperatureModel item in savedata) {
      jsonlist.add((jsonEncode(item)));
    }
    prefs.setStringList('bodytemperature', jsonlist);
  }

  void _load() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> jsonlist = prefs.getStringList('bodytemperature') ?? [];
    if (jsonlist.isNotEmpty) btdata.clear();
    List<BodyTemperatureModel> temp = [];
    for (String item in jsonlist) {
      temp.add((BodyTemperatureModel.fromJson(jsonDecode(item))));
    }
    setState(() {
      btdata = temp;
    });
  }
}
