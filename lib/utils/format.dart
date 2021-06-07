import "package:intl/intl.dart" show NumberFormat;

String numberFormat(int val) {
  NumberFormat formatter = NumberFormat("##,###", "pt_BR");
  return formatter.format(val);
}
