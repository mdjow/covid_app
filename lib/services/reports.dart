import "dart:convert" show jsonDecode;
import "package:http/http.dart" show Response, get;

import "../models/report.dart" show Cases, History;

final String apiUrl = "https://covid-api.mmediagroup.fr/v1/";

Future<List<String>> getCountries() async {
  final Uri url = Uri.parse("$apiUrl/cases");
  List<String> countries = [];

  try {
    Response response = await get(url);
    Map data = jsonDecode(response.body);
    countries = data.keys?.toList() ?? [];
  } catch (e) {
    print("Exception caught at getCountries() $e");
  }

  return countries;
}

Future<Cases> getCases({String country}) async {
  final Uri url = Uri.parse("$apiUrl/cases?country=$country");
  Cases cases = Cases.fromJson({});

  try {
    Response response = await get(url);
    Map data = jsonDecode(response.body);
    cases = Cases.fromJson(data["All"] ?? {});
  } catch (e) {
    print("Exception caught at getCases() $e");
  }

  return cases;
}

Future<History> getHistory({String country, String status}) async {
  final Uri url = Uri.parse("$apiUrl/history?country=$country&status=$status");
  History history = History.fromJson({});

  try {
    Response response = await get(url);
    Map data = jsonDecode(response.body);
    history = History.fromJson(data["All"] ?? {});
  } catch (e) {
    print("Exception caught at getHistory() $e");
  }

  return history;
}
