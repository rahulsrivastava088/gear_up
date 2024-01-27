import 'package:flutter/material.dart';
import 'package:gear_up/colors/colors.dart';
import 'package:gear_up/utils/uiUtils/big_button.dart';
import 'package:gear_up/view/bottomNavigation/custom.dart';
import 'package:gear_up/view/posh/viewmodel/posh_viewmodel.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class PoshInformationScreen extends StatefulWidget {
  const PoshInformationScreen({super.key});

  @override
  State<PoshInformationScreen> createState() => _PoshInformationScreenState();
}

class _PoshInformationScreenState extends State<PoshInformationScreen> {
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
            child: Container(
              margin: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
              width: double.infinity,
              decoration: ShapeDecoration(
                color: cardBgColorLight,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: model.topicText[model.selectedIndex].length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          indexText(index),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                topicText(model, index),
                                summaryText(model, index),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Column(children: [
                    SizedBox(height: 20),
                    Divider(height: .5, color: Color(0xFF333333)),
                    SizedBox(height: 20),
                  ]);
                },
              ),
            ),
          ),
          // const Spacer(),
          Padding(
            padding:
                const EdgeInsets.only(top: 18, left: 24, right: 24, bottom: 24),
            child: CustomBigButtonLight(
              onTap: () {
                if (model.selectedIndex == model.pageIndexes.length - 1) {
                  CustomNavigationHelper.router
                      .push(CustomNavigationHelper.poshAssessmentPath);
                } else {
                  model.moveToNextPage();
                }
              },
              text: 'Next',
            ),
          )
        ],
      ),
    );
  }

  Text summaryText(PoshViewModel model, int index) {
    return Text(
      model.summaryText[model.selectedIndex][index],
      style: const TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontFamily: 'Space Grotesk',
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Text topicText(PoshViewModel model, int index) {
    return Text(
      model.topicText[model.selectedIndex][index],
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
      child: Text(
        model.getHeaderText(),
        style: const TextStyle(
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
          if (model.selectedIndex == 0) {
            if (context.canPop()) context.pop();
          } else {
            model.moveToPreviousPage();
          }
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
