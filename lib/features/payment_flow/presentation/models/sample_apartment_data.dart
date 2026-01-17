import 'package:backend_dev/core/core.dart';

import 'apartment_details.dart';

const ApartmentDetails sampleApartmentDetails = ApartmentDetails(
  name: 'Lumen House',
  pricePerMonth: 'C\$400/month',
  address: '12 Ontario Dr, Toronto, ON M6K 3C3, Canada.',
  rating: 4.5,
  reviewCount: 67,
  description:
      'With its spacious living area, this quaint three-bedroom, two-bath apartment is perfect for hosting friends.',
  features: [
    ApartmentFeature(label: '2 Bathroom', iconAsset: Assets.twoBathsIcon),
    ApartmentFeature(label: '4 Bedroom', iconAsset: Assets.fourBedsIcon),
    ApartmentFeature(label: 'Wifi', iconAsset: Assets.wifiIcon),
    ApartmentFeature(label: 'Washer', iconAsset: Assets.washerIcon),
    ApartmentFeature(label: 'Pet Friendly', iconAsset: Assets.petIcon),
    ApartmentFeature(label: 'No Smoking', iconAsset: Assets.smokingIcon),
  ],
  imageUrl: Assets.apartmentBg,
  mapUrl: Assets.mapIcon,
  depositAmountText: 'C\$30',
);
