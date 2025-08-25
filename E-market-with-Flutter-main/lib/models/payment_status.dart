enum PaymentStatus {
  // ignore: constant_identifier_names
  PENDING,
  // ignore: constant_identifier_names
  COMPLETED,
  // ignore: constant_identifier_names
  FAILED,
  // ignore: constant_identifier_names
  REFUNDED,
  // ignore: constant_identifier_names
  CANCELLED
}

extension PaymentStatusExtension on PaymentStatus {
  String get displayName {
    switch (this) {
      case PaymentStatus.PENDING:
        return "Pending";
      case PaymentStatus.COMPLETED:
        return "Completed";
      case PaymentStatus.FAILED:
        return "Failed";
      case PaymentStatus.REFUNDED:
        return "Refunded";
      case PaymentStatus.CANCELLED:
        return "Cancelled";
    }
  }

  static PaymentStatus fromString(String value) {
    return PaymentStatus.values.firstWhere(
      (e) => e.toString().split('.').last.toUpperCase() == value.toUpperCase(),
      orElse: () => PaymentStatus.PENDING,
    );
  }
}
