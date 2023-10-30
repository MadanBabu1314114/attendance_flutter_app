import 'dart:io';

import 'package:excel/excel.dart';

Future<List<dynamic>> readExcel(String _filePath) async {
  var bytes = File(_filePath).readAsBytesSync();
  var excel = Excel.decodeBytes(bytes);
  var _excelData = [];
  var count = 0;
  for (var table in excel.tables.keys) {
    for (var row in excel.tables[table]!.rows) {
      List<String> rowData = [];
      for (var cell in row) {
        if (cell?.value != null) {
          rowData.add(cell!.value.toString().trim());
        }
      }
      count++;
      if (rowData.length != 0 && count > 1) {
        _excelData.add(rowData);
      }
    }
  }

  _excelData.removeAt(0);
  print(_excelData);
  return _excelData;
}
