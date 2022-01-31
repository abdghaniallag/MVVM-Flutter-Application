// to convert responses to non nullable objects (model)
import 'package:mvvm_first_c/data/responses/responses.dart';
import 'package:mvvm_first_c/domain/model.dart';
import 'package:mvvm_first_c/app/extentions.dart';

const EMPTY = "";
const ZERO = 0;

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
        this?.id?.orEmpty() ?? EMPTY,
        this?.name?.orEmpty() ?? EMPTY,
        this?.numNotification?.orEmpty() ?? ZERO);
  }
}

extension ContactsResponseMapper on ContactsResponse? {
  Contacts toDomain() {
    return Contacts(this?.phone?.orEmpty() ?? EMPTY,
        this?.link?.orEmpty() ?? EMPTY, this?.email?.orEmpty() ?? EMPTY);
  }
}

extension AuthenticationResponsMapper on AuthenticationRespons? {
  Authentication toDomain() {
    return Authentication(
        this?.customer?.toDomain(), this?.contacts?.toDomain());
  }
}
extension ForgotPasswordResponseMapper on ForgotPasswordResponse? {
  String toDomain() {
    return  
        this?.support?.orEmpty()?? EMPTY;
  }
}

