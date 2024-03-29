import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user_core2/global_variable.dart';
import 'package:user_core2/model/product.dart';
import 'package:user_core2/service/service.dart';

class ProductServices {
  static Future<ProductResponse> getProductsByGroup(
      groupId, orderBy, direction, page) async {
    var response = await http.get(
      Uri.parse(
          '${ServiceAPI.baseUrl}/products/group/$groupId?order_by=$orderBy&direction=$direction&count=${GlobalVariable.count}&page=$page'),
      headers: ServiceAPI.headerInfo,
    );
    return ProductResponse.fromJson(jsonDecode(response.body));
  }

  /* 상품 컬렉션 아이디로 상품 조회 */
  static Future<ProductResponse> getProductsByCollection(
      collectionId, orderBy, direction, page) async {
    var response = await http.get(
      Uri.parse(
          '${ServiceAPI.baseUrl}/products/collection/$collectionId?order_by=$orderBy&direction=$direction&count=${GlobalVariable.count}&page=$page'),
      headers: ServiceAPI.headerInfo,
    );
    return ProductResponse.fromJson(jsonDecode(response.body));
  }

  /* 상품 검색 */
  static Future<ProductResponse> getProductsBySearch(
      keyWord, brandId, orderBy, direction, page) async {
    var response = await http.get(
      Uri.parse(
          '${ServiceAPI.baseUrl}/products/search?key_word=$keyWord&brand_id=$brandId&direction=$direction&order_by=$orderBy&count=${GlobalVariable.count}&page=$page'),
      headers: ServiceAPI.headerInfo,
    );
    return ProductResponse.fromJson(jsonDecode(response.body));
  }

  /* 메인에서 상품 컬렉션 출력 */
  static Future<ProductCollectionResponse> getProductCollections(
      brandId) async {
    var response = await http.get(
      Uri.parse(
          '${ServiceAPI.baseUrl}/collections/main?brand_id=$brandId&page=1'),
      headers: ServiceAPI.headerInfo,
    );
    return ProductCollectionResponse.fromJson(jsonDecode(response.body));
  }

  /* 상품 단일 조회 */
  static Future<Product> getProduct(productId, type) async {
    var response = await http.get(
      Uri.parse('${ServiceAPI.baseUrl}/products/$productId?type=$type'),
      headers: ServiceAPI.headerInfo,
    );
    return Product.fromJson(jsonDecode(response.body)['data']);
  }

  /* 상점별로 상품가져오기 */
  static Future<ProductResponse> getProductsByStore(
      brandId, tenantId, type, orderBy, direction, page) async {
    var response = await http.get(
      Uri.parse(
          '${ServiceAPI.baseUrl}/brands/$brandId/stores/$tenantId/products?type=$type&order_by=$orderBy&direction=$direction&page=$page'),
      headers: ServiceAPI.headerInfo,
    );
    return ProductResponse.fromJson(jsonDecode(response.body));
  }
}
