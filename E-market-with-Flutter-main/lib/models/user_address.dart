class UserAddress {
  String fullName;
  String phoneNumber;
  String addressLine1;
  String? addressLine2;
  String city;
  String stateOrProvince;
  String postalCode;
  String country;
  String addressType;
  bool isDefault;
  int userId;

  UserAddress({
    required this.fullName,
    required this.phoneNumber,
    required this.addressLine1,
    this.addressLine2,
    required this.city,
    required this.stateOrProvince,
    required this.postalCode,
    required this.country,
    required this.addressType,
    this.isDefault = true,
    required this.userId,
  });

  Map<String, dynamic> toJson() => {
        'fullName': fullName,
        'phoneNumber': phoneNumber,
        'addressLine1': addressLine1,
        'addressLine2': addressLine2,
        'city': city,
        'stateOrProvince': stateOrProvince,
        'postalCode': postalCode,
        'country': country,
        'addressType': addressType,
        'isDefault': isDefault,
        'userId': userId,
      };
}
