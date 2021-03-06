library dart_cheat_sheet;

import 'dart:collection';
import 'dart:io';
import 'dart:async';
import 'dart:isolate';
import 'package:http/http.dart' as http;
import 'package:http_server/http_server.dart';

import 'keywords.dart' as keywords;
part 'some_part.dart';

main() {
  keywords.main();
  testAnnotations();
  testCollections();
  testIterable();
  testList();
  testHttpClient();
  testHttpServer();
  testTimer();
  testRunZoned();
  testIsolate();
}

testAnnotations() {
  @deprecated
  foo() => 0;

  @override
  bar() => 0;

  @proxy
  baz() => 0;
}

even(i) => i % 2 == 0;

single(i) => i == 50;

double(i) => i * 2;

expand(i) => [i, i + 1];

sum(a, b) => a + b;

testCollections() {
  new List();

  new Set();
  new HashSet();
  new LinkedHashSet();
  new SplayTreeSet();

  new Map();
  new HashMap();
  new LinkedHashMap();
  new SplayTreeMap();

  // TODO: add in cheat sheet
  new Queue();
  new ListQueue();
  new DoubleLinkedQueue();

  // TODO: add in cheat sheet
  new LinkedHashMap();
  new LinkedHashSet();
  new LinkedList();

  // TODO: add in cheat sheet
  Maps.mapToString({});
  // Maps. ...
}

testIterable() {
  var c = new Iterable.generate(100, (i) => i);
  c
    ..isEmpty
    ..isNotEmpty
    ..iterator
    ..length
    ..first
    ..where(single).single
    ..last
    ..elementAt(1)
    ..firstWhere(even)
    ..lastWhere(even)
    ..singleWhere(single)
    ..contains(42)
    ..any(even)
    ..every(even)
    ..map(double)
    ..expand(expand)
    ..where(even)
    ..forEach(double)
    ..skip(10)
    ..skipWhile(even)
    ..take(10)
    ..takeWhile(even)
    ..reduce(sum)
    ..fold(0, sum)
    ..join(", ")
    ..toList()
    ..toSet();
}

testList() async {
  var l = new List.generate(100, (i) => i);
  l
    ..[0]
    ..[0] = 123
    ..add(42)
    ..addAll([1, 2, 3])
    ..insert(0, 666)
    ..insertAll(0, [1, 2, 3])
    ..setAll(0, [1, 2, 3])
    ..fillRange(0, 3, 42)
    ..replaceRange(0, 3, [1, 2, 3])
    ..setRange(0, 3, [1, 2, 3])
    ..reversed
    ..sublist(0, 2)
    ..sort()
    ..asMap()
    ..indexOf(42)
    ..lastIndexOf(42)
    ..remove(42)
    ..removeAt(0)
    ..removeLast()
    ..removeRange(0, 1)
    ..retainWhere(even)
    ..clear();
}

testHttpClient() {
  var url = "http://devnull-as-a-service.com/dev/null";

  http.get(url).then((resp) {
    print("Response status: ${resp.statusCode}");
    print("Response body: ${resp.body}");
  });

  http.post(url, body: {"param1": "yop", "param2": "blop"});
  http.put(url);
  http.delete(url);
  http.head(url);
  http.readBytes(url);
  http.read(url).then(print);

  var client = new http.Client();
  client.post(url, body: {"param1": "yop", "param2": "blop"})
  .then((response) => print(response.body))
  .whenComplete(client.close);
}

testHttpServer() {
  var staticFiles = new VirtualDirectory('.')
    ..allowDirectoryListing = true;

  HttpServer.bind('0.0.0.0', 7777).then((server) {
    print('Server running');
    server.listen(staticFiles.serveRequest);
    server.close(force: true);
  });
}

testTimer() {
  new Timer(const Duration(seconds: 1), () => print("Timer 1s"));
  var timer = new Timer.periodic(const Duration(milliseconds: 300), (Timer timer) => print("Timer.periodic 300ms"));
  new Timer(const Duration(seconds: 1), timer.cancel);
}

testRunZoned() {
  runZoned(() {
    new Future(() => throw "async error");
  }, onError: (e) => print("Async error occured: $e"));
}

isolateEntryPoint(msg) => print("$msg from isolate!");

testIsolate() {
  Isolate.spawn(isolateEntryPoint, "Hello");
  Isolate.spawnUri(new Uri.file("keywords.dart"), [], "Hello");
}
