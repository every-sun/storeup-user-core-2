import 'package:get/get.dart';
import 'package:user_core2/controller/app_controller.dart';
import 'package:user_core2/controller/order_controller.dart';
import 'package:user_core2/model/brand.dart';
import 'package:user_core2/service/brand_service.dart';
import 'package:user_core2/util/dialog.dart';

class BrandController2 extends GetxController {
  var isLoading = false.obs;
  var shippingFee = Rxn<ShippingFeeResponseData>();
  var carrier = Rxn<CarrierResponseData>();
  OrderController2 orderController = Get.put(OrderController2());

  @override
  void onInit() {
    setShippingFee();
    setCarrier();
    super.onInit();
  }

  // 배송비 정보
  Future<void> setShippingFee() async {
    try {
      isLoading.value = true;
      ShippingFeeResponse response = await BrandServices.getShippingFee(
          Get.find<AppController2>().appInfo.value!.brandId);
      isLoading.value = false;
      if (response.status) {
        shippingFee.value = response.data;
      } else {
        showBasicAlertDialog(response.message != ''
            ? response.message
            : '배송비 정보를 불러올 수 없습니다. 다시 시도해주세요.');
      }
    } catch (err) {
      showErrorDialog();
      isLoading.value = false;
      return;
    }
  }

  // 배송비 가져오기

  int getShippingFee() {
    if (shippingFee.value == null) return 0;
    if (shippingFee.value!.conditionType == 'P') {
      if (orderController.selectCartSumPrice.value >=
          shippingFee.value!.condition) {
        return shippingFee.value!.conditionFee;
      } else {
        // TODO 당일배달
        // if (orderType.value == 'N' &&
        //     (addressController.userDefaultAddress.value != null &&
        //         addressController.userDefaultAddress.value!.availableRegion!)) {
        //   return addressController.userDefaultAddress.value!.regionChargingFee!;
        // } else {
        //   return shippingFee.value!.defaultFee;
        // }
      }
    } else if (shippingFee.value!.conditionType == 'F') {
      return 0;
    }
    return 0;
  }

  // 택배 정보
  Future<void> setCarrier() async {
    try {
      isLoading.value = true;
      CarrierResponse response = await BrandServices.getCarrier(
          Get.find<AppController2>().appInfo.value!.brandId);
      isLoading.value = false;
      if (response.status) {
        carrier.value = response.data;
      } else {
        showBasicAlertDialog(response.message != ''
            ? response.message
            : '택배 정보를 불러올 수 없습니다. 다시 시도해주세요.');
      }
    } catch (err) {
      showErrorDialog();
      isLoading.value = false;
      return;
    }
  }
}