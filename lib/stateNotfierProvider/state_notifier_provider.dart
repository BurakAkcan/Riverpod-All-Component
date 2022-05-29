import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_all_components/main.dart';

class StateNotifierProviderScreen extends ConsumerWidget {
  const StateNotifierProviderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Random random = Random();
    final listOfString = ref.watch(myStateProviderNotifier) as List;

    // ref.listen() metodu hiçbir şekilde initstate ya da dispose gibi life cyle içinde kullanamayız
    // ref.listen(myStateNotifierProvider(listOfPreviosState,listOfNewState ){}) bu şekilde bir high order funcition yapısı içinde kullanablirz
//Liste döneceği için List diye generic ataması yaptık
//Bu calback fonk. sayfa tekrardan render yapmadan önce işlem yapacaksak kullanışlıdır. Örneğin snacbar kullanırken
    ref.listen<List>(
      myStateProviderNotifier,
      (prevListOfState, newListOfState) {
        debugPrint('this function has been called');

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Listeye yeni eleman eklendi'),
        ));
      },
    );
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...listOfString
              .map(
                (e) => Text(e),
              )
              .toList(),
        ],
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref
              .read(myStateProviderNotifier.notifier)
              .addString('Hi ${random.nextInt(10)}');
        },
      ),
    );
  }
}

class myNotifier extends StateNotifier<List<String>> {
//Süperine boş  bir liste verdik
//Buraya initial olmasını beklediğimiz durumu yapabiliriz
  myNotifier() : super([]);

  void addString(String stringToAdd) {
    state = [...state, stringToAdd];
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// 3 noktanın anlamı listeye bir liste eklerken kullanırız
var a = [0, 1, 2, 3, 4];
var b = [6, 7, 8, 9];
var c = [...a, 5, ...b];

//   print(c);  // prints: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

class myNotifier1 extends StateNotifier<List<String>> {
//Eğer bu şekildeyse sayfamda önce b harfi gösterilir butona tıklandığı an ekranda a b d yazar  baştaki  b harfi gider
  myNotifier1() : super(['b']);

  void addString(String stringToAdd) {
    state = [
      ...['a', 'b', 'd']
    ];
  }
}

class myNotifier2 extends StateNotifier<List<String>> {
//Ekrandaki çıktısı a b s Hiprovider şeklinde olur yukarıdan aşağıya
  myNotifier2() : super(['b']);

  void addString(String stringToAdd) {
    state = ['a', 'b', 's', stringToAdd];
  }
}
