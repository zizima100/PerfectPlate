import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:perfectplate/data/models/auth_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthUsernameChangedEvent>(_onUsernameChanged);
    on<AuthEmailChangedEvent>(_onEmailChanged);
    on<AuthPasswordChangedEvent>(_onPasswordChanged);
    on<AuthModeSwitchedEvent>(_onModeSwitched);
  }

  void _onUsernameChanged(
      AuthUsernameChangedEvent event, Emitter<AuthState> emit) {
    emit(
      state.copyWith(email: event.username),
    );
  }

  void _onEmailChanged(AuthEmailChangedEvent event, Emitter<AuthState> emit) {
    emit(
      state.copyWith(email: event.email),
    );
  }

  void _onPasswordChanged(
      AuthPasswordChangedEvent event, Emitter<AuthState> emit) {
    emit(
      state.copyWith(email: event.password),
    );
  }

  void _onModeSwitched(AuthModeSwitchedEvent _, Emitter<AuthState> emit) {
    emit(
      state.copyWith(mode: state.mode.switchMode()),
    );
  }

  Future<void> authenticate() async {
    // TODO: consumir API de authentication
  }
}
