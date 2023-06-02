
/// It represents the payment provider that are moyasar and tabby
enum PaymentProviderEnum {
  moyasar,
  tabby
}


/// It maps the backend data to this enum.
extension PaymentProviderEnumParser on PaymentProviderEnum {
  /// It handles the parsing out of backend string
  static PaymentProviderEnum parse(String paymentProviderStr) {
    if (paymentProviderStr == "MOYASAR") {
      return PaymentProviderEnum.moyasar;
    } else {
      return PaymentProviderEnum.tabby;
    }
  }
}


/// It is used to map enum values to backend string
extension PaymentProviderEnumSerializer on PaymentProviderEnum {
  /// It serializes the enum value into backend string
  static String serialize(PaymentProviderEnum paymentProviderEnum) {
    if (paymentProviderEnum == PaymentProviderEnum.moyasar) {
      return "MOYASAR";
    } else {
      return "TABBY";
    }
  }
}