import "package:flutter/material.dart";

import "../utils/format.dart" show numberFormat;

class ReportCard extends StatelessWidget {
  final String label;
  final int value;
  final IconData icon;
  final Color color;

  ReportCard({
    @required this.label,
    @required this.value,
    this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Container(
          height: 120,
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 30,
                height: 30,
                child: Icon(
                  icon,
                  color: color,
                  size: 18,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withOpacity(0.1),
                ),
              ),
              Column(
                children: [
                  Text(
                    numberFormat(value).toString() ?? "",
                    style: TextStyle(
                      color: color,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    label,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
