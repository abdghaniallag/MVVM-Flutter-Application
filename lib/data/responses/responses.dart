import 'package:json_annotation/json_annotation.dart';
part 'responses.g.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
}

@JsonSerializable()
class CustomerResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "numNotification")
  int? numNotification;
  CustomerResponse(this.id, this.name, this.numNotification);

  factory CustomerResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerResponseToJson(this);
}

@JsonSerializable()
class ContactsResponse {
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "link")
  String? link;
  @JsonKey(name: "email")
  String? email;
  ContactsResponse(this.phone, this.link, this.email);

  factory ContactsResponse.fromJson(Map<String, dynamic> json) =>
      _$ContactsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ContactsResponseToJson(this);
}

@JsonSerializable()
class AuthenticationRespons extends BaseResponse {
  @JsonKey(name: "customer")
  CustomerResponse? customer;
  @JsonKey(name: "contacte")
  ContactsResponse? contacts;
  AuthenticationRespons(this.customer, this.contacts);
//fromJson
  factory AuthenticationRespons.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponsFromJson(json);
  Map<String, dynamic> toJson() => _$AuthenticationResponsToJson(this);
}

@JsonSerializable()
class ForgotPasswordResponse extends BaseResponse {
  @JsonKey(name: 'support')
  String? support;

  ForgotPasswordResponse(this.support);

// toJson
  Map<String, dynamic> toJson() => _$ForgotPasswordResponseToJson(this);

//fromJson
  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordResponseFromJson(json);
}

@JsonSerializable()
class ServiceResponse extends BaseResponse {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "image")
  String? image;
  ServiceResponse(this.id, this.title, this.image);

  factory ServiceResponse.fromJson(Map<String, dynamic> json) =>
      _$ServiceResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceResponseToJson(this);
}

@JsonSerializable()
class StoresResponse extends BaseResponse {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "image")
  String? image;
  StoresResponse(this.id, this.title, this.image);

  factory StoresResponse.fromJson(Map<String, dynamic> json) =>
      _$StoresResponseFromJson(json);
  Map<String, dynamic> toJson() => _$StoresResponseToJson(this);
}

@JsonSerializable()
class BannersResponse extends BaseResponse {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "image")
  String? image;
  @JsonKey(name: "link")
  String? link;
  BannersResponse(this.id, this.title, this.image, this.link);

  factory BannersResponse.fromJson(Map<String, dynamic> json) =>
      _$BannersResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BannersResponseToJson(this);
}

@JsonSerializable()
class HomeDataResponse extends BaseResponse {
  @JsonKey(name: "services")
  List<ServiceResponse>? services;
  @JsonKey(name: "stores")
  List<StoresResponse>? stores;
  @JsonKey(name: "banners")
  List<BannersResponse>? banners;

  HomeDataResponse(this.services, this.stores, this.banners);
  factory HomeDataResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeDataResponseFromJson(json);
  Map<String, dynamic> toJson() => _$HomeDataResponseToJson(this);
}

@JsonSerializable()
class HomeResponse extends BaseResponse {
  @JsonKey(name: "data")
  HomeDataResponse? homeData;

  HomeResponse(this.homeData);
  factory HomeResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeResponseFromJson(json);
  Map<String, dynamic> toJson() => _$HomeResponseToJson(this);
}

@JsonSerializable()
class StoreDetailsResponse extends BaseResponse {
  @JsonKey(name: "image")
  String? image;
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "detail")
  String? detail;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "services")
  String? services;
  @JsonKey(name: "about")
  String? about;

  StoreDetailsResponse(
      this.image, this.id, this.title, this.detail, this.services, this.about);
  factory StoreDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$StoreDetailsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$StoreDetailsResponseToJson(this);
}
