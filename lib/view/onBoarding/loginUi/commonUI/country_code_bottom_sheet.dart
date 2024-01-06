import 'package:country_state_city/utils/country_utils.dart';
import 'package:flutter/material.dart';

class CountryCodeBottomSheet extends StatefulWidget {
  const CountryCodeBottomSheet({super.key});

  // late final Future countries;

  @override
  State<CountryCodeBottomSheet> createState() => _CountryCodeBottomSheetState();
}

class _CountryCodeBottomSheetState extends State<CountryCodeBottomSheet> {
  // Future<List<Country>>? countries;
  late final Future countries = getAllCountries();
  // Future<List<Country>?> getList() async {
  // countries = await getAllCountries();
  // return countries;
  // if (_keyword.isEmpty) {
  //   return countries;
  // } else {
  //   return countries
  //       ?.where((element) =>
  //           element.name.toLowerCase().contains(_keyword.toLowerCase()))
  //       .toList();
  // }
  // }

  @override
  void initState() {
    super.initState();
    // countries = getAllCountries();
  }

  // String _keyword = "";

  @override
  Widget build(BuildContext context) {
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
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: SizedBox(
                    height: 36,
                    child: TextField(
                      maxLines: 1,
                      textAlignVertical: TextAlignVertical.center,
                      style: TextStyle(
                        color: Color(0xFF6B6B6B),
                        fontSize: 14,
                        fontFamily: 'Space Grotesk',
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
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
                      // onChanged: (value) {
                      //   setState(() {});
                      // },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.zero,
                  child: FutureBuilder(
                    future: countries,
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return const CircularProgressIndicator();
                        default:
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (snapshot.hasData) {
                            return ListView.builder(
                              // addAutomaticKeepAlives: true,
                              shrinkWrap: true,
                              itemCount: snapshot.data?.length ?? 0,
                              itemBuilder: (context, index) {
                                final countryList = snapshot.data;
                                return Card(
                                  color: Colors.transparent,
                                  elevation: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
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
                              },
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                      }
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
}
