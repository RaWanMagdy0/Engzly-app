import 'package:engzly/features/payment/payment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:engzly/core/theming/colors.dart';

class PaymentHandler {
  static Future<bool> handleStripePayment({
    required BuildContext context,
    required String clientSecret,
    String merchantName = 'Engzly App',
  }) async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: merchantName,
          style: ThemeMode.light,
          allowsDelayedPaymentMethods: true,
        ),
      );

      await Stripe.instance.presentPaymentSheet();
      return true;
    } on StripeException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Payment failed: ${e.error.localizedMessage}'),
            backgroundColor: ColorsManager.red,
          ),
        );
      }
      return false;
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Unexpected error: $e')),
        );
      }
      return false;
    }
  }

  static Future<bool> handlePaymobPayment({
    required BuildContext context,
    required String paymentUrl,
    String title = 'Paymob Payment',
  }) async {
    if (paymentUrl.isEmpty) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No Paymob payment link available')),
        );
      }
      return false;
    }

    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => PaymobPayment(
          url: paymentUrl,
          title: title,
        ),
      ),
    );

    return result ?? false;
  }

  static Future<String?> showPaymentTypeBottomSheet(BuildContext context) {
    return showModalBottomSheet<String>(
      backgroundColor: Colors.white,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 16,
            left: 16,
            right: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Choose Payment Type",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 10),
              ListTile(
                leading: Icon(Icons.credit_card, color: ColorsManager.green),
                title: Text("Credit Card"),
                onTap: () => Navigator.pop(context, "credit"),
              ),
              ListTile(
                leading: Icon(Icons.credit_score, color: ColorsManager.green),
                title: Text("Debit Card"),
                onTap: () => Navigator.pop(context, "debit"),
              ),
              SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  static int getPaymentMethodId({
    required String paymentMethod,
    String? onlinePaymentType,
  }) {
    if (paymentMethod == 'cash') {
      return 2;
    } else if (onlinePaymentType == 'credit') {
      return 1;
    } else {
      return 3;
    }
  }
}

class CheckoutPaymentData {
  final String? clientSecret; 
  final String? paymentUrl; 
  final String paymentMethod;
  final String? onlinePaymentType;

  CheckoutPaymentData({
    this.clientSecret,
    this.paymentUrl,
    required this.paymentMethod,
    this.onlinePaymentType,
  });

  CheckoutPaymentData copyWith({
    String? clientSecret,
    String? paymentUrl,
    String? paymentMethod,
    String? onlinePaymentType,
  }) {
    return CheckoutPaymentData(
      clientSecret: clientSecret ?? this.clientSecret,
      paymentUrl: paymentUrl ?? this.paymentUrl,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      onlinePaymentType: onlinePaymentType ?? this.onlinePaymentType,
    );
  }

  @override
  String toString() {
    return 'CheckoutPaymentData(clientSecret: ${clientSecret != null ? "***" : null}, paymentUrl: ${paymentUrl != null ? "***" : null}, paymentMethod: $paymentMethod, onlinePaymentType: $onlinePaymentType)';
  }
}


class PaymentService {
  static Future<bool> processPayment({
    required BuildContext context,
    required CheckoutPaymentData paymentData,
    String merchantName = 'Engzly App',
  }) async {
    print('🔄 Processing Payment...');
    print('   Method: ${paymentData.paymentMethod}');
    print('   Online Type: ${paymentData.onlinePaymentType}');
    print('   Has Client Secret: ${paymentData.clientSecret != null}');
    print('   Has Payment URL: ${paymentData.paymentUrl != null}');

    if (paymentData.paymentMethod == 'cash') {
      print('✅ Cash Payment - No processing needed');
      return true;
    }

    if (paymentData.paymentMethod == 'online') {
      if (paymentData.clientSecret?.isNotEmpty == true) {
        print('💳 Using Stripe Payment...');
        final result = await PaymentHandler.handleStripePayment(
          context: context,
          clientSecret: paymentData.clientSecret!,
          merchantName: merchantName,
        );
        print(' Stripe Result: $result');
        return result;
      }
      else if (paymentData.paymentUrl?.isNotEmpty == true &&
          paymentData.onlinePaymentType != "credit") {
        print(' Using Paymob Payment...');
        final result = await PaymentHandler.handlePaymobPayment(
          context: context,
          paymentUrl: paymentData.paymentUrl!,
        );
        print(' Paymob Result: $result');
        return result;
      } else {
        print('❌ No valid payment method found!');
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No valid payment link found for online payment'),
            ),
          );
        }
        return false;
      }
    }

    print('❌ Unknown payment method!');
    return false;
  }

  static Future<CheckoutPaymentData?> selectPaymentMethod({
    required BuildContext context,
    required String selectedPaymentMethod,
  }) async {
    print('🔍 Selecting Payment Method: $selectedPaymentMethod');
    
    String? onlinePaymentType;

    if (selectedPaymentMethod == 'online') {
      onlinePaymentType = await PaymentHandler.showPaymentTypeBottomSheet(context);
      if (onlinePaymentType == null) {
        print('⚠️ User cancelled payment type selection');
        return null;
      }
    }

    final data = CheckoutPaymentData(
      paymentMethod: selectedPaymentMethod,
      onlinePaymentType: onlinePaymentType,
    );
    
    print('✅ Payment Data Created: ${data.toString()}');
    return data;
  }
}
