import 'package:perfectplate/core/exceptions/auth_exceptions.dart';

class ImageConstants {
  ImageConstants._();
  static const logoImage = 'assets/logo.png';
}

class ButtonConstants {
  ButtonConstants._();
  static const switchToSignupMode = 'Não possui uma conta? Crie uma';
  static const switchToLoginMode = 'Já possui uma conta? Faça login';
  static const login = 'Login';
  static const signup = 'Cadastrar';
  static const leave_app = 'Sair';
}

class TextFieldConstants {
  TextFieldConstants._();
  static const username = 'Nome de usuário';
  static const email = 'E-mail';
  static const password = 'Senha';
}

class ErrorMessagesConstants {
  ErrorMessagesConstants._();
  static const mandatoryFieldsEmpty = 'Por favor, preencha os campos obrigatórios';
  static const userNotFound = 'Nenhum usuário encontrado com essas credenciais';
  static const emailAlreadyExists = 'Já existe uma conta cadastrada com esse e-mail';
}
