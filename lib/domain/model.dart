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

class Authentication  {
  Customer? customer;
  Contacts? contacts;
  Authentication (this.customer, this.contacts);
}
class DeviceInfo {
  String name;
  String identifier;
  String version;
  DeviceInfo(this.name,this.identifier,this.version);
  
}