class SliderObject {
  String title;
  String subTitle;
  String image;
  SliderObject(this.title, this.subTitle, this.image);
}

class Customer {
  String id;
  String name;
  int numNotification;
  Customer(this.id, this.name, this.numNotification);
}

class Contacts {
  String phone;
  String link;
  String email;
  Contacts(this.phone, this.link, this.email);
}

class Authentication {
  Customer? customer;
  Contacts? contacts;
  Authentication(this.customer, this.contacts);
}

class DeviceInfo {
  String name;
  String identifier;
  String version;
  DeviceInfo(this.name, this.identifier, this.version);
}

class Service {
  int id;
  String title;
  String image;
  Service(this.id, this.title, this.image);
}

class Stores {
  int id;
  String title;
  String image;
  Stores(this.id, this.title, this.image);
}

class BannerAd {
  int id;
  String title;
  String image;
  String link;
  BannerAd(this.id, this.title, this.image, this.link);
}

class HomeData {
  List<Service> services;
  List<Stores> stores;
  List<BannerAd> banners;
  HomeData(this.services, this.stores, this.banners);
}

class HomeObject {
  HomeData homeData;
  HomeObject(this.homeData);
}

class StoreDetail {
  int id;
  String image;
  String title;
  String detail;
  String services;
  String about;
  StoreDetail(
      this.image, this.id, this.title, this.detail, this.services, this.about);
}
