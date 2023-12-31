import 'package:get/get.dart';

class LoadingController extends GetxController {
  var isLoading = false.obs;

  @override
  void onClose() {
    isLoading.value = false;
    super.onClose();
  }
}
