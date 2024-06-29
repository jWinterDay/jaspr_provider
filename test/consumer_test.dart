// import 'package:jaspr/jaspr.dart';
// import 'package:jaspr_provider/jaspr_provider.dart';
// import 'package:jaspr_test/jaspr_test.dart';
// import 'package:mockito/mockito.dart';

// import 'common.dart';

// class ConsumerBuilderMock extends Mock {
//   void call(Combined? foo);
// }

// @immutable
// class Combined {
//   const Combined(
//     this.context,
//     this.child,
//     this.a, [
//     this.b,
//     this.c,
//     this.d,
//     this.e,
//     this.f,
//   ]);

//   final A? a;
//   final B? b;
//   final C? c;
//   final D? d;
//   final E? e;
//   final F? f;
//   final Component? child;
//   final BuildContext? context;

//   @override
//   // ignore: hash_and_equals
//   bool operator ==(Object other) =>
//       other is Combined &&
//       other.context == context &&
//       other.child == child &&
//       other.a == a &&
//       other.b == b &&
//       other.c == c &&
//       other.e == e &&
//       other.f == f;
// }

// void main() {
//   final a = A();
//   final b = B();
//   final c = C();
//   final d = D();
//   final e = E();
//   final f = F();

//   final multiProviderNodes = [
//     Provider.value(value: a),
//     Provider.value(value: b),
//     Provider.value(value: c),
//     Provider.value(value: d),
//     Provider.value(value: e),
//     Provider.value(value: f),
//   ];

//   final mock = ConsumerBuilderMock();

//   late ComponentTester tester;

//   setUp(() {
//     tester = ComponentTester.setUp();
//   });

//   tearDown(() async {
//     clearInteractions(mock);
//     await tester.pumpComponent(Container());
//     await tester.pump();
//   });

//   group('consumer', () {
//     test('obtains value from Provider<T>', () async {
//       const key = GlobalKey();
//       final child = Container();

//       await tester.pumpComponent(
//         MultiProvider(
//           providers: multiProviderNodes,
//           child: Consumer<A>(
//             key: key,
//             builder: (context, value, child) sync* {
//               mock(Combined(context, child, value));
//               yield Container();
//             },
//             child: child,
//           ),
//         ),
//       );

//       verify(mock(Combined(key.currentContext, child, a)));
//     });

//     test('can be used inside MultiProvider', () async {
//       const key = GlobalKey();
//       await tester.pump();
//       await tester.pumpComponent(
//         MultiProvider(
//           providers: [
//             ...multiProviderNodes,
//             Consumer<A>(
//               key: key,
//               builder: (_, a, child) sync* {
//                 yield Container(child: child);
//               },
//             )
//           ],
//           child: const Text('foo'),
//         ),
//       );

//       expect(find.text('foo'), findsOneComponent);
//       expect(find.byType(Container), findsOneComponent);
//       expect(key.currentContext, isNotNull);
//     });
//   });

//   group('consumer2', () {
//     test('obtains value from Provider<T>', () async {
//       const key = GlobalKey();
//       final child = Container();

//       await tester.pumpComponent(
//         MultiProvider(
//           providers: multiProviderNodes,
//           child: Consumer2<A, B>(
//             key: key,
//             builder: (context, value, v2, child) sync* {
//               mock(Combined(context, child, value, v2));
//               yield Container();
//             },
//             child: child,
//           ),
//         ),
//       );

//       verify(mock(Combined(key.currentContext, child, a, b)));
//     });

//     test('can be used inside MultiProvider', () async {
//       const key = GlobalKey();

//       await tester.pumpComponent(
//         MultiProvider(
//           providers: [
//             ...multiProviderNodes,
//             Consumer2<A, B>(
//               key: key,
//               builder: (_, a, b, child) sync* {
//                 yield Container(child: child);
//               },
//             )
//           ],
//           child: const Text('foo'),
//         ),
//       );

//       expect(find.text('foo'), findsOneComponent);
//       expect(find.byType(Container), findsOneComponent);
//       expect(key.currentContext, isNotNull);
//     });
//   });

//   group('consumer3', () {
//     test('obtains value from Provider<T>', () async {
//       const key = GlobalKey();
//       final child = Container();

//       await tester.pumpComponent(
//         MultiProvider(
//           providers: multiProviderNodes,
//           child: Consumer3<A, B, C>(
//             key: key,
//             builder: (context, value, v2, v3, child) sync* {
//               mock(Combined(context, child, value, v2, v3));
//               yield Container();
//             },
//             child: child,
//           ),
//         ),
//       );

//       verify(mock(Combined(key.currentContext, child, a, b, c)));
//     });

//     test('can be used inside MultiProvider', () async {
//       const key = GlobalKey();

//       await tester.pumpComponent(
//         MultiProvider(
//           providers: [
//             ...multiProviderNodes,
//             Consumer3<A, B, C>(
//               key: key,
//               builder: (_, a, b, c, child) sync* {
//                 yield Container(child: child);
//               },
//             )
//           ],
//           child: const Text('foo'),
//         ),
//       );

//       expect(find.text('foo'), findsOneComponent);
//       expect(find.byType(Container), findsOneComponent);
//       expect(key.currentContext, isNotNull);
//     });
//   });

//   group('consumer4', () {
//     test('obtains value from Provider<T>', () async {
//       const key = GlobalKey();
//       final child = Container();

//       await tester.pumpComponent(
//         MultiProvider(
//           providers: multiProviderNodes,
//           child: Consumer4<A, B, C, D>(
//             key: key,
//             builder: (context, value, v2, v3, v4, child) sync* {
//               mock(Combined(context, child, value, v2, v3, v4));
//               yield Container();
//             },
//             child: child,
//           ),
//         ),
//       );

//       verify(mock(Combined(key.currentContext, child, a, b, c, d)));
//     });

//     test('can be used inside MultiProvider', () async {
//       const key = GlobalKey();

//       await tester.pumpComponent(
//         MultiProvider(
//           providers: [
//             ...multiProviderNodes,
//             Consumer4<A, B, C, D>(
//               key: key,
//               builder: (_, a, b, c, d, child) sync* {
//                 yield Container(child: child);
//               },
//             )
//           ],
//           child: const Text('foo'),
//         ),
//       );

//       expect(find.text('foo'), findsOneComponent);
//       expect(find.byType(Container), findsOneComponent);
//       expect(key.currentContext, isNotNull);
//     });
//   });

//   group('consumer5', () {
//     test('obtains value from Provider<T>', () async {
//       const key = GlobalKey();
//       final child = Container();

//       await tester.pumpComponent(
//         MultiProvider(
//           providers: multiProviderNodes,
//           child: Consumer5<A, B, C, D, E>(
//             key: key,
//             builder: (context, value, v2, v3, v4, v5, child) sync* {
//               mock(Combined(context, child, value, v2, v3, v4, v5));
//               yield Container();
//             },
//             child: child,
//           ),
//         ),
//       );

//       verify(mock(Combined(key.currentContext, child, a, b, c, d, e)));
//     });

//     test('can be used inside MultiProvider', () async {
//       const key = GlobalKey();

//       await tester.pumpComponent(
//         MultiProvider(
//           providers: [
//             ...multiProviderNodes,
//             Consumer5<A, B, C, D, E>(
//               key: key,
//               builder: (_, a, b, c, d, e, child) sync* {
//                 yield Container(child: child);
//               },
//             )
//           ],
//           child: const Text('foo'),
//         ),
//       );

//       expect(find.text('foo'), findsOneComponent);
//       expect(find.byType(Container), findsOneComponent);
//       expect(key.currentContext, isNotNull);
//     });
//   });

//   group('consumer6', () {
//     test('obtains value from Provider<T>', () async {
//       const key = GlobalKey();
//       final child = Container();

//       await tester.pumpComponent(
//         MultiProvider(
//           providers: multiProviderNodes,
//           child: Consumer6<A, B, C, D, E, F>(
//             key: key,
//             builder: (context, value, v2, v3, v4, v5, v6, child) sync* {
//               mock(Combined(context, child, value, v2, v3, v4, v5, v6));
//               yield Container();
//             },
//             child: child,
//           ),
//         ),
//       );

//       verify(mock(Combined(key.currentContext, child, a, b, c, d, e, f)));
//     });

//     test('can be used inside MultiProvider', () async {
//       const key = GlobalKey();

//       await tester.pumpComponent(
//         MultiProvider(
//           providers: [
//             ...multiProviderNodes,
//             Consumer6<A, B, C, D, E, F>(
//               key: key,
//               builder: (_, a, b, c, d, e, f, child) sync* {
//                 yield Container(child: child);
//               },
//             )
//           ],
//           child: const Text('foo'),
//         ),
//       );

//       expect(find.text('foo'), findsOneComponent);
//       expect(find.byType(Container), findsOneComponent);
//       expect(key.currentContext, isNotNull);
//     });
//   });
// }
