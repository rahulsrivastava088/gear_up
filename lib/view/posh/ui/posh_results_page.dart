import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gear_up/utils/uiUtils/big_button.dart';
import 'package:gear_up/project/routes/custom_navigator.dart';
import 'package:gear_up/view/posh/viewmodel/posh_viewmodel.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class PoshResultsScreen extends StatefulWidget {
  const PoshResultsScreen({super.key});

  @override
  State<PoshResultsScreen> createState() => _PoshResultsScreen();
}

class _PoshResultsScreen extends State<PoshResultsScreen> {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<PoshViewModel>(context);
    return Scaffold(
      appBar: appBar(context, model),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headerText(model),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              poshImage(),
              const SizedBox(height: 36),
              const Text(
                'Congratulations!',
                style: TextStyle(
                  color: Color(0xFF32F514),
                  fontSize: 20,
                  fontFamily: 'General Sans',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                'You’ve earned a POSH badge',
                style: TextStyle(
                  color: Color(0xFFCBCBCB),
                  fontSize: 14,
                  fontFamily: 'Space Grotesk',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 32)
            ],
          ),
          Container(
            width: double.infinity,
            height: 200,
            margin: const EdgeInsets.symmetric(horizontal: 24),
            padding: const EdgeInsets.all(20),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: const Color(0xFF1E1E1E),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '8 Correct Answers ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'General Sans',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'out of 10',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Space Grotesk',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.only(left: 2, right: 2),
                  child: SliderTheme(
                    data: SliderThemeData(
                      trackHeight: 6,
                      trackShape: const RectangularSliderTrackShape(),
                      activeTrackColor: Colors.white,
                      inactiveTrackColor: Colors.grey,
                      thumbColor: Colors.white,
                      overlayShape: SliderComponentShape.noThumb,
                      thumbShape:
                          const RoundSliderThumbShape(enabledThumbRadius: 8),
                    ),
                    child: Slider(
                      // divisions: 10,
                      min: 1,
                      max: 10,
                      value: 8,
                      onChanged: (value) {
                        setState(() {
                          // selectedDistance = value;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Icon(
                      Icons.info_outlined,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'A minimum score of 8 answers required to earn a POSH Badge',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: 'Space Grotesk',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding:
                const EdgeInsets.only(top: 18, left: 24, right: 24, bottom: 24),
            child: CustomBigButtonLight(
              onTap: () {
                CustomNavigationHelper.router
                    .go(CustomNavigationHelper.myProfilePath);
              },
              text: 'Go to Profile',
            ),
          )
        ],
      ),
    );
  }

  Widget poshImage() {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 28),
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: SvgPicture.asset(
          'assets/posh/ic_posh_badge.svg',
          height: 150,
        ),
      ),
    );
  }

  Container headerText(PoshViewModel model) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      child: const Text(
        'Results',
        style: TextStyle(
          color: Colors.white,
          fontSize: 28,
          fontFamily: 'General Sans',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context, PoshViewModel model) {
    return AppBar(
      centerTitle: false,
      automaticallyImplyLeading: false,
      title: InkWell(
        onTap: () {
          if (context.canPop()) context.pop();
        },
        child: Container(
          padding: const EdgeInsets.only(top: 8, left: 8, right: 12, bottom: 8),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: Color(0xFF333333)),
              borderRadius: BorderRadius.circular(80),
            ),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.chevron_left, color: Colors.white),
              SizedBox(width: 8),
              Text(
                'Back',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: 'Space Grotesk',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
