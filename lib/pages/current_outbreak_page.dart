import "package:flutter/material.dart";
import "package:intl/intl.dart" show DateFormat;

import "../models/report.dart" show Cases, History;
import "../services/reports.dart" show getCases, getCountries, getHistory;
import "../widgets/line_history_chart.dart" show LineHistoryChart;
import "../widgets/report_card.dart" show ReportCard;

enum TabsEnum { Daily, Weekly, Monthly }

class CurrentOutbreakPage extends StatefulWidget {
  CurrentOutbreakPage({Key key}) : super(key: key);

  @override
  _CurrentOutbreakPageState createState() => _CurrentOutbreakPageState();
}

class _CurrentOutbreakPageState extends State<CurrentOutbreakPage> {
  String selectedCoutry = "Brazil";
  String formattedDate = "";
  bool isBusy = false;
  TabsEnum tabSelected = TabsEnum.Daily;

  final now = DateTime.now();
  Cases cases = Cases.fromJson({});
  History history = History.fromJson({});

  List<String> countries = [];
  List<double> chart = [];
  final List<Tab> tabs = [
    Tab(text: "Daily"),
    Tab(text: "Weekly"),
    Tab(text: "Monthly"),
  ];

  String get chartLabel {
    switch (tabSelected) {
      case TabsEnum.Daily:
        return "Last seven days";
      case TabsEnum.Weekly:
        return "Last four weeks";
      case TabsEnum.Monthly:
        return "Last twelve months";
      default:
        return "";
    }
  }

  String get todayDateFormated {
    DateFormat formatter = DateFormat("EEE, d MMM y");
    formattedDate = formatter.format(now);
    return formattedDate;
  }

  @override
  void initState() {
    super.initState();
    initialise();
  }

  void initialise() {
    getCountries().then((response) => setState(() => countries = response));

    if (selectedCoutry.isNotEmpty) {
      handleGetReport(selectedCoutry);
    }
  }

  String formatDateTime(String value) {
    if (value?.isEmpty ?? true) {
      return "(not reported)";
    }

    final date = DateFormat("yyyy/d/M HH:mm").parse(value);
    DateFormat formatter = DateFormat("EEE, d MMM y HH:mm");
    return formatter.format(date);
  }

  List<String> getDatesForChart({DateTime date, int subtract, int count}) {
    var resp = <String>[];
    var current = date;

    for (var i = 0; i < count; i++) {
      current = current.subtract(Duration(days: subtract));

      DateFormat formatter = DateFormat("yyyy-MM-dd");
      formattedDate = formatter.format(current);

      resp.add(formattedDate);
    }

    return resp;
  }

  void handleSelectTab(int index) {
    tabSelected = TabsEnum.values[index];
    var doubleValues = (history?.dates?.values?.map((e) => e.toDouble()) ?? []).toList();
    switch (tabSelected) {
      case TabsEnum.Daily:
        var chatValues = doubleValues.getRange(0, 9).toList().reversed.toList();
        setState(() {
          chart = chatValues;
        });
        break;
      case TabsEnum.Weekly:
        final lastDate = history?.dates?.keys?.first;
        final date = DateTime.parse(lastDate);
        final keys = getDatesForChart(date: date, subtract: 7, count: 5);

        var chatValues = [
          history?.dates[lastDate]?.toDouble() ?? 0,
        ];

        for (final key in keys) {
          chatValues.add(history?.dates[key]?.toDouble() ?? 0);
        }

        setState(() {
          chart = chatValues.reversed.toList();
        });
        break;
      case TabsEnum.Monthly:
        final lastDate = history?.dates?.keys?.first;
        final date = DateTime.parse(lastDate);
        final keys = getDatesForChart(date: date, subtract: 30, count: 13);

        var chatValues = [
          history?.dates[lastDate]?.toDouble() ?? 0,
        ];

        for (final key in keys) {
          chatValues.add(history?.dates[key]?.toDouble() ?? 0);
        }

        setState(() {
          chart = chatValues.reversed.toList();
        });
        break;
    }
  }

  Future<void> handleGetReport(String coutry) async {
    setState(() {
      selectedCoutry = coutry;
      isBusy = true;
    });

    getCases(country: coutry).then((response) {
      setState(() {
        cases = response;
      });
    });

    getHistory(country: coutry, status: "confirmed").then((response) {
      setState(() {
        history = response;
        isBusy = false;
      });

      handleSelectTab(tabSelected.index);
    });
  }

  void goTo(String path) {
    Navigator.pushNamed(
      context,
      path,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Current outbreak",
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            tooltip: "notices",
            color: Colors.grey,
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonHideUnderline(
                  child: DropdownButton(
                    isExpanded: true,
                    value: selectedCoutry,
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 32,
                    iconEnabledColor: Colors.grey,
                    elevation: 16,
                    onChanged: handleGetReport,
                    items: countries
                        .map<DropdownMenuItem<String>>((String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 32,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
                Text(
                  todayDateFormated,
                  style: TextStyle(
                    color: Colors.grey[400],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 26),
                  constraints: BoxConstraints.loose(Size.fromHeight(120.0)),
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.topCenter,
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        right: -16.0,
                        child: Container(
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(4),
                              topLeft: Radius.circular(4),
                            ),
                            color: Theme.of(context).primaryColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.0, 1.0),
                                blurRadius: 6.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                isBusy
                    ? Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 100),
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Covid 19 Latest Update",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Last updated ${formatDateTime(cases?.updated)}",
                                style: TextStyle(
                                  color: Colors.grey[400],
                                ),
                              ),
                              TextButton(
                                onPressed: () => goTo("/covid_details_page"),
                                child: const Text("Details"),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ReportCard(
                                label: "Confirmed",
                                value: cases?.confirmed ?? 0,
                                color: Colors.amberAccent,
                                icon: Icons.add,
                              ),
                              ReportCard(
                                label: "Recovered",
                                value: cases?.recovered ?? 0,
                                color: Colors.greenAccent,
                                icon: Icons.favorite,
                              ),
                              ReportCard(
                                label: "Deaths",
                                value: cases?.deaths ?? 0,
                                color: Colors.redAccent,
                                icon: Icons.close,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 16),
                                child: Text(
                                  "Active Cases",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 8),
                            child: DefaultTabController(
                              length: tabs.length,
                              initialIndex: 0,
                              child: TabBar(
                                onTap: handleSelectTab,
                                tabs: tabs,
                              ),
                            ),
                          ),
                          LineHistoryChart(
                            points: chart,
                            chartLabel: chartLabel,
                            infoLabel: "Actives",
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
