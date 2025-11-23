import 'package:engzly/core/di/di.dart';
import 'package:engzly/core/routing/route_name.dart';
import 'package:engzly/features/auth/logic/login_cubit/google.dart/google_states.dart';
import 'package:engzly/features/auth/logic/login_cubit/login/cubit.dart';
import 'package:engzly/features/auth/logic/login_cubit/google.dart/google_cubit.dart';
import 'package:engzly/features/auth/logic/login_cubit/login/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GoogleLoginScreen extends StatelessWidget {
  const GoogleLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<LoginCubit>()),
        BlocProvider(create: (context) => getIt<GoogleLoginCubit>()),
      ],
      child: const LoginScreenBody(),
    );
  }
}

class LoginScreenBody extends StatefulWidget {
  const LoginScreenBody({Key? key}) : super(key: key);

  @override
  State<LoginScreenBody> createState() => _LoginScreenBodyState();
}

class _LoginScreenBodyState extends State<LoginScreenBody> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: MultiBlocListener(
          listeners: [
            // Listener للـ Normal Login
            BlocListener<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state is LoginSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('مرحباً ${state.message}! 👋'),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                  // الانتقال للصفحة الرئيسية
                  Navigator.pushReplacementNamed(context, RouteName.homeLayout);
                } else if (state is LoginError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
            ),

            // Listener للـ Google Login
            BlocListener<GoogleLoginCubit, GoogleLoginState>(
              listener: (context, state) {
                if (state is GoogleLoginSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('مرحباً ${state.message}! 🎉'),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                  // الانتقال للصفحة الرئيسية
                  Navigator.pushReplacementNamed(context, RouteName.homeLayout);
                } else if (state is GoogleLoginError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
            ),
          ],
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 40),

                  // Logo or Icon
                  Icon(
                    Icons.lock_outline_rounded,
                    size: 80,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(height: 24),

                  // Title
                  const Text(
                    'مرحباً بك',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Subtitle
                  Text(
                    'سجل الدخول للمتابعة',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 48),

                  // Email Field
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textDirection: TextDirection.ltr,
                    decoration: InputDecoration(
                      labelText: 'البريد الإلكتروني',
                      hintText: 'example@email.com',
                      prefixIcon: const Icon(Icons.email_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey[50],
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'من فضلك أدخل البريد الإلكتروني';
                      }
                      if (!value.contains('@')) {
                        return 'البريد الإلكتروني غير صحيح';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Password Field
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    textDirection: TextDirection.ltr,
                    decoration: InputDecoration(
                      labelText: 'كلمة المرور',
                      hintText: '••••••••',
                      prefixIcon: const Icon(Icons.lock_outlined),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey[50],
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'من فضلك أدخل كلمة المرور';
                      }
                      if (value.length < 6) {
                        return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Remember Me & Forget Password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: _rememberMe,
                            onChanged: (value) {
                              setState(() {
                                _rememberMe = value ?? false;
                              });
                            },
                          ),
                          const Text('تذكرني'),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigate to forget password
                          Navigator.pushNamed(context, '/forget-password');
                        },
                        child: const Text('نسيت كلمة المرور؟'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Login Button
                  BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, state) {
                      final isLoading = state is LoginLoading;

                      return ElevatedButton(
                        onPressed: isLoading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<LoginCubit>().login(
                                        email: _emailController.text.trim(),
                                        password: _passwordController.text,
                                        rememberMe: _rememberMe,
                                      );
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                        child: isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                            : const Text(
                                'تسجيل الدخول',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),

                  // Divider with "أو"
                  Row(
                    children: [
                      Expanded(child: Divider(color: Colors.grey[300])),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'أو',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(child: Divider(color: Colors.grey[300])),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Google Login Button
                  BlocBuilder<GoogleLoginCubit, GoogleLoginState>(
                    builder: (context, state) {
                      final isLoading = state is GoogleLoginLoading;

                      return OutlinedButton.icon(
                        onPressed: isLoading
                            ? null
                            : () {
                                context
                                    .read<GoogleLoginCubit>()
                                    .loginWithGoogle();
                              },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          side: BorderSide(color: Colors.grey[300]!),
                        ),
                        icon: isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : Image.network(
                                'https://www.google.com/favicon.ico',
                                height: 24,
                                width: 24,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(
                                    Icons.g_mobiledata,
                                    size: 24,
                                  );
                                },
                              ),
                        label: Text(
                          isLoading
                              ? 'جاري تسجيل الدخول...'
                              : 'تسجيل الدخول بجوجل',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 32),

                  // Sign Up Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'ليس لديك حساب؟ ',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/signup');
                        },
                        child: const Text(
                          'إنشاء حساب',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

 // comment الزر لحد ما تحلي المشكلة