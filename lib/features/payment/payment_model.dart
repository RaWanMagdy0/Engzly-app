import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymobPayment extends StatefulWidget {
  final String url;
  final String title;

  const PaymobPayment({
    super.key,
    required this.url,
    this.title = 'Paymob Payment',
  });

  @override
  State<PaymobPayment> createState() => _PaymobPaymentState();
}

class _PaymobPaymentState extends State<PaymobPayment> {
  late final WebViewController controller;
  bool paymentHandled = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  void _initializeWebView() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() => isLoading = true);
            print('🔵 Page Started: $url');
          },
          onPageFinished: (url) {
            setState(() => isLoading = false);
            print('🟢 Page Finished: $url');
            _checkPaymentStatus(url);
          },
          onNavigationRequest: (request) {
            print('🔶 Navigation Request: ${request.url}');
            _checkPaymentStatus(request.url);
            return NavigationDecision.navigate;
          },
          onWebResourceError: (error) {
            print('🔴 Error: ${error.description}');
            if (!paymentHandled && context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Payment error: ${error.description}'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  void _checkPaymentStatus(String url) {
    if (paymentHandled) return;

    final lowerUrl = url.toLowerCase();

    if (lowerUrl.contains('success=true') ||
        lowerUrl.contains('success') && !lowerUrl.contains('success=false') ||
        lowerUrl.contains('transaction') && lowerUrl.contains('success') ||
        lowerUrl.contains('txn') && lowerUrl.contains('success') ||
        lowerUrl.contains('payment') && lowerUrl.contains('success') ||
        lowerUrl.contains('callback') && lowerUrl.contains('success')) {
      print('✅ Payment Success Detected!');
      paymentHandled = true;

      if (mounted) {
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            Navigator.of(context).pop(true);
          }
        });
      }
      return;
    }
    if (lowerUrl.contains('success=false') ||
        lowerUrl.contains('failed') ||
        lowerUrl.contains('cancel') ||
        lowerUrl.contains('error') ||
        lowerUrl.contains('decline')) {
      print('❌ Payment Failed Detected!');
      paymentHandled = true;

      if (mounted) {
        Navigator.of(context).pop(false);
      }
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await _showCancelDialog();
        return shouldPop ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () async {
              final shouldClose = await _showCancelDialog();
              if (shouldClose == true && mounted) {
                Navigator.of(context).pop(false);
              }
            },
          ),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              WebViewWidget(controller: controller),
              if (isLoading)
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text('Loading payment page...'),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool?> _showCancelDialog() {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Payment'),
        content: const Text('Are you sure you want to cancel this payment?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Yes', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
