import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StateProviderAutoDispose extends ConsumerWidget {
  const StateProviderAutoDispose({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myNumber = ref.watch(providerGetNumberForAutoDispose);
    return Scaffold(
      body: Center(
          child: Text(
        myNumber.toString(),
        style: TextStyle(fontSize: 50),
      )),
    );
  }
}

//Burada StateProvider' dan sonra autoDispose kullanırsak gideceğimiz sayfadan geri döndüğümüzde o sayfa dispose edilir ve geri gelip tekrar
//gittiğimizde random sayı tekrar oluşur fakat autoDispose kullanmazsak random sayı sayfaya giderken oluşturduğumuz sayı kalır yani
//sayfa renderlanmaz ve memory leak olur.

final providerGetNumberForAutoDispose = StateProvider.autoDispose(
  (ref) {
    Random random = Random();
    return random.nextInt(100);
  },
);
