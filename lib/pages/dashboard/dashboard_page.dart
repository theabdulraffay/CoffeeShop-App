import 'package:coffeeshopapp/bloc/movie/bloc/coffee_bloc.dart';
import 'package:coffeeshopapp/pages/dashboard/widgets/modal_bottom_sheet.dart';
import 'package:coffeeshopapp/pages/dashboard/widgets/product_tile.dart';
import 'package:coffeeshopapp/pages/dashboard/widgets/scroll_tile.dart';
import 'package:coffeeshopapp/utils/constants.dart';
import 'package:coffeeshopapp/utils/enums.dart';
import 'package:coffeeshopapp/utils/font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String dropdownValue = 'Bilzen, Tanjungblai';
  final TextEditingController _textEditingController = TextEditingController();

  List<String> scrollTileItems = [
    "Cappuccino",
    "Machiato",
    "Latte",
    "Americano"
  ];
  final ScrollController _outerController = ScrollController();
  final ScrollController _innerController = ScrollController();

  bool isSticky = false;

  @override
  void initState() {
    super.initState();
    context.read<CoffeeBloc>().add(const FetchCoffeeEvent());
  }

  @override
  void dispose() {
    _outerController.dispose();
    _innerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final statusBarHeight = MediaQuery.of(context).padding.top;

    // Grid view count for products
    int gridCount() {
      if (screenWidth > 160) {
        return (screenWidth ~/ 150).toInt();
      }
      return 1;
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryTapColor,
        onPressed: () {
          showModalBottomSheet<void>(
              context: context,
              builder: (context) {
                return CustomModalButtomSheet();
              });
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: statusBarHeight),
            // Personal Detials
            Row(
              children: [
                Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Location
                    Font(
                      text: "Location",
                      fontWeight: "Regular",
                      fontSize: 12,
                      color: secondaryTextColor,
                    ),

                    // Dropdown menu
                    DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        icon: SvgPicture.asset('assets/icons/arrow-down.svg'),
                        focusColor: backgroundColor,
                        borderRadius: BorderRadius.circular(10),
                        value: dropdownValue,
                        items: <String>[
                          'Bilzen, Tanjungblai',
                          'Los Angeles, CA',
                          'New York, NY',
                          'London, England'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Font(
                              text: value,
                              fontSize: 14,
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
                      ),
                    )
                  ],
                ),
                const Spacer(),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    'assets/images/person.png',
                    fit: BoxFit.cover,
                    width: 45,
                    height: 45,
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(0),
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: const Color(0xff313131),
                        borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 5, left: 5, right: 7, bottom: 5),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: SvgPicture.asset(
                              'assets/icons/search-unfilled.svg',
                              color: backgroundColor,
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: _textEditingController,
                              //autofocus: false,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Search coffee",
                                contentPadding: const EdgeInsets.all(15),
                                hintStyle: GoogleFonts.sora(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: secondaryTextColor,
                                ),
                              ),
                              style: GoogleFonts.sora(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                              onChanged: (value) {
                                // Handle text changes
                              },
                            ),
                          ),
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: SvgPicture.asset(
                                  'assets/icons/customize.svg',
                                  color: primaryTextColorLight,
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          'assets/images/offer.png',
                          fit: BoxFit.cover,
                          width: screenWidth,
                          height: 170,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 23, vertical: 13),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: const Color(0xffEd5151),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: const EdgeInsets.all(6),
                                child: Font(
                                  text: "Promo",
                                  fontSize: 14,
                                  color: primaryTextColorLight,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: 200,
                              child: Font(
                                text: "Buy one get one Free",
                                fontSize: 32,
                                color: primaryTextColorLight,
                                backgroundColor: primaryTextColorDark,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    height: 40,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: scrollTileItems.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(width: 10);
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return ScrollTile(tileText: scrollTileItems[index]);
                      },
                    ),
                  ),
                  const SizedBox(height: 25),
                  BlocBuilder<CoffeeBloc, CoffeeState>(
                      builder: (context, state) {
                    if (state.status == Status.loading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state.status == Status.error) {
                      return Center(
                          child: Font(
                              text: state.message,
                              fontSize: 16,
                              color: Colors.red));
                    } else {
                      var allProducts = state.products;
                      return MasonryGridView.count(
                          // key: UniqueKey(),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(0),
                          crossAxisCount: gridCount(),
                          crossAxisSpacing: 15, //
                          mainAxisSpacing: 15,
                          itemCount: allProducts.length,
                          itemBuilder: (context, index) {
                            final product = allProducts[index];
                            return ProductTile(product: product);
                          });
                    }
                  })
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            blurRadius: 25,
            offset: const Offset(0, -10),
            spreadRadius: 0,
            color: const Color(0xffE4E4E4).withOpacity(.25),
          )
        ]),
        child: ClipRRect(
          // borderRadius: BorderRadius.circular(25),
          child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: primaryColor,
            onTap: (int index) {},
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/home-filled.svg',
                  color: primaryColor,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/heart-unfilled.svg',
                  color: secondaryTextColor,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/icons/bag-filled.svg',
                    color: secondaryTextColor),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/icons/notification-filled.svg',
                    color: secondaryTextColor),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
