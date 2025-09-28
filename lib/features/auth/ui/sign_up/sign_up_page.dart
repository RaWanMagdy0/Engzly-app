import 'package:engzly/core/di/di.dart';
import 'package:engzly/core/helper/functions/dialogs/app_dialogs.dart';
import 'package:engzly/core/routing/route_name.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/features/auth/logic/register_cubit/cubit.dart';
import 'package:engzly/features/auth/logic/register_cubit/states.dart';
import 'package:engzly/features/auth/ui/sign_up/widgets/register_form.dart'
    show RegisterFormFields;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late RegisterCubit viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = getIt.get<RegisterCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      bloc: viewModel,
      listener: (context, state) => _handelStateChange(state),
      child: BlocBuilder<RegisterCubit, RegisterState>(
        bloc: viewModel,
        builder: (context, state) {
          return Stack(
            children: [
              Scaffold(
                appBar: AppBar(
                  forceMaterialTransparency: true,
                  title: Text(
                    "Register",
                    style: AppFonts.font20BlackWeight700.copyWith(
                      fontSize: 18.sp,
                    ),
                  ),
                  centerTitle: true,
                ),
                body: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Text(
                        "Getting Started",
                        style: AppFonts.font36BlackWeight700,
                      ),
                      10.verticalSpace,
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RegisterFormFields(viewModel: viewModel),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (state is RegisterLoading)
                Container(
                  color: Colors.black45,
                  child: Center(
                    child:
                        CircularProgressIndicator(color: ColorsManager.orange),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  void _handelStateChange(RegisterState state) {
    if (state is RegisterError) {
      AppDialogs.showErrorDialog(
        context: context,
        errorMassage: state.error,
      );
    } else if (state is RegisterSuccess) {
      AppDialogs.showSuccessDialog(
        context: context,
        message: state.message,
      );

      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, RouteName.emailConfirmation);
      });
    }
  }
}
/*************
 *  if (state is LoginLoading) {
          AppDialogs.showLoading(context: context);
        } else if (state is LoginSuccess) {

          AppDialogs.showHideDialog(context);
          AppDialogs.showSuccessDialog(
            context: context,
            message: "Login Successfully",
          );

          Future.delayed(Duration(seconds: 2), () {
            Navigator.pushReplacementNamed(context, PageRouteName.layoutScreen);
          });
        } else if (state is LoginError) {
          AppDialogs.showHideDialog(context);
          AppDialogs.showErrorDialog(
            context: context,
            errorMassage: "incorrect email or password",
          );
        }
 */
