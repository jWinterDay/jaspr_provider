// import 'dart:async';

// import 'package:jaspr/jaspr.dart';
// import 'package:jaspr_provider/jaspr_provider.dart';
// import 'package:jaspr_test/jaspr_test.dart';

// import 'common.dart';

// void main() {
//   late ComponentTester tester;

//   setUpAll(() {
//     tester = ComponentTester.setUp();
//   });

//   test('works with MultiProvider', () async {
//     await tester.pumpComponent(
//       MultiProvider(
//         providers: [
//           Provider.value(
//             value: 42,
//           ),
//         ],
//         child: TextOf<int>(),
//       ),
//     );

//     expect(find.text('42'), findsOneComponent);
//   });

//   group('Provider.of', () {
//     test('throws if T is dynamic', () async {
//       await tester.pumpComponent(
//         Provider<dynamic>.value(
//           value: 42,
//           child: Container(),
//         ),
//       );

//       expect(
//         () => Provider.of<dynamic>(find.byType(Container).evaluate().single),
//         throwsAssertionError,
//       );
//     });

//     test(
//       'listen defaults to true when building widgets',
//       () async {
//         var buildCount = 0;
//         final child = Builder(
//           builder: (context) sync* {
//             buildCount++;
//             Provider.of<int>(context);
//             yield Container();
//           },
//         );

//         await tester.pumpComponent(
//           InheritedProvider<int>.value(
//             value: 42,
//             child: child,
//           ),
//         );

//         expect(buildCount, equals(1));

//         await tester.pumpComponent(
//           InheritedProvider<int>.value(
//             value: 24,
//             child: child,
//           ),
//         );

//         expect(buildCount, equals(2));
//       },
//     );
//     test(
//       'listen defaults to false outside of the widget tree',
//       () async {
//         var buildCount = 0;
//         final child = Builder(
//           builder: (context) sync* {
//             buildCount++;
//             yield Container();
//           },
//         );

//         await tester.pumpComponent(
//           InheritedProvider<int>.value(
//             value: 42,
//             child: child,
//           ),
//         );

//         final context = find.byComponent(child).evaluate().first;
//         Provider.of<int>(context, listen: false);
//         expect(buildCount, equals(1));

//         await tester.pumpComponent(
//           InheritedProvider<int>.value(
//             value: 24,
//             child: child,
//           ),
//         );

//         expect(buildCount, equals(1));
//       },
//     );
//     test(
//       "listen:false doesn't trigger rebuild",
//       () async {
//         var buildCount = 0;
//         final child = Builder(
//           builder: (context) sync* {
//             Provider.of<int>(context, listen: false);
//             buildCount++;
//             yield Container();
//           },
//         );

//         await tester.pumpComponent(
//           InheritedProvider<int>.value(
//             value: 42,
//             child: child,
//           ),
//         );

//         expect(buildCount, equals(1));

//         await tester.pumpComponent(
//           InheritedProvider<int>.value(
//             value: 24,
//             child: child,
//           ),
//         );

//         expect(buildCount, equals(1));
//       },
//     );
//     test(
//       'listen:true outside of the widget tree throws',
//       () async {
//         final child = Builder(
//           builder: (context) sync* {
//             yield Container();
//           },
//         );

//         await tester.pumpComponent(
//           InheritedProvider<int>.value(
//             value: 42,
//             child: child,
//           ),
//         );

//         final context = find.byComponent(child).evaluate().first;

//         expect(
//           () => Provider.of<int>(context, listen: true),
//           throwsAssertionError,
//         );
//       },
//     );
//   });

//   group('Provider', () {
//     test('throws if the provided value is a Listenable/Stream', () async {
//       expect(
//         () => Provider.value(
//           value: MyListenable(),
//           child: TextOf<MyListenable>(),
//         ),
//         throwsException,
//       );

//       expect(
//         () => Provider.value(
//           value: MyStream(),
//           child: TextOf<MyListenable>(),
//         ),
//         throwsException,
//       );

//       await runZonedGuarded(
//         () async {
//           await tester.pumpComponent(
//             Provider(
//               key: UniqueKey(),
//               create: (_) => MyListenable(),
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
//             Provider(
//               key: UniqueKey(),
//               create: (_) => MyStream(),
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
//         Provider.value(
//           value: MyListenable(),
//           child: TextOf<MyListenable>(),
//         ),
//       );

//       await tester.pumpComponent(
//         Provider.value(
//           value: MyStream(),
//           child: TextOf<MyStream>(),
//         ),
//       );
//     });

//     test('simple usage', () async {
//       var buildCount = 0;
//       int? value;
//       double? second;

//       // We voluntarily reuse the builder instance so that later call to
//       // pumpWidget don't call builder again unless subscribed to an
//       // inheritedWidget
//       final builder = Builder(
//         builder: (context) sync* {
//           buildCount++;
//           value = Provider.of<int>(context);
//           second = Provider.of<double>(context, listen: false);
//           yield Container();
//         },
//       );

//       await tester.pumpComponent(
//         Provider<double>.value(
//           value: 24,
//           child: Provider<int>.value(
//             value: 42,
//             child: builder,
//           ),
//         ),
//       );

//       expect(value, equals(42));
//       expect(second, equals(24.0));
//       expect(buildCount, equals(1));

//       // nothing changed
//       await tester.pumpComponent(
//         Provider<double>.value(
//           value: 24,
//           child: Provider<int>.value(
//             value: 42,
//             child: builder,
//           ),
//         ),
//       );
//       // didn't rebuild
//       expect(buildCount, equals(1));

//       // changed a value we are subscribed to
//       await tester.pumpComponent(
//         Provider<double>.value(
//           value: 24,
//           child: Provider<int>.value(
//             value: 43,
//             child: builder,
//           ),
//         ),
//       );
//       expect(value, equals(43));
//       expect(second, equals(24.0));
//       // got rebuilt
//       expect(buildCount, equals(2));

//       // changed a value we are _not_ subscribed to
//       await tester.pumpComponent(
//         Provider<double>.value(
//           value: 20,
//           child: Provider<int>.value(
//             value: 43,
//             child: builder,
//           ),
//         ),
//       );
//       // didn't get rebuilt
//       expect(buildCount, equals(2));
//     });

//     test('throws an error if no provider found', () async {
//       await runZonedGuarded(
//         () async {
//           await tester.pumpComponent(Builder(builder: (context) sync* {
//             Provider.of<String>(context);
//             yield Container();
//           }));
//           expect(false, isTrue);
//         },
//         (error, stack) {
//           expect(
//             error,
//             isA<ProviderNotFoundException>()
//                 .having((err) => err.valueType, 'valueType', String)
//                 .having((err) => err.componentType, 'widgetType', Builder),
//           );
//         },
//       );
//     });

//     test('update should notify', () async {
//       int? old;
//       int? curr;
//       var callCount = 0;
//       bool updateShouldNotify(int o, int c) {
//         callCount++;
//         old = o;
//         curr = c;
//         return o != c;
//       }

//       var buildCount = 0;
//       int? buildValue;
//       final builder = Builder(
//         builder: (context) sync* {
//           buildValue = context.watch<int>();
//           buildCount++;
//           yield Container();
//         },
//       );

//       await tester.pumpComponent(
//         Provider<int>.value(
//           value: 24,
//           updateShouldNotify: updateShouldNotify,
//           child: builder,
//         ),
//       );
//       expect(callCount, equals(0));
//       expect(buildCount, equals(1));
//       expect(buildValue, equals(24));

//       // value changed
//       await tester.pumpComponent(
//         Provider<int>.value(
//           value: 25,
//           updateShouldNotify: updateShouldNotify,
//           child: builder,
//         ),
//       );
//       expect(callCount, equals(1));
//       expect(old, equals(24));
//       expect(curr, equals(25));
//       expect(buildCount, equals(2));
//       expect(buildValue, equals(25));

//       // value didn't change
//       await tester.pumpComponent(
//         Provider<int>.value(
//           value: 25,
//           updateShouldNotify: updateShouldNotify,
//           child: builder,
//         ),
//       );
//       expect(callCount, equals(2));
//       expect(old, equals(25));
//       expect(curr, equals(25));
//       expect(buildCount, equals(2));
//     });
//   });

//   test('sound provide T inject T?', () async {
//     late double? value;

//     final builder = Builder(
//       builder: (context) sync* {
//         // Look up a Provider<double>.
//         value = Provider.of<double?>(context, listen: false);
//         yield Container();
//       },
//     );

//     await tester.pumpComponent(
//       // Install a Provider<double>.
//       Provider<double>.value(
//         value: 24,
//         child: Provider<int>.value(
//           value: 42,
//           child: builder,
//         ),
//       ),
//     );

//     // Provider<double> not found, uses Provider<double?> instead.
//     expect(value, equals(24.0));
//   });

//   test('sound provide T inject T', () async {
//     late double? value;

//     final builder = Builder(
//       builder: (context) sync* {
//         // Look up a Provider<double>.
//         value = Provider.of<double>(context, listen: false);
//         yield Container();
//       },
//     );

//     await tester.pumpComponent(
//       // Install a Provider<double>.
//       Provider<double>.value(
//         value: 24,
//         child: Provider<int>.value(
//           value: 42,
//           child: builder,
//         ),
//       ),
//     );

//     // Provider<double> not found, uses Provider<double?> instead.
//     expect(value, equals(24.0));
//   });

//   test('sound provide T? inject T', () async {
//     late double? value;

//     final builder = Builder(
//       builder: (context) sync* {
//         // Look up a Provider<double>.
//         value = Provider.of<double>(context, listen: false);
//         yield Container();
//       },
//     );

//     await tester.pumpComponent(
//       // Install a Provider<double?>.
//       Provider<double?>.value(
//         value: 24,
//         child: Provider<int>.value(
//           value: 42,
//           child: builder,
//         ),
//       ),
//     );

//     // Provider<double> not found, uses Provider<double?> instead.
//     expect(value, equals(24.0));
//   });

//   test('sound provide T? inject T?', () async {
//     late double? value;

//     final builder = Builder(
//       builder: (context) sync* {
//         // Look up a Provider<double>.
//         value = Provider.of<double?>(context, listen: false);
//         yield Container();
//       },
//     );

//     await tester.pumpComponent(
//       // Install a Provider<double?>.
//       Provider<double?>.value(
//         value: 24,
//         child: Provider<int>.value(
//           value: 42,
//           child: builder,
//         ),
//       ),
//     );

//     // Provider<double> not found, uses Provider<double?> instead.
//     expect(value, equals(24.0));
//   });

//   test('sound provide null T? inject T?', () async {
//     late double? value;

//     final builder = Builder(
//       builder: (context) sync* {
//         // Look up a Provider<double>.
//         value = Provider.of<double?>(context, listen: false);
//         yield Container();
//       },
//     );

//     await tester.pumpComponent(
//       // Install a Provider<double?>.
//       Provider<double?>.value(
//         value: null,
//         child: Provider<int>.value(
//           value: 42,
//           child: builder,
//         ),
//       ),
//     );

//     // Provider<double> not found, uses Provider<double?> instead.
//     expect(value, equals(null));
//   });
// }
