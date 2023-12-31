import 'dart:convert';

import 'package:user_core2/model/delivery_product.dart';
import 'package:user_core2/model/language.dart';

/* 상품 */
class ProductResponse {
  bool status;
  String message;
  ProductResponseData? data;
  bool isDataHasMore;
  ProductResponse(
      {required this.status,
      required this.message,
      required this.data,
      required this.isDataHasMore});
  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      ProductResponse(
          status: json['status'],
          message: json['message'] ?? '',
          data: json['data'] != null
              ? ProductResponseData.fromJson(json['data'])
              : null,
          isDataHasMore: json['data'] != null
              ? (json['data']['next_page_url'] != null)
              : false);
}

class ProductResponseData {
  List<Product> data;
  int total;
  ProductResponseData({required this.data, required this.total});
  factory ProductResponseData.fromJson(Map<String, dynamic> json) =>
      ProductResponseData(
          data: json['data'] != null
              ? List<Product>.from(json['data'].map((x) => Product.fromJson(x)))
              : [],
          total: json['total'] ?? 0);
}

class Product {
  dynamic id;
  dynamic globalId;
  dynamic tenantId;
  String name;
  String description;
  Map? noticeInformation;
  String detailContents;
  String? taxType;
  String? taxRate;
  bool isOnline;
  bool isDelivery;
  bool isNow;
  ProductOnline? online; // 주문 아이템 안에는 null
  ImageData? data;
  List<ProductOption> options;
  Map<String, dynamic> store;
  DeliveryDetailInfo? delivery;
  Product(
      {required this.id,
      required this.globalId,
      required this.tenantId,
      required this.name,
      required this.description,
      required this.noticeInformation,
      required this.detailContents,
      required this.taxType,
      required this.taxRate,
      required this.isOnline,
      required this.isDelivery,
      required this.isNow,
      required this.online,
      required this.data,
      required this.options,
      required this.store,
      required this.delivery});
  factory Product.fromJson(Map<String, dynamic> json) => Product(
      id: json['id'],
      globalId: json['global_id'],
      tenantId: json['tenant_id'],
      name: json['name'] != null ? Language.fromJson(json['name']).ko : '',
      description: json['description'] != null
          ? Language.fromJson(json['description']).ko
          : '',
      noticeInformation: json['notice_information'] != null
          ? (json['notice_information'].runtimeType == String
              ? jsonDecode(json['notice_information'])
              : json['notice_information'])
          : null,
      detailContents: json['detail_contents'] ?? '',
      taxType: json['tax_type'],
      taxRate: json['tax_rate'],
      isOnline: json['is_online'],
      isDelivery: json['is_delivery'],
      isNow: json['is_now'],
      online: json['online'] != null
          ? ProductOnline.fromJson(json['online'])
          : null,
      data: json['data'] != null ? ImageData.fromJson(json['data']) : null,
      options: json['options'] != null
          ? List<ProductOption>.from(
              json['options'].map((x) => ProductOption.fromJson(x)))
          : [],
      store: json['store'] ?? {},
      delivery: json['delivery'] != null
          ? DeliveryDetailInfo.fromJson(json['delivery'])
          : null);
}

class ProductOption {
  dynamic id;
  dynamic globalId;
  String optionType;
  dynamic optionId;
  String name;
  String description;
  int min;
  int max;
  bool isParent;
  int optionPrice;
  List<ProductOption> childrenOptions;
  ProductOption(
      {required this.id,
      required this.globalId,
      required this.optionType,
      required this.optionId,
      required this.name,
      required this.description,
      required this.min,
      required this.max,
      required this.isParent,
      required this.optionPrice,
      required this.childrenOptions});
  factory ProductOption.fromJson(Map<String, dynamic> json) => ProductOption(
      id: json['id'],
      globalId: json['global_id'],
      optionType: json['option_type'],
      optionId: json['option_id'],
      name: json['name'] != null ? Language.fromJson(json['name']).ko : '',
      description: json['description'] != null
          ? Language.fromJson(json['description']).ko
          : '',
      min: json['min'],
      max: json['max'],
      isParent: json['is_parent'],
      optionPrice: json['option_price'],
      childrenOptions: json['children_options'] != null
          ? List<ProductOption>.from(
              json['children_options'].map((x) => ProductOption.fromJson(x)))
          : []);
}

class ProductOnline {
  dynamic id;
  dynamic productId;
  int price;
  String description;
  bool isPurchasable;
  bool isTemporarySoldOut;
  bool isManageStock;
  bool isDiscount;
  int stockQuantity;
  int safetyInventory;
  String discountType; // F ->discountAmount, P ->discountPercentage
  int discountPrice; // is_discount = true 이면
  int discountAmount;
  int discountPercentage;
  int purchasableQuantityMin;
  int purchasableQuantityMax;
  ProductOnline(
      {required this.id,
      required this.productId,
      required this.price,
      required this.description,
      required this.isPurchasable,
      required this.isTemporarySoldOut,
      required this.isManageStock,
      required this.isDiscount,
      required this.stockQuantity,
      required this.safetyInventory,
      required this.discountType,
      required this.discountPrice,
      required this.discountAmount,
      required this.discountPercentage,
      required this.purchasableQuantityMin,
      required this.purchasableQuantityMax});
  factory ProductOnline.fromJson(Map<String, dynamic> json) => ProductOnline(
      id: json['id'],
      productId: json['product_id'],
      price: json['price'],
      description: json['description'] != null
          ? Language.fromJson(json['description']).ko
          : '',
      isPurchasable: json['is_purchasable'],
      isTemporarySoldOut: json['is_temporary_sold_out'],
      isDiscount: json['is_discount'],
      isManageStock: json['is_manage_stock'],
      stockQuantity: json['stock_quantity'],
      safetyInventory: json['safety_inventory'],
      discountType: json['discount_type'],
      discountPrice: json['discount_price'],
      discountAmount: json['discount_amount'],
      discountPercentage: json['discount_percentage'],
      purchasableQuantityMin: json['purchasable_quantity_min'] == 0
          ? 1
          : json['purchasable_quantity_min'],
      purchasableQuantityMax: json['purchasable_quantity_max']);
}

/* -----상품---- */

/* 상품 컬렉션 */
class ProductCollectionResponse {
  bool status;
  ProductCollectionData? data;
  ProductCollectionResponse({required this.status, required this.data});
  factory ProductCollectionResponse.fromJson(Map<String, dynamic> json) =>
      ProductCollectionResponse(
          status: json['status'],
          data: json['data'] != null
              ? ProductCollectionData.fromJson(json['data'])
              : null);
}

class ProductCollectionData {
  List<ProductCollection> productCollections;
  int total;
  ProductCollectionData(
      {required this.productCollections, required this.total});
  factory ProductCollectionData.fromJson(Map<String, dynamic> json) =>
      ProductCollectionData(
          productCollections: json['data'] != null
              ? List<ProductCollection>.from(
                  json['data'].map((x) => ProductCollection.fromJson(x)))
              : [],
          total: json['total'] ?? 0);
}

class ProductCollection {
  dynamic id;
  String name;
  String description;
  List<Product> products;
  int total;
  ProductCollection(
      {required this.id,
      required this.name,
      required this.description,
      required this.products,
      required this.total});
  factory ProductCollection.fromJson(Map<String, dynamic> json) =>
      ProductCollection(
        id: json['id'],
        name: json['name'] != null ? Language.fromJson(json['name']).ko : '',
        description: json['description'] != null
            ? Language.fromJson(json['description']).ko
            : '',
        products: json['products'] != null
            ? List<Product>.from(
                json['products'].map((x) => Product.fromJson(x)))
            : [],
        total: json['total'] ?? 0,
      );
}
/*----- 상품 컬렉션 -----*/

class ImageData {
  String? thumbnail;
  Map<dynamic, dynamic>? images;
  ImageData({required this.thumbnail, this.images});
  factory ImageData.fromJson(Map<dynamic, dynamic> json) => ImageData(
      thumbnail: (json['thumbnail'] != null && json['thumbnail'].isNotEmpty)
          ? json['thumbnail'].values.toList()[0]
          : null,
      images: json['images']);
}
