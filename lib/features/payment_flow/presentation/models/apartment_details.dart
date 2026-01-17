class ApartmentDetails {
  const ApartmentDetails({
    required this.name,
    required this.pricePerMonth,
    required this.address,
    required this.rating,
    required this.reviewCount,
    required this.description,
    required this.features,
    required this.imageUrl,
    required this.mapUrl,
    required this.depositAmountText,
  });
  final String name;
  final String pricePerMonth;
  final String address;
  final double rating;
  final int reviewCount;
  final String description;
  final List<ApartmentFeature> features;
  final String imageUrl;
  final String mapUrl;
  final String depositAmountText;
}

class ApartmentFeature {
  const ApartmentFeature({required this.label, required this.iconAsset});
  final String label;
  final String iconAsset;
}
