import "package:intl/intl.dart";

String numberFormat(int val) {
  NumberFormat formatter = new NumberFormat("##,###", "pt_BR");
  return formatter.format(val);
}
