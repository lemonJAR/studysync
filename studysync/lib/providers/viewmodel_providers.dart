import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/auth/sign_up_viewmodel.dart';
import '../viewmodels/auth/sign_up_state.dart';
import 'service_providers.dart';

final signUpViewModelProvider = StateNotifierProvider<SignUpViewModel, SignUpState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return SignUpViewModel(authRepository);
});