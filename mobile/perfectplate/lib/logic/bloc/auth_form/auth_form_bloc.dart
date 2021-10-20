import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:perfectplate/data/models/auth/auth_models.dart';

part 'auth_form_event.dart';
part 'auth_form_state.dart';

class AuthFormBloc extends Bloc<AuthEvent, AuthFormState> {
  AuthFormBloc() : super(AuthInitial()) {
    on<AuthUsernameChangedEvent>(_onUsernameChanged);
    on<AuthEmailChangedEvent>(_onEmailChanged);
    on<AuthPasswordChangedEvent>(_onPasswordChanged);
    on<AuthModeSwitchedEvent>(_onModeSwitched);
  }

  void _onUsernameChanged(AuthUsernameChangedEvent event, Emitter<AuthFormState> emit) {
    emit(
      state.copyWith(username: event.username),
    );
  }

  void _onEmailChanged(AuthEmailChangedEvent event, Emitter<AuthFormState> emit) {
    emit(
      state.copyWith(email: event.email),
    );
  }

  void _onPasswordChanged(AuthPasswordChangedEvent event, Emitter<AuthFormState> emit) {
    emit(
      state.copyWith(password: event.password),
    );
  }

  void _onModeSwitched(_, Emitter<AuthFormState> emit) {
    emit(
      state.copyWith(mode: state.mode.switchMode()),
    );
  }
}
