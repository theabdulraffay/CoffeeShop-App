import 'package:coffeeshopapp/bloc/movie/bloc/barrel.dart';
import 'package:coffeeshopapp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../bloc/movie/bloc/coffee_bloc.dart';

class CustomModalButtomSheet extends StatelessWidget {
  CustomModalButtomSheet({super.key});
  final TextEditingController nameController = TextEditingController();
  final TextEditingController tagController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 30,
      ),
      child: Column(
        spacing: 20,
        children: [
          customTextFormField(message: 'Name', controller: nameController),
          customTextFormField(message: 'TagLine', controller: tagController),
          customTextFormField(message: 'Price', controller: priceController),
          BlocBuilder<CoffeeBloc, CoffeeState>(
            builder: (context, state) {
              return ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(primaryTapColor)),
                onPressed: () {
                  var prod = ProductModel(
                    productName: nameController.text,
                    productTagLine: tagController.text,
                    productPrice: double.parse(priceController.text),
                  );
                  context.read<CoffeeBloc>().add(AddnewProductEvent(prod));
                  Navigator.pop(context);
                },
                child: state.status == Status.loading
                    ? const CircularProgressIndicator()
                    : const Text(
                        'Add Product',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
              );
            },
          ),
        ],
      ),
    );
  }
}

TextFormField customTextFormField(
    {required String message, required TextEditingController controller}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      hintText: message,
      hintStyle: GoogleFonts.sora(),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}
