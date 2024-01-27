import 'package:flutter/material.dart';
import 'package:gear_up/colors/colors.dart';
import 'package:gear_up/utils/uiUtils/big_button.dart';
import 'package:gear_up/view/bottomNavigation/custom.dart';
import 'package:gear_up/view/posh/viewmodel/posh_viewmodel.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class PoshAssessmentScreen extends StatefulWidget {
  const PoshAssessmentScreen({super.key});

  @override
  State<PoshAssessmentScreen> createState() => _PoshAssessmentScreen();
}

class _PoshAssessmentScreen extends State<PoshAssessmentScreen> {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<PoshViewModel>(context);
    return Scaffold(
      appBar: appBar(context, model),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headerText(model),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: model.questions.length,
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 8);
              },
              itemBuilder: (context, index) {
                return Container(
                    margin: const EdgeInsets.only(left: 24, right: 24),
                    width: double.infinity,
                    decoration: ShapeDecoration(
                      color: cardBgColorLight,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    padding:
                        const EdgeInsets.only(left: 24, right: 24, top: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                indexText(index),
                                Expanded(child: questionText(model, index)),
                              ],
                            ),
                            optionsWidget(model, index),
                          ],
                        ),
                      ],
                    ));
              },
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 18, left: 24, right: 24, bottom: 24),
            child: CustomBigButtonLight(
              onTap: () {
                CustomNavigationHelper.router
                    .push(CustomNavigationHelper.poshResultsPath);
              },
              text: 'Next',
            ),
          )
        ],
      ),
    );
  }

  Widget optionsWidget(PoshViewModel model, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          onTap: () {},
          visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
          contentPadding: EdgeInsets.zero,
          title: Transform.translate(
            offset: const Offset(-16, 0),
            child: const Text(
              'True',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontFamily: 'Space Grotesk',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          leading: Radio(
            activeColor: Colors.white,
            value: true,
            groupValue: null,
            onChanged: (value) {},
          ),
        ),
        ListTile(
          onTap: () {},
          visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
          contentPadding: EdgeInsets.zero,
          title: Transform.translate(
            offset: const Offset(-16, 0),
            child: const Text(
              'False',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontFamily: 'Space Grotesk',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          leading: Radio(
            activeColor: Colors.white,
            value: true,
            groupValue: null,
            onChanged: (value) {},
          ),
        ),
      ],
    );
  }

  Text questionText(PoshViewModel model, int index) {
    return Text(
      model.questions[index],
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontFamily: 'General Sans',
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Text indexText(int index) {
    return Text(
      "${index + 1}.  ",
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontFamily: 'General Sans',
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Container headerText(PoshViewModel model) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      child: const Text(
        'Assessment',
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
