import 'package:user_core2/model/product.dart';

/* 카트에 추가 */
class CartRequestBody {
  dynamic productId;
  int quantity;
  List<CartOption>? options;
  String cartType;

  CartRequestBody(
      {required this.productId,
      required this.quantity,
      required this.options,
      required this.cartType});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> body = {};
    body['product_id'] = productId;
    body['quantity'] = quantity;
    body['options'] =
        options != null ? options!.map((v) => v.toJson()).toList() : null;
    body['cart_type'] = cartType;
    return body;
  }
}

class CartOption {
  dynamic id;
  String name;
  List<dynamic> childrenOptions; // id, name, price
  CartOption(
      {required this.id, required this.name, required this.childrenOptions});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> body = {};
    body['id'] = id;
    body['name'] = name;
    body['children_options'] = childrenOptions;
    return body;
  }

  factory CartOption.fromJson(Map<String, dynamic> json) => CartOption(
      id: json['id'],
      name: json['name'],
      childrenOptions: json['children_options'] ?? []);
}

/* 카트 리스트 */
class CartResponse {
  bool status;
  String message;
  CartResponseData? data;
  bool isDataHasMore;
  CartResponse(
      {required this.status,
      required this.message,
      required this.data,
      required this.isDataHasMore});
  factory CartResponse.fromJson(Map<String, dynamic> json) => CartResponse(
      status: json['status'],
      message: json['message'] ?? '',
      data:
          json['data'] != null ? CartResponseData.fromJson(json['data']) : null,
      isDataHasMore: json['data'] != null
          ? (json['data']['next_page_url'] != null)
          : false);
}

class CartResponseData {
  List<Cart> data;
  int total;
  CartResponseData({required this.data, required this.total});
  factory CartResponseData.fromJson(Map<String, dynamic> json) =>
      CartResponseData(
          data: json['data'] != null
              ? List<Cart>.from(json['data'].map((x) => Cart.fromJson(x)))
              : [],
          total: json['total'] ?? 0);
}

class Cart {
  dynamic id;
  String cartType;
  dynamic productId;
  List<CartOption> options;
  int productPrice;
  int optionPrice;
  int quantity;
  bool isPurchasable;
  Product product;

  Cart(
      {required this.id,
      required this.cartType,
      required this.productId,
      required this.options,
      required this.productPrice,
      required this.optionPrice,
      required this.quantity,
      required this.isPurchasable,
      required this.product});
  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
      id: json['id'],
      cartType: json['cart_type'] ?? '',
      productId: json['product_id'],
      options: json['options'] != null
          ? List<CartOption>.from(
              json['options'].map((x) => CartOption.fromJson(x)))
          : [],
      productPrice: json['product_price'],
      optionPrice: json['option_price'],
      quantity: json['quantity'],
      isPurchasable: json['is_purchasable'],
      product: Product.fromJson(json['product']));
}
