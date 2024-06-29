// import 'package:jaspr/jaspr.dart';
// import 'package:jaspr_provider/jaspr_provider.dart';
// import 'package:jaspr_test/jaspr_test.dart';

// import 'common.dart';

// void main() {
//   late ComponentTester tester;

//   setUpAll(() {
//     tester = ComponentTester.setUp();
//   });

//   group('MultiProvider', () {
//     test('MultiProvider children can only access parent providers', () async {
//       const k1 = GlobalKey();
//       const k2 = GlobalKey();
//       const k3 = GlobalKey();
//       final p1 = Provider.value(key: k1, value: 42);
//       final p2 = Provider.value(key: k2, value: 'foo');
//       final p3 = Provider<double>.value(key: k3, value: 44);

//       const keyChild = GlobalKey();
//       await tester.pumpComponent(MultiProvider(
//         providers: [p1, p2, p3],
//         child: const Text('Foo', key: keyChild),
//       ));

//       expect(find.text('Foo'), findsOneComponent);

//       // p1 cannot access to p1/p2/p3
//       expect(
//         () => Provider.of<int>(k1.currentContext!, listen: false),
//         throwsProviderNotFound<int>(),
//       );
//       expect(
//         () => Provider.of<String>(k1.currentContext!, listen: false),
//         throwsProviderNotFound<String>(),
//       );
//       expect(
//         () => Provider.of<double>(k1.currentContext!, listen: false),
//         throwsProviderNotFound<double>(),
//       );

//       // p2 can access only p1
//       expect(Provider.of<int>(k2.currentContext!, listen: false), 42);
//       expect(
//         () => Provider.of<String>(k2.currentContext!, listen: false),
//         throwsProviderNotFound<String>(),
//       );
//       expect(
//         () => Provider.of<double>(k2.currentContext!, listen: false),
//         throwsProviderNotFound<double>(),
//       );

//       // p3 can access both p1 and p2
//       expect(Provider.of<int>(k3.currentContext!, listen: false), 42);
//       expect(Provider.of<String>(k3.currentContext!, listen: false), 'foo');
//       expect(
//         () => Provider.of<double>(k3.currentContext!, listen: false),
//         throwsProviderNotFound<double>(),
//       );

//       // the child can access them all
//       expect(Provider.of<int>(keyChild.currentContext!, listen: false), 42);
//       expect(
//         Provider.of<String>(keyChild.currentContext!, listen: false),
//         'foo',
//       );
//       expect(Provider.of<double>(keyChild.currentContext!, listen: false), 44);
//     });

//     test('MultiProvider.providers with ignored child', () async {
//       final p1 = Provider.value(
//         value: 42,
//         child: const Text('Bar'),
//       );

//       await tester.pumpComponent(MultiProvider(
//         providers: [p1],
//         child: const Text('Foo'),
//       ));

//       expect(find.text('Bar'), findsNothing);
//       expect(find.text('Foo'), findsOneComponent);
//     });
//   });
// }
