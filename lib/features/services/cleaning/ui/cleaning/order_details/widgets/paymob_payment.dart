import 'package:engzly/features/services/cleaning/logic/cleaning_cubit.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymobPaymentScreen extends StatefulWidget {
  final String url;
  final CleaningCubit cubit;
  final VoidCallback onPaymentSuccess;

  const PaymobPaymentScreen({
    super.key,
    required this.url,
    required this.cubit,
    required this.onPaymentSuccess,
  });

  @override
  State<PaymobPaymentScreen> createState() => _PaymobPaymentScreenState();
}

class _PaymobPaymentScreenState extends State<PaymobPaymentScreen> {
  late final WebViewController controller;
  bool paymentHandled = false;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (request) {
            if (!paymentHandled &&
                (request.url.contains("success=true") ||
                    request.url.contains("success"))) {
              paymentHandled = true;
              widget.onPaymentSuccess();
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Paymob Payment")),
      body: SafeArea(child: WebViewWidget(controller: controller)),
    );
  }
}
