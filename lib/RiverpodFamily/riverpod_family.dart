import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_all_components/main.dart';

class RiverpodFamilyScreen extends ConsumerWidget {
  const RiverpodFamilyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //Family kullandığımız için enum yapısını watch metodunun içine ekliyoruz
    int myNumber = ref.watch(getNumber(TypeOfNumber.medium));
    return Scaffold(
      body: Center(
          child: Text(
        myNumber.toString(),
        style: const TextStyle(fontSize: 40),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
    );
  }
}
