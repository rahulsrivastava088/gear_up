import 'package:country_state_city/models/country.dart';
import 'package:country_state_city/utils/country_utils.dart';
import 'package:flutter/material.dart';
import 'package:gear_up/view/onBoarding/viewModel/on_boarding_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CountryCodeBottomSheet extends StatefulWidget {
  const CountryCodeBottomSheet({super.key});

  @override
  State<CountryCodeBottomSheet> createState() => _CountryCodeBottomSheetState();
}

class _CountryCodeBottomSheetState extends State<CountryCodeBottomSheet> {
  Future? countries;

  @override
  void initState() {
    super.initState();
    countries = getAllCountries().then((list) {
      originalList = list;
      filteredList.addAll(originalList);
      setState(() {});
    });
  }

  final searchTextEditingController = TextEditingController();
  List<Country> originalList = [];
  List<Country> filteredList = [];

  void filterList(String query) {
    filteredList.clear();
    if (query.isEmpty) {
      filteredList.addAll(originalList);
    } else {
      for (var item in originalList) {
        if (item.name.toLowerCase().contains(query.toLowerCase())) {
          filteredList.add(item);
        }
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<OnBoardingViewModel>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 72),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: double.infinity,
            padding:
                const EdgeInsets.only(top: 24, bottom: 16, left: 24, right: 24),
            decoration: const ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(
                    top: 16,
                    bottom: 8,
                  ),
                  child: Text(
                    'Country/Region',
                    style: TextStyle(
                      color: Color(0xFF242424),
                      fontSize: 24,
                      fontFamily: 'General Sans',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: SizedBox(
                    height: 36,
                    child: TextField(
                      onChanged: (query) {
                        filterList(query);
                      },
                      controller: searchTextEditingController,
                      maxLines: 1,
                      textAlignVertical: TextAlignVertical.center,
                      style: const TextStyle(
                        color: Color(0xFF6B6B6B),
                        fontSize: 14,
                        fontFamily: 'Space Grotesk',
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.black,
                          size: 20,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        hintText: 'Search',
                        hintStyle: TextStyle(color: Color(0xFF6B6B6B)),
                        filled: true,
                        fillColor: Color(0xFFEEEEEE),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 700,
                  // padding: EdgeInsets.zero,
                  child: ListView.builder(
                    itemCount: filteredList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            model.selectedCountryCode =
                                filteredList[index].phoneCode;
                            model.selectedCountryName =
                                filteredList[index].name;
                            model.notifyListeners();
                            context.pop();
                          },
                          child: selectCountryCardWidget(
                              filteredList, index, model));
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Card selectCountryCardWidget(
      countryList, int index, OnBoardingViewModel model) {
    return Card(
      color: model.selectedCountryName == countryList[index].name
          ? const Color(0xFFEAF3F9)
          : Colors.transparent,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            model.selectedCountryName == countryList[index].name
                ? const Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.black,
                        size: 20,
                      ),
                      SizedBox(width: 6)
                    ],
                  )
                : Container(),
            Text(
              countryList?[index].name ?? "-",
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Space Grotesk',
                  fontWeight: FontWeight.w400),
            ),
            const Spacer(),
            Text(
              countryList?[index].phoneCode ?? "-",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'Space Grotesk',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
