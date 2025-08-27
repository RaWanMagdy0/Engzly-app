import 'dart:async';

import 'package:engzly/core/di/di.dart';
import 'package:engzly/core/helper/functions/providers/app_provider.dart';
import 'package:engzly/core/networking/api/api_result.dart';
import 'package:engzly/features/auth/data/models/verify_email/verify_email_request_model.dart';
import 'package:engzly/features/auth/data/models/verify_email/verify_email_response_model.dart';
import 'package:engzly/core/networking/base_view_model.dart';
import 'package:engzly/features/auth/data/repo/forget_password/verify_email_repo.dart';
import 'package:engzly/features/auth/logic/forget_password/verify_email/states.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

@injectable
class VerifyEmailCubit extends BaseViewModel<VerifyEmailState> {
  final VerifyEmailRepo _verifyEmailRepo;

  VerifyEmailCubit(this._verifyEmailRepo) : super(VerifyEmailInitial());

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final verifyCodeController = TextEditingController();

  late Timer timer;
  int time = 60;
  ValueNotifier<String?> resendButtonText = ValueNotifier<String?>(" Resend");
  ValueNotifier<bool> isResendButtonEnabled = ValueNotifier<bool>(true);

  final appProvider = getIt.get<AppProvider>();

  Future<void> verifyEmail({required String verficationCode}) async {
    emit(VerifyEmailLoading());
    final verifyEmailRequest = VerifyEmailRequestModel(
        email: appProvider.email, verficationCode: verficationCode);
    final result = await _verifyEmailRepo.verifyEmail(verifyEmailRequest);
    if (result is Success<VerifyEmailResponseModel>) {
      final response = result.data;
      emit(VerifyEmailSuccess(response?.message ??
          "Verfication Code sent.Please Check Your Email"));
    } else if (result is Fail) {
      final failResult = result as Fail;
      final errorMessage = getErrorMessageFromException(failResult.exception);
      emit(VerifyEmailError(errorMessage));
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
