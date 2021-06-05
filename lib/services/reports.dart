import "dart:convert";

import "package:covid_app/models/report.dart";
import "package:http/http.dart";

final String apiUrl = "https://covid-api.mmediagroup.fr/v1/";

Future<List<String>> getCountries() async {
  final Uri url = Uri.parse("$apiUrl/cases");
  List<String> countries;

  try {
    Response response = await get(url);
    Map data = jsonDecode(response.body);
    countries = data.keys?.toList() ?? [];
  } catch (e) {
    print("Exception caught at getCountries() $e");
  }

  return countries;
}

Future<Report> getReport({String country}) async {
  final Uri url = Uri.parse("$apiUrl/cases?country=$country");
  Report report;

  try {
    Response response = await get(url);
    Map data = jsonDecode(response.body);
    report = new Report.fromJson(data["All"] ?? {});
  } catch (e) {
    print("Exception caught at getReport() $e");
  }

  return report;
}

Future<History> getHistory({String country, String status}) async {
  final Uri url = Uri.parse("$apiUrl/history?country=$country&status=$status");
  History history;

  try {
    Response response = await get(url);
    Map data = jsonDecode(response.body);
    history = new History.fromJson(data["All"] ?? {});
  } catch (e) {
    print("Exception caught at getHistory() $e");
  }

  return history;
}
