// import 'dart:async';

// import 'package:jaspr/jaspr.dart';
// import 'package:jaspr_provider/jaspr_provider.dart';
// import 'package:jaspr_test/jaspr_test.dart';
// import 'package:mockito/mockito.dart';

// import 'common.dart';

// Finder findProvider<T>() => find.byComponentPredicate(
//     // comparing `runtimeType` instead of using `is` because `is` accepts
//     // subclasses but InheritedWidgets don't.
//     (widget) => widget.runtimeType == typeOf<InheritedProvider<T>>());

// void main() {
//   late ComponentTester tester;
//   final a = A();
//   final b = B();
//   final c = C();
//   final d = D();
//   final e = E();
//   final f = F();

//   final combinedConsumerMock = MockCombinedBuilder();
//   setUp(() => when(combinedConsumerMock(any)).thenReturn([Container()]));

//   setUpAll(() {
//     tester = ComponentTester.setUp();
//   });

//   tearDown(() {
//     clearInteractions(combinedConsumerMock);
//   });

//   final mockConsumer = Consumer<Combined>(
//     builder: (context, combined, child) => combinedConsumerMock(combined),
//   );

//   InheritedContext<Combined?> findProxyProvider() => findInheritedContext<Combined>();

//   group('ProxyProvider', () {
//     final combiner = CombinerMock();
//     setUp(() {
//       when(combiner(any, any, any)).thenAnswer((Invocation invocation) {
//         return Combined(
//           invocation.positionalArguments.first as BuildContext,
//           invocation.positionalArguments[2] as Combined?,
//           invocation.positionalArguments[1] as A,
//         );
//       });
//     });
//     tearDown(() => clearInteractions(combiner));

//     test('throws if the provided value is a Listenable/Stream', () async {
//       await runZonedGuarded(
//         () async {
//           await tester.pumpComponent(
//             MultiProvider(
//               providers: [
//                 Provider.value(value: a),
//                 ProxyProvider<A, MyListenable>(
//                   update: (_, __, ___) => MyListenable(),
//                 )
//               ],
//               child: TextOf<MyListenable>(),
//             ),
//           );
//           expect(false, isTrue);
//         },
//         (error, stack) {
//           expect(true, isTrue);
//         },
//       );

//       await runZonedGuarded(
//         () async {
//           await tester.pumpComponent(
//             MultiProvider(
//               providers: [
//                 Provider.value(value: a),
//                 ProxyProvider<A, MyStream>(
//                   update: (_, __, ___) => MyStream(),
//                 )
//               ],
//               child: TextOf<MyStream>(),
//             ),
//           );
//           expect(false, isTrue);
//         },
//         (error, stack) {
//           expect(true, isTrue);
//         },
//       );
//     });

//     test('debugCheckInvalidValueType can be disabled', () async {
//       final previous = Provider.debugCheckInvalidValueType;
//       Provider.debugCheckInvalidValueType = null;
//       addTearDown(() => Provider.debugCheckInvalidValueType = previous);

//       await tester.pumpComponent(
//         MultiProvider(
//           providers: [
//             Provider.value(value: a),
//             ProxyProvider<A, MyListenable>(
//               update: (_, __, ___) => MyListenable(),
//             )
//           ],
//           child: TextOf<MyListenable>(),
//         ),
//       );

//       await tester.pumpComponent(
//         MultiProvider(
//           providers: [
//             Provider.value(value: a),
//             ProxyProvider<A, MyStream>(
//               update: (_, __, ___) => MyStream(),
//             )
//           ],
//           child: TextOf<MyStream>(),
//         ),
//       );
//     });

//     test('create creates initial value', () async {
//       final create = InitialValueBuilderMock<Combined>(const Combined());

//       when(create(any)).thenReturn(const Combined());

//       await tester.pumpComponent(
//         MultiProvider(
//           providers: [
//             Provider.value(value: a),
//             ProxyProvider<A, Combined>(
//               create: create,
//               update: combiner,
//             )
//           ],
//           child: mockConsumer,
//         ),
//       );

//       verify(create(argThat(isNotNull))).called(1);

//       verify(combiner(argThat(isNotNull), a, const Combined()));
//     });

//     test('consume another providers', () async {
//       await tester.pumpComponent(
//         MultiProvider(
//           providers: [
//             Provider.value(value: a),
//             ProxyProvider<A, Combined>(
//               update: combiner,
//             )
//           ],
//           child: mockConsumer,
//         ),
//       );

//       final context = findProxyProvider();

//       verify(combinedConsumerMock(Combined(context, null, a))).called(1);
//       verifyNoMoreInteractions(combinedConsumerMock);

//       verify(combiner(context, a, null)).called(1);
//       verifyNoMoreInteractions(combiner);
//     });

//     test('rebuild descendants if value change', () async {
//       await tester.pumpComponent(
//         MultiProvider(
//           providers: [
//             Provider.value(value: a),
//             ProxyProvider<A, Combined>(
//               update: combiner,
//             )
//           ],
//           child: mockConsumer,
//         ),
//       );

//       final a2 = A();

//       await tester.pumpComponent(
//         MultiProvider(
//           providers: [
//             Provider.value(value: a2),
//             ProxyProvider<A, Combined>(
//               update: combiner,
//             )
//           ],
//           child: mockConsumer,
//         ),
//       );
//       final context = findProxyProvider();

//       verifyInOrder([
//         combiner(context, a, null),
//         combinedConsumerMock(Combined(context, null, a)),
//         combiner(context, a2, Combined(context, null, a)),
//         combinedConsumerMock(Combined(context, Combined(context, null, a), a2)),
//       ]);

//       verifyNoMoreInteractions(combiner);
//       verifyNoMoreInteractions(combinedConsumerMock);
//     });

//     test('call dispose when unmounted with the latest result', () async {
//       final dispose = DisposeMock<Combined>();
//       final dispose2 = DisposeMock<Combined>();

//       await tester.pumpComponent(
//         MultiProvider(
//           providers: [
//             Provider.value(value: a),
//             ProxyProvider<A, Combined>(update: combiner, dispose: dispose),
//           ],
//           child: mockConsumer,
//         ),
//       );

//       final a2 = A();

//       // ProxyProvider creates a new Combined instance
//       await tester.pumpComponent(
//         MultiProvider(
//           providers: [
//             Provider.value(value: a2),
//             ProxyProvider<A, Combined>(update: combiner, dispose: dispose2),
//           ],
//           child: mockConsumer,
//         ),
//       );
//       final context = findProxyProvider();

//       verify(
//         dispose(context, Combined(context, null, a)),
//       );

//       await tester.pumpComponent(Container());

//       verify(
//         dispose2(context, Combined(context, Combined(context, null, a), a2)),
//       );
//       verifyNoMoreInteractions(dispose);
//     });

//     test("don't rebuild descendants if value doesn't change", () async {
//       await tester.pumpComponent(
//         MultiProvider(
//           providers: [
//             Provider.value(value: a),
//             ProxyProvider<A, Combined>(
//               update: (c, a, p) => combiner(c, a, null),
//             )
//           ],
//           child: mockConsumer,
//         ),
//       );

//       await tester.pumpComponent(
//         MultiProvider(
//           providers: [
//             Provider.value(
//               value: a,
//               updateShouldNotify: (A _, A __) => true,
//             ),
//             ProxyProvider<A, Combined>(
//               update: (c, a, p) {
//                 combiner(c, a, p);
//                 return p!;
//               },
//             )
//           ],
//           child: mockConsumer,
//         ),
//       );
//       final context = findProxyProvider();

//       verifyInOrder([
//         combiner(context, a, null),
//         combinedConsumerMock(Combined(context, null, a)),
//         combiner(context, a, Combined(context, null, a)),
//       ]);

//       verifyNoMoreInteractions(combiner);
//       verifyNoMoreInteractions(combinedConsumerMock);
//     });

//     test('pass down updateShouldNotify', () async {
//       var buildCount = 0;
//       final child = Builder(builder: (context) sync* {
//         buildCount++;

//         yield Text(
//           '$buildCount ${Provider.of<String>(context)}',
//         );
//       });

//       final shouldNotify = UpdateShouldNotifyMock<String>();
//       when(shouldNotify('Hello', 'Hello')).thenReturn(false);

//       await tester.pumpComponent(
//         MultiProvider(
//           providers: [
//             Provider<String>.value(value: 'Hello', updateShouldNotify: (_, __) => true),
//             ProxyProvider<String, String>(
//               update: (_, value, __) => value,
//               updateShouldNotify: shouldNotify,
//             ),
//           ],
//           child: child,
//         ),
//       );

//       await tester.pumpComponent(
//         MultiProvider(
//           providers: [
//             Provider<String>.value(value: 'Hello', updateShouldNotify: (_, __) => true),
//             ProxyProvider<String, String>(
//               update: (_, value, __) => value,
//               updateShouldNotify: shouldNotify,
//             ),
//           ],
//           child: child,
//         ),
//       );

//       verify(shouldNotify('Hello', 'Hello')).called(1);
//       verifyNoMoreInteractions(shouldNotify);

//       expect(find.text('2 Hello'), findsNothing);
//       expect(find.text('1 Hello'), findsOneComponent);
//     });

//     test('works with MultiProvider', () async {
//       const key = GlobalKey();

//       await tester.pumpComponent(
//         MultiProvider(
//           providers: [
//             Provider.value(value: a),
//             ProxyProvider<A, Combined>(update: (c, a, p) => Combined(c, p, a)),
//           ],
//           child: Container(key: key),
//         ),
//       );
//       final context = findProxyProvider();

//       expect(
//         Provider.of<Combined>(key.currentContext!, listen: false),
//         Combined(context, null, a),
//       );
//     });

//     // useful for libraries such as Mobx where events are synchronously
//     // dispatched
//     test('update callback can trigger descendants setState synchronously', () async {
//       var statefulBuildCount = 0;
//       void Function(VoidCallback)? setState;

//       final statefulBuilder = StatefulBuilder(builder: (context, s) sync* {
//         // force update to be called
//         Provider.of<Combined>(context, listen: false);

//         setState = s;
//         statefulBuildCount++;
//         yield Container();
//       });

//       await tester.pumpComponent(
//         MultiProvider(
//           providers: [
//             Provider.value(value: a),
//             ProxyProvider<A, Combined>(update: (c, a, p) => Combined(c, p, a)),
//           ],
//           child: statefulBuilder,
//         ),
//       );

//       expect(
//         statefulBuildCount,
//         1,
//         reason: 'update must not be called asynchronously',
//       );

//       await tester.pumpComponent(
//         MultiProvider(
//           providers: [
//             Provider.value(value: A()),
//             ProxyProvider<A, Combined>(update: (c, a, p) {
//               setState!(() {});
//               return Combined(c, p, a);
//             }),
//           ],
//           child: statefulBuilder,
//         ),
//       );

//       expect(
//         statefulBuildCount,
//         2,
//         reason: 'update must not be called asynchronously',
//       );
//     });
//   });

//   group('ProxyProvider variants', () {
//     test('ProxyProvider2', () async {
//       await tester.pumpComponent(
//         MultiProvider(
//           providers: [
//             Provider.value(value: a),
//             Provider.value(value: b),
//             Provider.value(value: c),
//             Provider.value(value: d),
//             Provider.value(value: e),
//             Provider.value(value: f),
//             ProxyProvider2<A, B, Combined>(
//               create: (_) => const Combined(),
//               update: (context, a, b, previous) => Combined(context, previous, a, b),
//             )
//           ],
//           child: mockConsumer,
//         ),
//       );

//       final context = findProxyProvider();

//       verify(
//         combinedConsumerMock(
//           Combined(context, const Combined(), a, b),
//         ),
//       ).called(1);
//     });

//     test('ProxyProvider3', () async {
//       await tester.pumpComponent(
//         MultiProvider(
//           providers: [
//             Provider.value(value: a),
//             Provider.value(value: b),
//             Provider.value(value: c),
//             Provider.value(value: d),
//             Provider.value(value: e),
//             Provider.value(value: f),
//             ProxyProvider3<A, B, C, Combined>(
//               create: (_) => const Combined(),
//               update: (context, a, b, c, previous) => Combined(context, previous, a, b, c),
//             )
//           ],
//           child: mockConsumer,
//         ),
//       );

//       final context = findProxyProvider();

//       verify(
//         combinedConsumerMock(
//           Combined(context, const Combined(), a, b, c),
//         ),
//       ).called(1);
//     });

//     test('ProxyProvider4', () async {
//       await tester.pumpComponent(
//         MultiProvider(
//           providers: [
//             Provider.value(value: a),
//             Provider.value(value: b),
//             Provider.value(value: c),
//             Provider.value(value: d),
//             Provider.value(value: e),
//             Provider.value(value: f),
//             ProxyProvider4<A, B, C, D, Combined>(
//               create: (_) => const Combined(),
//               update: (context, a, b, c, d, previous) => Combined(context, previous, a, b, c, d),
//             )
//           ],
//           child: mockConsumer,
//         ),
//       );

//       final context = findProxyProvider();

//       verify(
//         combinedConsumerMock(
//           Combined(context, const Combined(), a, b, c, d),
//         ),
//       ).called(1);
//     });

//     test('ProxyProvider5', () async {
//       await tester.pumpComponent(
//         MultiProvider(
//           providers: [
//             Provider.value(value: a),
//             Provider.value(value: b),
//             Provider.value(value: c),
//             Provider.value(value: d),
//             Provider.value(value: e),
//             Provider.value(value: f),
//             ProxyProvider5<A, B, C, D, E, Combined>(
//               create: (_) => const Combined(),
//               update: (context, a, b, c, d, e, previous) => Combined(context, previous, a, b, c, d, e),
//             )
//           ],
//           child: mockConsumer,
//         ),
//       );

//       final context = findProxyProvider();

//       verify(
//         combinedConsumerMock(
//           Combined(context, const Combined(), a, b, c, d, e),
//         ),
//       ).called(1);
//     });

//     test('ProxyProvider6', () async {
//       await tester.pumpComponent(
//         MultiProvider(
//           providers: [
//             Provider.value(value: a),
//             Provider.value(value: b),
//             Provider.value(value: c),
//             Provider.value(value: d),
//             Provider.value(value: e),
//             Provider.value(value: f),
//             ProxyProvider6<A, B, C, D, E, F, Combined>(
//               create: (_) => const Combined(),
//               update: (context, a, b, c, d, e, f, previous) => Combined(context, previous, a, b, c, d, e, f),
//             )
//           ],
//           child: mockConsumer,
//         ),
//       );

//       final context = findProxyProvider();

//       verify(
//         combinedConsumerMock(
//           Combined(context, const Combined(), a, b, c, d, e, f),
//         ),
//       ).called(1);
//     });
//   });
// }
