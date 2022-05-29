import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_all_components/Constant/api_constant.dart';
import 'package:riverpod_all_components/riverpodAutoDispose/state_provider_for_autodispose_screen.dart';

class FutureProviderScreen extends ConsumerWidget {
  const FutureProviderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final futOfCats = ref.watch(providerOfFuture);
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
          onPressed: () {
            ref.refresh(providerOfFuture);
          },
          icon: Icon(Icons.refresh),
        ),
      ]),
      body: SafeArea(
        child: Center(
          child: futOfCats.when(data: (data) {
            final decodeData = jsonDecode(data.body);

            List catsDetail = decodeData['data'];
            return ListView.builder(
              itemCount: catsDetail.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(catsDetail[index]['fact']),
                );
              },
            );
          }, loading: () {
            return const CircularProgressIndicator();
          }, error: (err, _) {
            return Text('Something went wrong $err');
          }),
        ),
      ),
    );
  }
}

final providerOfFuture = FutureProvider(
  (ref) async {
    final foundFacts = await http.get(Uri.parse(ApiConst.BASE_URL));
    return foundFacts;
  },
);
//FutureProvider  data ,error,loading olmak üzere 3 paremetresi vardır
//data: eğer veri geldiyse , loading: gelmek üzere ise veri ,error: hata aldıysak veri gelmediyse
//appBarımızın actions kısmına buton ekledik ve ref.refresh(futureProviderımızı )  ekliyoruz ve her tıkladığımızda servisten isteği yeniliyor 
