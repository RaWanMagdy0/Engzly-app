import 'dart:async';

import 'package:engzly/core/di/di.dart';
import 'package:engzly/core/helper/functions/providers/app_provider.dart';
import 'package:engzly/core/networking/api/api_result.dart';
import 'package:engzly/core/networking/base_view_model.dart';
import 'package:engzly/features/auth/data/models/signup/register_request_body.dart';
import 'package:engzly/features/auth/data/models/signup/register_response_model.dart';
import 'package:engzly/features/auth/data/models/confirm_email/confirm_email_request_body.dart';
import 'package:engzly/features/auth/data/models/confirm_email/confirm_email_response_model.dart';
import 'package:engzly/features/auth/data/repo/register/register_repo.dart';
import 'package:engzly/features/auth/data/repo/register/confirm_email_repo.dart';
import 'package:engzly/features/auth/logic/register_cubit/states.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterCubit extends BaseViewModel<RegisterState> {
  final RegisterRepo _registerRepo;
  final ConfirmEmailRepo _confirmEmailRepo;

  RegisterCubit(this._registerRepo, this._confirmEmailRepo)
      : super(RegisterInitial());

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final zipCodeController = TextEditingController();
  final stateController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final appProvider = getIt.get<AppProvider>();
  late Timer timer;
  int time = 60;
  ValueNotifier<String?> resendButtonText = ValueNotifier<String?>(" Resend");
  ValueNotifier<bool> isResendButtonEnabled = ValueNotifier<bool>(true);

  Future<void> register({
    required String fullName,
    required String email,
    required String address,
    required String password,
    required String confirmPassword,
    required String phoneNumber,
  }) async {
    emit(RegisterLoading());

    final registerRequest = RegisterRequestBody(
      fullName: fullName,
      email: email,
      address: address,
      password: password,
      confirmPassword: confirmPassword,
      phoneNumber: phoneNumber,
    );

    final result = await _registerRepo.register(registerRequest);

    if (result is Success<RegisterResponseModel>) {
      final response = result.data;
      email = emailController.text;
      appProvider.email = email;
      emit(RegisterSuccess(response?.message ?? "Sign up successfully"));
    } else if (result is Fail) {
      final failResult = result as Fail;
      final errorMessage = getErrorMessageFromException(failResult.exception);
      emit(RegisterError(errorMessage));
    }
  }

  Future<void> confirmEmail({
    required String otp,
  }) async {
    emit(RegisterLoading());

    final confirmEmailRequest =
        ConfirmEmailRequestBody(email: appProvider.email, otp: otp);
    final result = await _confirmEmailRepo.confirmEmail(confirmEmailRequest);
    if (result is Success<ConfirmEmailResponseModel>) {
      final response = result.data;
      emit(ConfirmEmailSuccess(response?.message ?? "Account created"));
      if (kDebugMode) {
        print(response?.message ?? "");
      }
    } else if (result is Fail) {
      final failResult = result as Fail;
      final errorMessage = getErrorMessageFromException(failResult.exception);
      emit(ConfirmEmailError(errorMessage));
    }
  }

  void startResendTimer() {
    time = 300;
    isResendButtonEnabled.value = false;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (time > 1) {
        time--;
        resendButtonText.value = formatTime(time);
      } else {
        timer.cancel();
        resendButtonText.value = " Resend";
        isResendButtonEnabled.value = true;
      }
    });
  }

  String formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
    return "$minutes:$remainingSeconds";
  }

  void disposeTimer() {
    timer.cancel();
  }
}
