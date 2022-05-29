import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_all_components/main.dart';

class RefSelectScreen extends ConsumerWidget {
  const RefSelectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //Aşağıdaki şekilde yapılacak iş select metoduyla da yapılabilir.
    final car = ref.watch(carProvider);
//ref.select()

    final selectCar = ref.watch(carProvider.select((car) => car.name));
//Nesnenin Coloru değiştiği için snackbarımızı görürüz
//Eğer burada value.model yazsaydık butonla nesnenin modelini değiştirmedğimiz için snackbar gözükmeyecekti işte select burada kullanılabilir.

    ref.listen(
        carProvider.select(
          (value) => value.color,
        ), (previous, next) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Our prev model $previous and new model $next'),
      ));
    });

    return Scaffold(
      body: Center(
          child: Container(
        padding: EdgeInsets.all(30),
        color: car.color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(selectCar),
          ],
        ),
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final carProviderController = ref.read(carProvider.notifier);
//Burada rengi değiştirdik
          carProviderController.state = Car(
              name: carProviderController.state.name,
              model: carProviderController.state.model,
              color: Colors.blue);
        },
      ),
    );
  }
}
