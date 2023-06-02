
import 'package:flutter/material.dart';
import 'package:moyasar/moyasar.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vaea_mobile/data/enums/lease_period_enum.dart';

import '../../../data/enums/payment_provider_enum.dart';

/// It handles building and managing the payment fields.
class PaymentForm extends StatelessWidget {


  late PaymentConfig moyasarPaymentConfig;

  int amount;
  void Function(
      PaymentProviderEnum paymentProvider,
      String paymentId)
  handleSubmit;

  PaymentForm({
    super.key,
    required this.amount,
    required this.handleSubmit,
  }){
    setupMoyasarPaymentConfig();
  }

  /// It is a helper method for the constructor. It setups the config object of
  /// payment
  void setupMoyasarPaymentConfig() {
    moyasarPaymentConfig = PaymentConfig(
      publishableApiKey: 'pk_test_4mhXSm9rS8ANpe3bAQYHKFvR37xkp98s4odDXy2P',
      amount: amount * 100, // SAR 257.58
      description: 'Room Rental',
      metadata: {},
      applePay: ApplePayConfig(merchantId: 'merchant.com.rentvaea', label: 'VAEA'),
    );
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ApplePay(
            config: moyasarPaymentConfig,
            onPaymentResult: onPaymentResult,
          ),
          const Text("or"),
          CreditCard(
            locale:  (AppLocalizations.of(context)!.localeName == "ar")
              ? Localization.ar()
              : Localization.en(),
            config: moyasarPaymentConfig,
            onPaymentResult: onPaymentResult,
          )
        ],
      ),
    );
  }


  /// It handles the event of receiving payment
  void onPaymentResult(result) {
    if (result is PaymentResponse) {
      switch (result.status) {
        case PaymentStatus.paid:
          handleSubmit(PaymentProviderEnum.moyasar, result.id);
          break;
        case PaymentStatus.failed:
        // handle failure.
          break;
      }
    }
  }


}