import 'package:backend_dev/core/core.dart';
import 'package:backend_dev/features/features.dart';

class ApartmentDetailsScreen extends StatefulWidget {
  const ApartmentDetailsScreen({
    super.key,
    this.details = sampleApartmentDetails,
  });
  final ApartmentDetails details;
  @override
  State<ApartmentDetailsScreen> createState() => _ApartmentDetailsScreenState();
}

class _ApartmentDetailsScreenState extends State<ApartmentDetailsScreen> {
  bool _isDescriptionExpanded = false;
  bool _isProcessingPayment = false;
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _mapSectionKey = GlobalKey();

  Future<void> _handleProceedToPayment() async {
    if (_isProcessingPayment) {
      return;
    }
    setState(() {
      _isProcessingPayment = true;
    });
    await Future<void>.delayed(const Duration(seconds: 2));
    if (!mounted) {
      return;
    }
    setState(() {
      _isProcessingPayment = false;
    });
    Navigator.of(context).push(
      CupertinoPageRoute<Widget>(
        builder: (BuildContext context) {
          return const PaymentMethodScreen();
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ApartmentDetails details = widget.details;
    final double heroHeight = context.h(358);
    final List<String> priceParts = details.pricePerMonth.split('/');
    final String priceAmount = priceParts.first;
    final String priceUnit = priceParts.length > 1
        ? '/${priceParts.sublist(1).join('/')}'
        : '';
    return CupertinoPageScaffold(
      backgroundColor: Palette.surface,
      child: Stack(
        children: [
          SafeArea(
            top: false,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    physics: const ClampingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Column(
                              children: [
                                Image.asset(
                                  details.imageUrl,
                                  height: heroHeight,
                                  width: .infinity,
                                  fit: .cover,
                                ),
                                SizedBox(height: context.h(50)),
                              ],
                            ),
                            Positioned(
                              top: context.h(290),
                              left: context.w(16),
                              right: context.w(16),
                              child: SectionCard(
                                child: Column(
                                  crossAxisAlignment: .start,
                                  children: [
                                    Row(
                                      crossAxisAlignment: .start,
                                      children: [
                                        Image.asset(
                                          Assets.dollarIcon,
                                          width: 35,
                                          height: 35,
                                          fit: .contain,
                                        ),
                                        context.horizontalSpace(10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: .start,
                                            children: [
                                              TextWidget(
                                                'Pay Security Deposit',
                                                fontSize: 14,
                                                fontWeight: .w600,
                                                letterSpacing: 0.1,
                                                textColor: Palette.textPrimary,
                                                fontFamily: AppFontFamily.inter,
                                              ),
                                              context.verticalSpace(4),
                                              InlineEmphasisText(
                                                prefix:
                                                    'To finalize your reservation, pay the ',
                                                emphasis:
                                                    details.depositAmountText,
                                                suffix:
                                                    ' security deposit. Funds are held securely.',
                                                fontFamily: AppFontFamily.geist,
                                                textColor: const Color(
                                                  0xFF1E1E1E,
                                                ).withValues(alpha: 0.6),
                                                emphasisColor: const Color(
                                                  0xFF1E1E1E,
                                                ).withValues(alpha: 0.85),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    context.verticalSpace(16),
                                    Align(
                                      alignment: .centerRight,
                                      child: Button(
                                        width: 156,
                                        height: 37,
                                        hasInfiniteWidth: false,
                                        title: 'Proceed to payment',
                                        fontSize: 12,
                                        isDisabled: _isProcessingPayment,
                                        onTap: _handleProceedToPayment,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        context.verticalSpace(16),
                        Padding(
                          padding: context.symmetric(horizontal: 16),
                          child: SectionCard(
                            child: Column(
                              crossAxisAlignment: .start,
                              children: [
                                TextWidget(
                                  details.name,
                                  fontSize: 18,
                                  fontWeight: .w600,
                                  letterSpacing: 0.1,
                                  textColor: Palette.black,
                                  fontFamily: AppFontFamily.inter,
                                ),
                                context.verticalSpace(10),
                                RichTextWidget(
                                  text: priceAmount,
                                  text2: priceUnit,
                                  fontFamily: AppFontFamily.geist,
                                  fontSize: 14,
                                  fontSize2: 12,
                                  fontWeight: .w500,
                                  fontWeight2: .w400,
                                  textColor: Palette.black2,
                                  textColor2: Palette.black2.withValues(
                                    alpha: 0.6,
                                  ),
                                  decoration2: TextDecoration.none,
                                ),
                                context.verticalSpace(10),
                                Row(
                                  children: [
                                    Image.asset(
                                      Assets.locationIcon,
                                      width: 16,
                                      height: 16,
                                      fit: .contain,
                                    ),
                                    context.horizontalSpace(4),
                                    Expanded(
                                      child: TextWidget(
                                        details.address,
                                        fontSize: 12,
                                        fontWeight: .w400,
                                        textColor: Palette.black2.withValues(
                                          alpha: 0.6,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                context.verticalSpace(11),
                                Row(
                                  children: [
                                    const Icon(
                                      CupertinoIcons.star_fill,
                                      color: Palette.warning,
                                      size: 14,
                                    ),
                                    context.horizontalSpace(4),
                                    Expanded(
                                      child: RichTextWidget(
                                        text: '${details.rating} ',
                                        text2:
                                            '(${details.reviewCount} Reviews)',
                                        textAlign: TextAlign.start,
                                        fontFamily: AppFontFamily.inter,
                                        fontSize: 14,
                                        fontSize2: 12,
                                        fontWeight: .w500,
                                        fontWeight2: .w500,
                                        textColor: Palette.black2,
                                        textColor2: Palette.black2.withValues(
                                          alpha: 0.6,
                                        ),
                                        decoration2: TextDecoration.none,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    context.horizontalSpace(8),
                                    GestureDetector(
                                      onTap: () {
                                        final BuildContext? targetContext =
                                            _mapSectionKey.currentContext;
                                        if (targetContext == null) {
                                          return;
                                        }
                                        Scrollable.ensureVisible(
                                          targetContext,
                                          duration: const Duration(
                                            milliseconds: 350,
                                          ),
                                          curve: Curves.easeInOut,
                                          alignment: 0.1,
                                        );
                                      },
                                      child: TextWidget.link(
                                        'See Google Location',
                                      ),
                                    ),
                                  ],
                                ),
                                context.verticalSpace(22),
                                TextWidget(
                                  'Description',
                                  fontSize: 14,
                                  fontWeight: .w500,
                                  letterSpacing: 0.1,
                                  textColor: Palette.textPrimary,
                                ),
                                context.verticalSpace(8),
                                TextWidget(
                                  details.description,
                                  fontSize: 12,
                                  fontWeight: .w400,
                                  textColor: Palette.black2.withValues(
                                    alpha: 0.6,
                                  ),
                                  maxLines: _isDescriptionExpanded ? null : 1,
                                  overflow: _isDescriptionExpanded
                                      ? null
                                      : .ellipsis,
                                ),
                                context.verticalSpace(4),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isDescriptionExpanded =
                                          !_isDescriptionExpanded;
                                    });
                                  },
                                  child: TextWidget.link(
                                    _isDescriptionExpanded
                                        ? 'read less'
                                        : 'read more',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        context.verticalSpace(16),
                        Padding(
                          key: _mapSectionKey,
                          padding: context.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: .start,
                            children: [
                              TextWidget(
                                'Features',
                                fontSize: 16,
                                fontWeight: .w500,
                                textColor: Palette.black,
                                fontFamily: AppFontFamily.geist,
                              ),
                              context.verticalSpace(10),
                              Wrap(
                                spacing: context.w(10),
                                runSpacing: context.h(12),
                                children: details.features
                                    .map(
                                      (ApartmentFeature feature) => SizedBox(
                                        width:
                                            (context.screenWidth -
                                                (context.w(16) * 2) -
                                                (context.w(12) * 2)) /
                                            3,
                                        child: FeatureChip(
                                          label: feature.label,
                                          iconAsset: feature.iconAsset,
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                        context.verticalSpace(16),
                        Padding(
                          padding: context.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: .start,
                            children: [
                              TextWidget(
                                'Location',
                                fontSize: 16,
                                fontWeight: .w500,
                                textColor: Palette.black,
                                fontFamily: AppFontFamily.geist,
                              ),
                              context.verticalSpace(10),
                              ClipRRect(
                                borderRadius: .circular(16),
                                child: Image.asset(
                                  details.mapUrl,
                                  height: 315,
                                  width: .infinity,
                                  fit: .cover,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                BottomActionContainer(
                  child: Row(
                    children: [
                      Expanded(
                        child: Button(title: 'Edit application', onTap: () {}),
                      ),
                      context.horizontalSpace(10),
                      Expanded(
                        child: Button(
                          title: 'Withdraw',
                          onTap: () {},
                          filled: false,
                          color: Palette.border2.withValues(alpha: 0.15),
                          textColor: Palette.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                context.verticalSpace(12),
              ],
            ),
          ),
          LoadingOverlay(isVisible: _isProcessingPayment),
        ],
      ),
    );
  }
}
