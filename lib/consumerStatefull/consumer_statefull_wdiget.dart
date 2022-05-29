import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_all_components/main.dart';

//Bunu kullanmamızın sebebi initstate  ve dispose yapısını kullanmak istersek bu şekilde yapmalıyız
//Ayrıca WidgetRef ref yazmamıza gerek yok direkt ref yapısıyla beraber geliyor
class ConsumerStatefullWidgetScreen extends ConsumerStatefulWidget {
  const ConsumerStatefullWidgetScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefullWidgetScreen> createState() =>
      _ConsumerStatefullWidgetScreenState();
}

class _ConsumerStatefullWidgetScreenState
    extends ConsumerState<ConsumerStatefullWidgetScreen> {
  @override
  Widget build(BuildContext context) {
    int myValue = ref.watch(myConsumerStatefullWdiget);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Text(myValue.toString()),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(myConsumerStatefullWdiget.state).state++;
        },
      ),
    );
  }
}
