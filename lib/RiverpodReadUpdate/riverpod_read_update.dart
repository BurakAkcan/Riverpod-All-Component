import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReadUpdateScreen extends ConsumerWidget {
  const ReadUpdateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int myNumber = ref.watch(getNumberProvider);
    int newNumber = ref.watch(newProvider);
    return Scaffold(
      body: Center(
          child: Text(
        myNumber.toString(),
        style: TextStyle(fontSize: 50),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
//Burada state yapımıza başka bir state ekledğimizi düşünelim bu şekilde yapacaktık
          /* ref.read(getNumberProvider.notifier).state =
              ref.read(getNumberProvider.notifier).state + 1; */
////////////////////////////////////////////////////////////////////////////////////////////
//Yukarıda yazdığımız yapının yanına update metodu kullanarak bu işi daha hızlıca çözebiliriz

/* ref.read(getNumberProvider.notifier).update(
                (prevState) => prevState+1,
              ); */

          ref.read(getNumberProvider.notifier).update(
                (prevState) => newNumber,
              );
        },
      ),
    );
  }
}

final getNumberProvider = StateProvider<int>((ref) => 0);

final newProvider = StateProvider<int>(
  (ref) => 23,
);
