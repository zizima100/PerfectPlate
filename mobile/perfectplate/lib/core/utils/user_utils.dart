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

  static UserType parseTypeStringEnumToEnum(String e) {
    if (e == UserType.bodybuilder.toString().split('.')[1]) {
      return UserType.bodybuilder;
    } else if (e ==
        UserType.nutritionist.toString().split('.')[1]) {
      return UserType.nutritionist;
    } else {
      return UserType.defaultUser;
    }
  }

    static String parseSexEnumToTitle(SexType e) {
    switch (e) {
      case SexType.masculine:
        return 'Masculino';
      case SexType.feminine:
        return 'Feminino';
      case SexType.other:
        return 'Outro';
      default:
        return '';
    }
  }

  static SexType parseSexStringEnumToEnum(String e) {
    if (e == SexType.masculine.toString().split('.')[1]) {
      return SexType.masculine;
    } else if (e ==
        SexType.feminine.toString().split('.')[1]) {
      return SexType.feminine;
    } else {
      return SexType.other;
    }
  }
}