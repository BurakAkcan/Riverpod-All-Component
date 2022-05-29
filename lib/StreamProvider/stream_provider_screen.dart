import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/io.dart';

class StreamProvScreen extends ConsumerWidget {
  const StreamProvScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final message = ref.watch(providerStream);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: message.when(data: (data) {
            print(data);
          }, loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }, error: (err, __) {
            return const Text('Something went wrong');
          }),
        ),
      ),
    );
  }
}

//Öncelikle StreamProvider Yapımızı oluşturuyoruz

final providerStream = StreamProvider.autoDispose(
  (ref) async* {
    final channel = IOWebSocketChannel.connect('ws://10.0.2.2:3000/posts');
    ref.onDispose(
      () => channel.sink.close(),
    );
    channel.sink.add('send Something');

    await for (final value in channel.stream) {
      yield value.toString();
    }
  },
);
