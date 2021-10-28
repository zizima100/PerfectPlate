import 'package:perfectplate/data/models/auth/auth_models.dart';

class UserUtils {
  UserUtils._();

  static String parseTypeEnumToTitle(UserType e) {
    switch (e) {
      case UserType.bodybuilder:
        return 'Fisiculturista';
      case UserType.nutritionist:
        return 'Nutricionista';
      case UserType.defaultUser:
        return 'Padrão';
      default:
        return '';
    }
  }

  static UserType parseStringEnumToEnum(String e) {
    if (e == UserType.bodybuilder.toString().split('.')[1]) {
      return UserType.bodybuilder;
    } else if (e ==
        UserType.nutritionist.toString().split('.')[1]) {
      return UserType.nutritionist;
    } else {
      return UserType.defaultUser;
    }
  }
}