import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamro_futsal/controllers/futsal_controller.dart';
import 'package:hamro_futsal/model/futsal.dart';
import 'package:hamro_futsal/widget/custom_search_field.dart';
import 'package:hamro_futsal/widget/futsal_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<FutsalController>(builder: (controller) {
          return Column(
            children: [
              CustomSearchField(onChanged: (val) {
                controller.search(val);
              }),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                      children: controller.filteredFutsals
                          .map((Futsal futsal) => FutsalCard(futsal: futsal))
                          .toList()),
                ),
              ),
            ],
          );
        }),
      ),
    ));
  }
}
