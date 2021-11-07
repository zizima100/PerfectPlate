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
  static const name = 'Nome de usuário';
  static const email = 'E-mail';
  static const password = 'Senha';
  static const age = 'Idade';
  static const weight = 'Peso';
  static const height = 'Altura';
}

class ErrorMessagesConstants {
  ErrorMessagesConstants._();
  static const mandatoryFieldsEmpty =
      'Por favor, preencha os campos obrigatórios';
  static const userNotFound = 'Nenhum usuário encontrado com essas credenciais';
  static const emailAlreadyExists =
      'Já existe uma conta cadastrada com esse e-mail';
  static const plateNameIsEmpty =
      'Por favor, insira o nome do seu prato';
  static const plateIngredientsIsEmpty =
      'Por favor, insira algum ingrediente no seu prato';
  static const plateInsertionFail =
      'Houve um erro no registro do prato';
  static const numberOfPortionsEmpty =
      'Por favor, insira o número de porções consumidas';
}

class SuccessMessagesConstants {
  SuccessMessagesConstants._();
  static const plateInserted =
      'Prato registrado com sucesso!';
}
