// import 'package:jaspr/jaspr.dart';
// import 'package:jaspr_provider/jaspr_provider.dart';
// import 'package:jaspr_test/jaspr_test.dart';
// import 'common.dart';

// void main() {
//   late ComponentTester tester;

//   setUpAll(() {
//     tester = ComponentTester.setUp();
//   });

//   group('ChangeNotifierProvider', () {
//     test('default', () async {
//       await tester.pumpComponent(
//         ChangeNotifierProvider(
//           create: (_) => ValueNotifier(0),
//           builder: (context, child) sync* {
//             context.watch<ValueNotifier<int>>();
//             yield child!;
//           },
//           child: const Text(
//             'child',
//           ),
//         ),
//       );

//       expect(find.text('child'), findsOneComponent);
//     });

//     test('.value', () async {
//       await tester.pumpComponent(
//         ChangeNotifierProvider.value(
//           value: ValueNotifier(0),
//           builder: (context, child) sync* {
//             context.watch<ValueNotifier<int>>();
//             yield child!;
//           },
//           child: const Text('child'),
//         ),
//       );

//       expect(find.text('child'), findsOneComponent);
//     });
//   });

//   group('ListenableProvider', () {
//     test('default', () async {
//       await tester.pumpComponent(
//         ListenableProvider(
//           create: (_) => ValueNotifier(0),
//           builder: (context, child) sync* {
//             context.watch<ValueNotifier<int>>();
//             yield child!;
//           },
//           child: const Text('child'),
//         ),
//       );

//       expect(find.text('child'), findsOneComponent);
//     });

//     test('.value', () async {
//       await tester.pumpComponent(
//         ListenableProvider.value(
//           value: ValueNotifier(0),
//           builder: (context, child) sync* {
//             context.watch<ValueNotifier<int>>();
//             yield child!;
//           },
//           child: const Text('child'),
//         ),
//       );

//       expect(find.text('child'), findsOneComponent);
//     });
//   });

//   group('Provider', () {
//     test('default', () async {
//       await tester.pumpComponent(
//         Provider(
//           create: (_) => 0,
//           builder: (context, child) sync* {
//             context.watch<int>();
//             yield child!;
//           },
//           child: const Text('child'),
//         ),
//       );

//       expect(find.text('child'), findsOneComponent);
//     });

//     test('.value', () async {
//       await tester.pumpComponent(
//         Provider.value(
//           value: 0,
//           builder: (context, child) sync* {
//             context.watch<int>();
//             yield child!;
//           },
//           child: const Text('child'),
//         ),
//       );

//       expect(find.text('child'), findsOneComponent);
//     });
//   });

//   group('ProxyProvider', () {
//     test('0', () async {
//       var buildCount = 0;
//       await tester.pumpComponent(
//         MultiProvider(
//           providers: [
//             ProxyProvider0<int>(
//               update: (_, __) => 0,
//               builder: (context, child) sync* {
//                 buildCount++;
//                 context.watch<int>();
//                 yield child!;
//               },
//             ),
//           ],
//           child: const Text('child'),
//         ),
//       );

//       expect(buildCount, 1);
//       expect(find.text('child'), findsOneComponent);
//     });

//     test('1', () async {
//       var buildCount = 0;
//       await tester.pumpComponent(
//         MultiProvider(
//           providers: [
//             Provider.value(value: ''),
//             ProxyProvider<String, int>(
//               update: (_, __, ___) => 0,
//               builder: (context, child) sync* {
//                 buildCount++;
//                 context.watch<int>();
//                 yield child!;
//               },
//             ),
//           ],
//           child: const Text('child'),
//         ),
//       );

//       expect(buildCount, 1);
//       expect(find.text('child'), findsOneComponent);
//     });

//     test('2', () async {
//       var buildCount = 0;
//       await tester.pumpComponent(
//         MultiProvider(
//           providers: [
//             Provider.value(value: ''),
//             Provider<double>.value(value: 0),
//             ProxyProvider2<String, double, int>(
//               update: (a, b, c, d) => 0,
//               builder: (context, child) sync* {
//                 buildCount++;
//                 context.watch<int>();
//                 yield child!;
//               },
//             ),
//           ],
//           child: const Text('child'),
//         ),
//       );

//       expect(buildCount, 1);
//       expect(find.text('child'), findsOneComponent);
//     });

//     test('3', () async {
//       var buildCount = 0;
//       await tester.pumpComponent(
//         MultiProvider(
//           providers: [
//             Provider.value(value: ''),
//             Provider<double>.value(value: 0),
//             Provider.value(value: A()),
//             ProxyProvider3<String, double, A, int>(
//               update: (a, b, c, d, e) => 0,
//               builder: (context, child) sync* {
//                 buildCount++;
//                 context.watch<int>();
//                 yield child!;
//               },
//             ),
//           ],
//           child: const Text('child'),
//         ),
//       );

//       expect(buildCount, 1);
//       expect(find.text('child'), findsOneComponent);
//     });

//     test('4', () async {
//       var buildCount = 0;
//       await tester.pumpComponent(
//         MultiProvider(
//           providers: [
//             Provider.value(value: ''),
//             Provider<double>.value(value: 0),
//             Provider.value(value: A()),
//             Provider.value(value: B()),
//             ProxyProvider4<String, double, A, B, int>(
//               update: (a, b, c, d, e, f) => 0,
//               builder: (context, child) sync* {
//                 buildCount++;
//                 context.watch<int>();
//                 yield child!;
//               },
//             ),
//           ],
//           child: const Text('child'),
//         ),
//       );

//       expect(buildCount, 1);
//       expect(find.text('child'), findsOneComponent);
//     });

//     test('5', () async {
//       var buildCount = 0;
//       await tester.pumpComponent(
//         MultiProvider(
//           providers: [
//             Provider.value(value: ''),
//             Provider<double>.value(value: 0),
//             Provider.value(value: A()),
//             Provider.value(value: B()),
//             Provider.value(value: C()),
//             ProxyProvider5<String, double, A, B, C, int>(
//               update: (a, b, c, d, e, f, g) => 0,
//               builder: (context, child) sync* {
//                 buildCount++;
//                 context.watch<int>();
//                 yield child!;
//               },
//             ),
//           ],
//           child: const Text('child'),
//         ),
//       );

//       expect(buildCount, 1);
//       expect(find.text('child'), findsOneComponent);
//     });

//     test('6', () async {
//       var buildCount = 0;
//       await tester.pumpComponent(
//         MultiProvider(
//           providers: [
//             Provider.value(value: ''),
//             Provider<double>.value(value: 0),
//             Provider.value(value: A()),
//             Provider.value(value: B()),
//             Provider.value(value: C()),
//             Provider.value(value: D()),
//             ProxyProvider6<String, double, A, B, C, D, int>(
//               update: (a, b, c, d, e, f, g, h) => 0,
//               builder: (context, child) sync* {
//                 buildCount++;
//                 context.watch<int>();
//                 yield child!;
//               },
//             ),
//           ],
//           child: const Text('child'),
//         ),
//       );

//       expect(buildCount, 1);
//       expect(find.text('child'), findsOneComponent);
//     });
//   });

//   group('MultiProvider', () {
//     test('with 1 ChangeNotifierProvider default', () async {
//       await tester.pumpComponent(
//         MultiProvider(
//           providers: [
//             ChangeNotifierProvider(
//               create: (_) => ValueNotifier(0),
//             ),
//           ],
//           builder: (context, child) sync* {
//             context.watch<ValueNotifier<int>>();
//             yield child!;
//           },
//           child: const Text('child'),
//         ),
//       );

//       expect(find.text('child'), findsOneComponent);
//     });

//     test('with 2 ChangeNotifierProvider default', () async {
//       await tester.pumpComponent(
//         MultiProvider(
//           providers: [
//             ChangeNotifierProvider(
//               create: (_) => ValueNotifier(0),
//             ),
//             ChangeNotifierProvider(
//               create: (_) => ValueNotifier('string'),
//             ),
//           ],
//           builder: (context, child) sync* {
//             context.watch<ValueNotifier<int>>();
//             context.watch<ValueNotifier<String>>();
//             yield child!;
//           },
//           child: const Text('child'),
//         ),
//       );

//       expect(find.text('child'), findsOneComponent);
//     });

//     test('with ListenableProvider default', () async {
//       await tester.pumpComponent(
//         MultiProvider(
//           providers: [
//             ListenableProvider(
//               create: (_) => ValueNotifier(0),
//             ),
//           ],
//           builder: (context, child) sync* {
//             context.watch<ValueNotifier<int>>();
//             yield child!;
//           },
//           child: const Text('child'),
//         ),
//       );

//       expect(find.text('child'), findsOneComponent);
//     });

//     test('with Provider default', () async {
//       await tester.pumpComponent(
//         MultiProvider(
//           providers: [
//             Provider(
//               create: (_) => 0,
//             ),
//           ],
//           builder: (context, child) sync* {
//             context.watch<int>();
//             yield child!;
//           },
//           child: const Text('child'),
//         ),
//       );

//       expect(find.text('child'), findsOneComponent);
//     });

//     test('with ProxyProvider0', () async {
//       var buildCount = 0;
//       await tester.pumpComponent(
//         MultiProvider(
//           providers: [
//             ProxyProvider0<int>(
//               update: (_, __) => 0,
//             ),
//           ],
//           builder: (context, child) sync* {
//             buildCount++;
//             context.watch<int>();
//             yield child!;
//           },
//           child: const Text('child'),
//         ),
//       );

//       expect(buildCount, 1);
//       expect(find.text('child'), findsOneComponent);
//     });

//     test('with ProxyProvider1', () async {
//       var buildCount = 0;
//       await tester.pumpComponent(
//         MultiProvider(
//           providers: [
//             Provider.value(value: ''),
//             ProxyProvider<String, int>(
//               update: (_, __, ___) => 0,
//             ),
//           ],
//           builder: (context, child) sync* {
//             buildCount++;
//             context.watch<int>();
//             yield child!;
//           },
//           child: const Text('child'),
//         ),
//       );

//       expect(buildCount, 1);
//       expect(find.text('child'), findsOneComponent);
//     });

//     test('with ProxyProvider2', () async {
//       var buildCount = 0;
//       await tester.pumpComponent(
//         MultiProvider(
//           providers: [
//             Provider.value(value: ''),
//             Provider<double>.value(value: 0),
//             ProxyProvider2<String, double, int>(
//               update: (a, b, c, d) => 0,
//             ),
//           ],
//           builder: (context, child) sync* {
//             buildCount++;
//             context.watch<int>();
//             yield child!;
//           },
//           child: const Text('child'),
//         ),
//       );

//       expect(buildCount, 1);
//       expect(find.text('child'), findsOneComponent);
//     });

//     test('with ProxyProvider3', () async {
//       var buildCount = 0;
//       await tester.pumpComponent(
//         MultiProvider(
//           providers: [
//             Provider.value(value: ''),
//             Provider<double>.value(value: 0),
//             Provider.value(value: A()),
//             ProxyProvider3<String, double, A, int>(
//               update: (a, b, c, d, e) => 0,
//             ),
//           ],
//           builder: (context, child) sync* {
//             buildCount++;
//             context.watch<int>();
//             yield child!;
//           },
//           child: const Text('child'),
//         ),
//       );

//       expect(buildCount, 1);
//       expect(find.text('child'), findsOneComponent);
//     });

//     test('with ProxyProvider4', () async {
//       var buildCount = 0;
//       await tester.pumpComponent(
//         MultiProvider(
//           providers: [
//             Provider.value(value: ''),
//             Provider<double>.value(value: 0),
//             Provider.value(value: A()),
//             Provider.value(value: B()),
//             ProxyProvider4<String, double, A, B, int>(
//               update: (a, b, c, d, e, f) => 0,
//             ),
//           ],
//           builder: (context, child) sync* {
//             buildCount++;
//             context.watch<int>();
//             yield child!;
//           },
//           child: const Text('child'),
//         ),
//       );

//       expect(buildCount, 1);
//       expect(find.text('child'), findsOneComponent);
//     });

//     test('with ProxyProvider5', () async {
//       var buildCount = 0;
//       await tester.pumpComponent(
//         MultiProvider(
//           providers: [
//             Provider.value(value: ''),
//             Provider<double>.value(value: 0),
//             Provider.value(value: A()),
//             Provider.value(value: B()),
//             Provider.value(value: C()),
//             ProxyProvider5<String, double, A, B, C, int>(
//               update: (a, b, c, d, e, f, g) => 0,
//             ),
//           ],
//           builder: (context, child) sync* {
//             buildCount++;
//             context.watch<int>();
//             yield child!;
//           },
//           child: const Text('child'),
//         ),
//       );

//       expect(buildCount, 1);
//       expect(find.text('child'), findsOneComponent);
//     });

//     test('with ProxyProvider6', () async {
//       var buildCount = 0;
//       await tester.pumpComponent(
//         MultiProvider(
//           providers: [
//             Provider.value(value: ''),
//             Provider<double>.value(value: 0),
//             Provider.value(value: A()),
//             Provider.value(value: B()),
//             Provider.value(value: C()),
//             Provider.value(value: D()),
//             ProxyProvider6<String, double, A, B, C, D, int>(
//               update: (a, b, c, d, e, f, g, h) => 0,
//             ),
//           ],
//           builder: (context, child) sync* {
//             buildCount++;
//             context.watch<int>();
//             yield child!;
//           },
//           child: const Text('child'),
//         ),
//       );

//       expect(buildCount, 1);
//       expect(find.text('child'), findsOneComponent);
//     });
//   });
// }
