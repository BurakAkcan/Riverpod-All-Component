import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_all_components/main.dart';

//eğer stateless wdiget kullanacaksak ve bir manangement yöntemi kulllanıyorsak riverpod da burada ConsumerWidget kullanabiliriz.
class HomeView extends ConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String myStringProvider = ref.watch(myBasicProvider);
    //burada değişkenimizi görmek için int bir değer tanımloıyoruz ve bunu text içerisinde göreceğiz
    final int myIntStateValue = ref.watch(myStateProvider);

    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(myStringProvider),
          Text(myIntStateValue.toString()),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Durumu güncellemek için oluşturduğum StateProvider'ın durumunu izleyip tekrar state diyerek durumunu güncelleştiriyoruz
          ref.read(myStateProvider.state).state++;
        },
      ),
    );
  }
}
