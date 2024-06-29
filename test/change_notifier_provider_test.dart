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
//     test('value', () async {
//       final myNotifier = ValueNotifier<int>(0);

//       await tester.pumpComponent(
//         MultiProvider(
//           providers: [
//             ChangeNotifierProvider.value(value: myNotifier),
//           ],
//           child: Consumer<ValueNotifier<int>>(
//             builder: (_, value, __) sync* {
//               yield Text(value.value.toString());
//             },
//           ),
//         ),
//       );

//       expect(find.text('0'), findsOneComponent);

//       myNotifier.value++;
//       await tester.pump();

//       expect(find.text('1'), findsOneComponent);

//       await tester.pumpComponent(Container());

//       // would throw if myNotifier is disposed
//       myNotifier.notifyListeners();
//     });

//     test('builder', () async {
//       final myNotifier = ValueNotifier<int>(0);

//       await tester.pumpComponent(
//         MultiProvider(
//           providers: [
//             ChangeNotifierProvider(create: (_) => myNotifier),
//           ],
//           child: Consumer<ValueNotifier<int>>(
//             builder: (_, value, __) sync* {
//               yield Text(value.value.toString());
//             },
//           ),
//         ),
//       );

//       expect(find.text('0'), findsOneComponent);

//       myNotifier.value++;
//       await tester.pump();

//       expect(find.text('1'), findsOneComponent);

//       await tester.pumpComponent(Container());

//       expect(myNotifier.notifyListeners, throwsAssertionError);
//     });

//     test('builder1', () async {
//       final myNotifier = ValueNotifier<int>(0);

//       await tester.pumpComponent(
//         MultiProvider(
//           providers: [
//             Provider(create: (_) => A()),
//             ChangeNotifierProxyProvider<A, ValueNotifier<int>?>(
//               create: (_) => null,
//               update: (_, __, ___) => myNotifier,
//             ),
//           ],
//           child: Consumer<ValueNotifier<int>?>(
//             builder: (_, value, __) sync* {
//               yield Text(value!.value.toString());
//             },
//           ),
//         ),
//       );

//       expect(find.text('0'), findsOneComponent);

//       myNotifier.value++;
//       await tester.pump();

//       expect(find.text('1'), findsOneComponent);

//       await tester.pumpComponent(Container());

//       expect(myNotifier.notifyListeners, throwsAssertionError);
//     });

//     test('builder2', () async {
//       final myNotifier = ValueNotifier<int>(0);

//       await tester.pumpComponent(
//         MultiProvider(
//           providers: [
//             Provider(create: (_) => A()),
//             Provider(create: (_) => B()),
//             ChangeNotifierProxyProvider2<A, B, ValueNotifier<int>?>(
//               create: (_) => null,
//               update: (_, _a, _b, ___) => myNotifier,
//             ),
//           ],
//           child: Consumer<ValueNotifier<int>?>(
//             builder: (_, value, __) sync* {
//               yield Text(value!.value.toString());
//             },
//           ),
//         ),
//       );

//       expect(find.text('0'), findsOneComponent);

//       myNotifier.value++;
//       await tester.pump();

//       expect(find.text('1'), findsOneComponent);

//       await tester.pumpComponent(Container());

//       expect(myNotifier.notifyListeners, throwsAssertionError);
//     });

//     test('builder3', () async {
//       final myNotifier = ValueNotifier<int>(0);

//       await tester.pumpComponent(
//         MultiProvider(
//           providers: [
//             Provider(create: (_) => A()),
//             Provider(create: (_) => B()),
//             Provider(create: (_) => C()),
//             ChangeNotifierProxyProvider3<A, B, C, ValueNotifier<int>?>(
//               create: (_) => null,
//               update: (_, _a, _b, _c, ___) => myNotifier,
//             ),
//           ],
//           child: Consumer<ValueNotifier<int>?>(
//             builder: (_, value, __) sync* {
//               yield Text(value!.value.toString());
//             },
//           ),
//         ),
//       );

//       expect(find.text('0'), findsOneComponent);

//       myNotifier.value++;
//       await tester.pump();

//       expect(find.text('1'), findsOneComponent);

//       await tester.pumpComponent(Container());

//       expect(myNotifier.notifyListeners, throwsAssertionError);
//     });

//     test('builder4', () async {
//       final myNotifier = ValueNotifier<int>(0);

//       await tester.pumpComponent(
//         MultiProvider(
//           providers: [
//             Provider(create: (_) => A()),
//             Provider(create: (_) => B()),
//             Provider(create: (_) => C()),
//             Provider(create: (_) => D()),
//             ChangeNotifierProxyProvider4<A, B, C, D, ValueNotifier<int>?>(
//               create: (_) => null,
//               update: (_, _a, _b, _c, _d, ___) => myNotifier,
//             ),
//           ],
//           child: Consumer<ValueNotifier<int>?>(
//             builder: (_, value, __) sync* {
//               yield Text(value!.value.toString());
//             },
//           ),
//         ),
//       );

//       expect(find.text('0'), findsOneComponent);

//       myNotifier.value++;
//       await tester.pump();

//       expect(find.text('1'), findsOneComponent);

//       await tester.pumpComponent(Container());

//       expect(myNotifier.notifyListeners, throwsAssertionError);
//     });

//     test('builder5', () async {
//       final myNotifier = ValueNotifier<int>(0);

//       await tester.pumpComponent(
//         MultiProvider(
//           providers: [
//             Provider(create: (_) => A()),
//             Provider(create: (_) => B()),
//             Provider(create: (_) => C()),
//             Provider(create: (_) => D()),
//             Provider(create: (_) => E()),
//             ChangeNotifierProxyProvider5<A, B, C, D, E, ValueNotifier<int>?>(
//               create: (_) => null,
//               update: (_, _a, _b, _c, _d, _e, ___) => myNotifier,
//             ),
//           ],
//           child: Consumer<ValueNotifier<int>?>(
//             builder: (_, value, __) sync* {
//               yield Text(value!.value.toString());
//             },
//           ),
//         ),
//       );

//       expect(find.text('0'), findsOneComponent);

//       myNotifier.value++;
//       await tester.pump();

//       expect(find.text('1'), findsOneComponent);

//       await tester.pumpComponent(Container());

//       expect(myNotifier.notifyListeners, throwsAssertionError);
//     });

//     test('builder6', () async {
//       final myNotifier = ValueNotifier<int>(0);

//       await tester.pumpComponent(
//         MultiProvider(
//           providers: [
//             Provider(create: (_) => A()),
//             Provider(create: (_) => B()),
//             Provider(create: (_) => C()),
//             Provider(create: (_) => D()),
//             Provider(create: (_) => E()),
//             Provider(create: (_) => F()),
//             ChangeNotifierProxyProvider6<A, B, C, D, E, F, ValueNotifier<int>?>(
//               create: (_) => null,
//               update: (_, _a, _b, _c, _d, _e, _f, ___) => myNotifier,
//             ),
//           ],
//           child: Consumer<ValueNotifier<int>?>(
//             builder: (_, value, __) sync* {
//               yield Text(value!.value.toString());
//             },
//           ),
//         ),
//       );

//       expect(find.text('0'), findsOneComponent);

//       myNotifier.value++;
//       await tester.pump();

//       expect(find.text('1'), findsOneComponent);

//       await tester.pumpComponent(Container());

//       expect(myNotifier.notifyListeners, throwsAssertionError);
//     });

//     test('builder0', () async {
//       final myNotifier = ValueNotifier<int>(0);

//       await tester.pumpComponent(
//         MultiProvider(
//           providers: [
//             ChangeNotifierProxyProvider0<ValueNotifier<int>?>(
//               create: (_) => null,
//               update: (_, ___) => myNotifier,
//             ),
//           ],
//           child: Consumer<ValueNotifier<int>?>(
//             builder: (_, value, __) sync* {
//               yield Text(value!.value.toString());
//             },
//           ),
//         ),
//       );

//       expect(find.text('0'), findsOneComponent);

//       myNotifier.value++;
//       await tester.pump();

//       expect(find.text('1'), findsOneComponent);

//       await tester.pumpComponent(Container());

//       expect(myNotifier.notifyListeners, throwsAssertionError);
//     });
//   });

//   test('Use builder property, not child', () async {
//     final myNotifier = ValueNotifier<int>(0);

//     await tester.pumpComponent(
//       ChangeNotifierProvider<ValueNotifier<int>>(
//         create: (context) => myNotifier,
//         builder: (context, _) sync* {
//           final notifier = context.watch<ValueNotifier<int>>();
//           yield Text('${notifier.value}');
//         },
//       ),
//     );

//     expect(find.text('0'), findsOneComponent);

//     myNotifier.value++;
//     await tester.pump();

//     expect(find.text('1'), findsOneComponent);

//     await tester.pumpComponent(Container());

//     expect(myNotifier.notifyListeners, throwsAssertionError);
//   });
// }
