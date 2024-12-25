import 'package:coffeeshopapp/models/order_model.dart';
import 'package:coffeeshopapp/models/product_model.dart';
import 'package:coffeeshopapp/pages/detail/widgets/size_tile.dart';
import 'package:coffeeshopapp/pages/order/order_page.dart';
import 'package:coffeeshopapp/utils/constants.dart';
import 'package:coffeeshopapp/utils/font.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class DetailPage extends StatefulWidget {
  DetailPage({super.key, required this.product});

  ProductModel product;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isReadMoreTapped = false;
  String description = ''; // access prodcut description here

  @override
  Widget build(BuildContext context) {
    bool isLargeDescription() {
      if (widget.product.productDescription.length >= 150) {
        return true;
      }
      return false;
    }

    // isReadMoreTapped = _isLargeDescription() ? false : true;
    String? description = isReadMoreTapped
        ? widget.product.productDescription
        : isLargeDescription()
            ? '${widget.product.productDescription.substring(0, 147)}...'
            : widget.product.productDescription;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Colors.white,
        // extendBodyBehindAppBar: true,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: AppBar(
                surfaceTintColor: Colors.transparent,
                backgroundColor: Colors.white,
                leading: IconButton(
                  icon: SvgPicture.asset('assets/icons/back-arrow.svg'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                actions: [
                  IconButton(
                    icon: SvgPicture.asset('assets/icons/heart-unfilled-1.svg'),
                    onPressed: () {
                      // Add your onPressed logic here
                    },
                  ),
                ],
                title: Font(
                  text: "Detail",
                  fontSize: 18,
                ),
                centerTitle: true, // Aligns the title in the center
              ),
            )),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/images/${widget.product.productImage}',
                    width: screenWidth,
                    height: 225,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                Font(
                  text: widget.product.productName,
                  fontSize: 20,
                ),
                const SizedBox(height: 5),
                Font(
                  text: widget.product.productTagLine,
                  fontSize: 12,
                  fontWeight: "Regular",
                  color: secondaryTextColor,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/star.svg',
                      height: 20,
                    ),
                    const SizedBox(width: 5),
                    Font(text: '${widget.product.productRating}'),
                    const SizedBox(width: 5),
                    Font(
                      text: "(230)",
                      fontSize: 12,
                      color: secondaryTextColor,
                      fontWeight: "Regular",
                    ),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: SvgPicture.asset(
                          'assets/icons/bean.svg',
                          width: 28,
                          height: 28,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: SvgPicture.asset(
                          'assets/icons/milk.svg', // icon not working
                          width: 24,
                          height: 24,
                          color: primaryColor,
                        ),
                      ),
                    )
                  ],
                ),
                const Divider(
                  height: 40,
                  color: borderColor,
                ),
                Font(text: "Description"),
                const SizedBox(height: 10),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: description,
                          style: GoogleFonts.sora(
                              fontSize: 14,
                              color: secondaryTextColor,
                              fontWeight: FontWeight.w400)),
                      !isReadMoreTapped && isLargeDescription()
                          ? TextSpan(
                              text: "Read More",
                              style: GoogleFonts.sora(
                                  fontSize: 14,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  setState(() {
                                    print('yes');
                                    isReadMoreTapped = true;
                                  });
                                })
                          : const TextSpan(),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Font(text: "Size"),
                const SizedBox(height: 10),
                Row(
                  children: [
                    SizeTile(tileText: "S"),
                    const SizedBox(width: 10),
                    SizeTile(tileText: "M"),
                    const SizedBox(width: 10),
                    SizeTile(tileText: "L"),
                  ],
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            boxShadow: [
              BoxShadow(
                color: const Color(0xffE4E4E4).withOpacity(0.25),
                spreadRadius: 5,
                blurRadius: 24,
                offset: const Offset(0, -10), // changes position of shadow
              ),
            ],
          ),
          child: BottomAppBar(
            elevation: 0,
            height: 100,
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Font(
                      text: "Price",
                      color: secondaryTextColor,
                      fontSize: 14,
                      fontWeight: "Regular",
                    ),
                    const SizedBox(height: 5),
                    Font(
                      text: "\$${widget.product.productPrice}",
                      color: primaryColor,
                      fontSize: 18,
                    ),
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    bool isProductAlreadyInOrderList = orderList
                        .any((order) => order.product == widget.product);
                    // If the product is not already in the order list, add it
                    if (!isProductAlreadyInOrderList) {
                      orderList.add(
                          OrderModel(product: widget.product, orderAmount: 1));
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OrderPage()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 70, vertical: 19),
                      child: Font(
                        text: "Buy Now",
                        color: primaryTextColorLight,
                      ),
                    ),
                  ),
                )
              ]),
            ),
          ),
        ));
  }
}
