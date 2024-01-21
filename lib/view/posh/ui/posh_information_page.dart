import 'package:flutter/material.dart';
import 'package:gear_up/colors/colors.dart';
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
          Container(
            margin: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: ShapeDecoration(
                      color: cardBgColorLight,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    padding: const EdgeInsets.only(
                        left: 24, right: 24, bottom: 24, top: 24),
                    child: const Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: []),
                  ),
                ],
              ),
            ),
          ),
        ],
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
      title: InkWell(
        onTap: () {
          // if()
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
