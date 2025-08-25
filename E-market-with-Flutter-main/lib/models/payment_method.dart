enum PaymentMethod {
  CASH,
  CARD,
  BANK_TRANSFER,
  ONLINE,
  CASH_ON_DELIVERY
}

extension PaymentMethodExtension on PaymentMethod {
  String get displayName {
    switch (this) {
      case PaymentMethod.CASH:
        return "Cash";
      case PaymentMethod.CARD:
        return "Card";
        case PaymentMethod.CASH_ON_DELIVERY:
        return "CASH ON DELIVERY";
      case PaymentMethod.BANK_TRANSFER:
        return "Bank Transfer";
      case PaymentMethod.ONLINE:
        return "Online";
    }
  }

  static PaymentMethod fromString(String value) {
    return PaymentMethod.values.firstWhere(
      (e) => e.toString().split('.').last.toUpperCase() == value.toUpperCase(),
      orElse: () => PaymentMethod.CASH,
    );
  }
}
