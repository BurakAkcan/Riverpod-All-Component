import 'package:flutter/material.dart';
import 'package:riverpod_all_components/RiverpodFamily/riverpod_family.dart';
import 'package:riverpod_all_components/consumerStatefull/consumer_statefull_wdiget.dart';
import 'package:riverpod_all_components/riverpodAutoDispose/state_provider_for_autodispose_screen.dart';

class AutoDisposeScreen extends StatelessWidget {
  const AutoDisposeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: IconButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => StateProviderAutoDispose(),
          ));
        },
        icon: const Icon(
          Icons.refresh,
          size: 50,
        ),
      )),
    );
  }
}
