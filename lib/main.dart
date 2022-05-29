import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_all_components/FutureProvider/future_provider.dart';
import 'package:riverpod_all_components/RefSelect/ref_select.dart';
import 'package:riverpod_all_components/RiverpodFamily/riverpod_family.dart';
import 'package:riverpod_all_components/RiverpodReadUpdate/riverpod_read_update.dart';
import 'package:riverpod_all_components/StreamProvider/stream_provider_screen.dart';

import 'package:riverpod_all_components/consumerStatefull/consumer_statefull_wdiget.dart';
import 'package:riverpod_all_components/home_view.dart';
import 'package:riverpod_all_components/riverpodAutoDispose/riverpod_autodispose_screen.dart';
import 'package:riverpod_all_components/stateNotfierProvider/state_notifier_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Öncelikle widget ağacımızı sarmalamak için ProviderScope'u ağacamıza enjekte ediyoruz
void main() => runApp(ProviderScope(child: MyApp()));
//Daha sonra bir değişkeni Provider ile oluşturup istedeimiz yerde kullanabiliyoruz
final myBasicProvider = Provider<String>(
  (ref) => 'first Provider',
);
//Burada da bir StateProvider ile bir değişken oluşturuyoruz
final myStateProvider = StateProvider((ref) => 100);

final myConsumerStatefullWdiget = StateProvider((ref) => 1);
//myStateProviderNotifier da generclerimizi yazdık myNotifier ı dinleyeceğim ve bu bana liste dönecek
final myStateProviderNotifier = StateNotifierProvider<myNotifier, List>(
  (ref) => myNotifier(),
);
final myTryProvider = StateNotifierProvider(
  (ref) => myNotifier(),
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.amber),
        home: StreamProvScreen());
  }
}
//ref.select() Metodu Kullanımı

class Car {
  final String name;
  final String model;
  final Color color;
  Car({
    required this.name,
    required this.model,
    required this.color,
  });
}

final carProvider = StateProvider<Car>((ref) => Car(
      name: 'BMW',
      model: '520',
      color: Colors.grey,
    ));

///////////////////////////////////// ---FAMİLY---/////////////////////////////

enum TypeOfNumber { low, medium, high }
final getNumber = StateProvider.family(
  (ref, TypeOfNumber type) {
    Random random = Random();

    late int _generateNumber;

    if (type == TypeOfNumber.low) {
      _generateNumber = random.nextInt(10);
    } else if (type == TypeOfNumber.medium) {
      _generateNumber = 10 + random.nextInt(100);
    } else {
      _generateNumber = 100 + random.nextInt(1000);
    }
    return _generateNumber;
  },
);

//Dependency ve Override kavramları

//Burada SharedPreferences yapısını kullanmak istiyorsak
//Öncelikle SharedPreferences nesnesini bir Provider ile sarmalıyoruz (1)
//Bir clasımız olsun ve bunu StateNotifier ile dinleyelim  (2)
//

Future<void> main2() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences preferences = await SharedPreferences.getInstance();

  runApp(ProviderScope(
    overrides: [
      //sharedProviderımıza preferences nesnemizi overrideWithValue metodu sayesiyle dahil ettik
      sharedProvider.overrideWithValue(preferences),
    ],
    child: MyApp(),
  ));
}

//1-
final sharedProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError(),
);

//2-
class MyClass extends StateNotifier<bool> {
  final SharedPreferences preferences;

  MyClass(this.preferences) : super(true);
}

final viewModelProvider = StateNotifierProvider<MyClass, bool>(
  (ref) {
    final sharedPrev = ref.watch(sharedProvider);
    return MyClass(sharedPrev);
  },
);
///Kısac sharedProvider nesnsi üzerinde SharedPreferences nesnesi var ve buna ihtiyaç duyan herahngibir Provider yapısına da dışardan 
///bağımlılığımızı bu şekilde enjekte ederek kullanmış olduk 