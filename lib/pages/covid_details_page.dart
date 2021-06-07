import "package:flutter/material.dart";

class CovidDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Covid Details",
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: Text(
            "Working in progress...",
            style: TextStyle(
              fontSize: 22,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
