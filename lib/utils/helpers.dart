import 'package:boya_invoices/utils/colors.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

parseDate(String dateString) {
  final dateFormat = DateFormat('dd MMM yyyy');
  try {
    final parsedDate = dateFormat.parse(dateString);
    print(parsedDate);
    return parsedDate;
  } catch (e) {
    print('Invalid date format');
  }
}

void showEErrotrToast(String title, String message) {
  Get.snackbar(title ?? '', message ?? '',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.deleteButtonColor);
}

void showSuccessToast(String title, String message) {
  Get.snackbar(title, message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.statusButtonTexttColorPaiid);
}
