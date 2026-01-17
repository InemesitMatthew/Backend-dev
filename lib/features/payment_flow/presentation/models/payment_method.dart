enum PaymentMethod { card, interac }

extension PaymentMethodText on PaymentMethod {
  String get label {
    switch (this) {
      case PaymentMethod.card:
        return 'Credit/Debit Card';
      case PaymentMethod.interac:
        return 'Interac e-Transfer';
    }
  }
}
