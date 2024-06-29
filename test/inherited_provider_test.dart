// import 'dart:async';

// import 'package:jaspr/jaspr.dart';
// import 'package:jaspr_provider/jaspr_provider.dart';
// import 'package:jaspr_provider/src/provider.dart';
// import 'package:jaspr_test/jaspr_test.dart';
// // ignore: import_of_legacy_library_into_null_safe
// import 'package:mockito/mockito.dart';

// import 'common.dart';

// class Context extends StatelessComponent {
//   const Context({Key? key}) : super(key: key);

//   @override
//   Iterable<Component> build(BuildContext context) sync* {
//     yield Container();
//   }
// }

// BuildContext get context => find.byType(Context).evaluate().single;

// T of<T>([BuildContext? c]) => Provider.of<T>(c ?? context, listen: false);

// void main() {
//   late ComponentTester tester;

//   setUpAll(() {
//     tester = ComponentTester.setUp();
//   });

//   test('regression test #377', () async {
//     await tester.pumpComponent(
//       MultiProvider(
//         providers: [
//           StateNotifierProvider<_Controller1, Counter1>(
//             create: (context) => _Controller1(),
//           ),
//           StateNotifierProvider<_Controller2, Counter2>(
//             create: (context) => _Controller2(),
//           ),
//         ],
//         child: Consumer<Counter2>(
//           builder: (c, value, _) sync* {
//             yield Text('${value.count}');
//           },
//         ),
//       ),
//     );
//   });

//   test('rebuild on dependency flags update', () async {
//     await tester.pumpComponent(
//       InheritedProvider<int>(
//         lazy: false,
//         update: (context, value) {
//           assert(!debugIsInInheritedProviderCreate);
//           assert(debugIsInInheritedProviderUpdate);
//           return 0;
//         },
//         child: Container(),
//       ),
//     );

//     await tester.pumpComponent(
//       InheritedProvider<int>(
//         lazy: false,
//         update: (context, value) {
//           assert(!debugIsInInheritedProviderCreate);
//           assert(debugIsInInheritedProviderUpdate);
//           return 0;
//         },
//         child: Container(),
//       ),
//     );
//   });

//   test('properly update debug flags if a create triggers another deferred create', () async {
//     await tester.pumpComponent(
//       MultiProvider(
//         providers: [
//           DeferredInheritedProvider<double, double>(
//             create: (context) {
//               assert(debugIsInInheritedProviderCreate);
//               assert(!debugIsInInheritedProviderUpdate);
//               return 42.0;
//             },
//             startListening: (_, setState, c, __) {
//               setState(c);
//               return () {};
//             },
//           ),
//           DeferredInheritedProvider<int, int>(
//             create: (context) {
//               assert(debugIsInInheritedProviderCreate);
//               assert(!debugIsInInheritedProviderUpdate);
//               return context.read<double>().round();
//             },
//             startListening: (_, setState, c, __) {
//               setState(c);
//               return () {};
//             },
//           ),
//           InheritedProvider<String>(
//             lazy: false,
//             update: (context, value) {
//               assert(!debugIsInInheritedProviderCreate);
//               assert(debugIsInInheritedProviderUpdate);
//               context.watch<double>();

//               assert(!debugIsInInheritedProviderCreate);
//               assert(debugIsInInheritedProviderUpdate);
//               return context.watch<int>().toString();
//             },
//           ),
//         ],
//         child: Container(),
//       ),
//     );
//   });

//   test('properly update debug flags if a create triggers another deferred create', () async {
//     await tester.pumpComponent(
//       MultiProvider(
//         providers: [
//           DeferredInheritedProvider<double, double>(
//             create: (context) {
//               assert(debugIsInInheritedProviderCreate);
//               assert(!debugIsInInheritedProviderUpdate);
//               return 42.0;
//             },
//             startListening: (_, setState, c, __) {
//               setState(c);
//               return () {};
//             },
//           ),
//           DeferredInheritedProvider<int, int>(
//             create: (context) {
//               assert(debugIsInInheritedProviderCreate);
//               assert(!debugIsInInheritedProviderUpdate);
//               return context.read<double>().round();
//             },
//             startListening: (_, setState, c, __) {
//               setState(c);
//               return () {};
//             },
//           ),
//           InheritedProvider<String>(
//             lazy: false,
//             create: (context) {
//               assert(debugIsInInheritedProviderCreate);
//               assert(!debugIsInInheritedProviderUpdate);
//               context.read<double>();
//               assert(debugIsInInheritedProviderCreate);
//               assert(!debugIsInInheritedProviderUpdate);

//               return context.read<int>().toString();
//             },
//           ),
//         ],
//         child: Container(),
//       ),
//     );
//   });

//   test('properly update debug flags if an update triggers another create/update', () async {
//     await tester.pumpComponent(
//       MultiProvider(
//         providers: [
//           InheritedProvider<double>(
//             create: (context) {
//               assert(debugIsInInheritedProviderCreate);
//               assert(!debugIsInInheritedProviderUpdate);
//               return 42.0;
//             },
//             update: (context, _) {
//               assert(!debugIsInInheritedProviderCreate);
//               assert(debugIsInInheritedProviderUpdate);
//               return 42.0;
//             },
//           ),
//           InheritedProvider<int>(
//             create: (context) {
//               assert(debugIsInInheritedProviderCreate);
//               assert(!debugIsInInheritedProviderUpdate);
//               return context.read<double>().round();
//             },
//             update: (context, _) {
//               assert(!debugIsInInheritedProviderCreate);
//               assert(debugIsInInheritedProviderUpdate);
//               return context.watch<double>().round();
//             },
//           ),
//           InheritedProvider<String>(
//             lazy: false,
//             update: (context, value) {
//               assert(!debugIsInInheritedProviderCreate);
//               assert(debugIsInInheritedProviderUpdate);
//               context.watch<double>();

//               assert(!debugIsInInheritedProviderCreate);
//               assert(debugIsInInheritedProviderUpdate);
//               return context.watch<int>().toString();
//             },
//           ),
//         ],
//         child: Container(),
//       ),
//     );
//   });

//   test('properly update debug flags if a create triggers another create/update', () async {
//     await tester.pumpComponent(
//       MultiProvider(
//         providers: [
//           InheritedProvider<double>(
//             create: (context) {
//               assert(debugIsInInheritedProviderCreate);
//               assert(!debugIsInInheritedProviderUpdate);
//               return 42.0;
//             },
//             update: (context, _) {
//               assert(!debugIsInInheritedProviderCreate);
//               assert(debugIsInInheritedProviderUpdate);
//               return 42.0;
//             },
//           ),
//           InheritedProvider<int>(
//             create: (context) {
//               assert(debugIsInInheritedProviderCreate);
//               assert(!debugIsInInheritedProviderUpdate);
//               return context.read<double>().round();
//             },
//             update: (context, _) {
//               assert(!debugIsInInheritedProviderCreate);
//               assert(debugIsInInheritedProviderUpdate);
//               return context.watch<double>().round();
//             },
//           ),
//           InheritedProvider<String>(
//             lazy: false,
//             create: (context) {
//               assert(debugIsInInheritedProviderCreate);
//               assert(!debugIsInInheritedProviderUpdate);
//               context.read<double>();
//               assert(debugIsInInheritedProviderCreate);
//               assert(!debugIsInInheritedProviderUpdate);

//               return context.read<int>().toString();
//             },
//             update: (context, value) {
//               assert(!debugIsInInheritedProviderCreate);
//               assert(debugIsInInheritedProviderUpdate);
//               context.watch<double>();

//               assert(!debugIsInInheritedProviderCreate);
//               assert(debugIsInInheritedProviderUpdate);
//               return context.watch<int>().toString();
//             },
//           ),
//         ],
//         child: Container(),
//       ),
//     );
//   });

//   test('Provider.of(listen: false) outside of build works when it loads a provider', () async {
//     final notifier = ValueNotifier(42);
//     await tester.pumpComponent(
//       MultiProvider(
//         providers: [
//           ChangeNotifierProvider.value(value: notifier),
//           ProxyProvider<ValueNotifier<int>, String>(update: (a, b, c) {
//             return '${b.value}';
//           }),
//         ],
//         child: const Context(),
//       ),
//     );

//     expect(Provider.of<String>(context, listen: false), '42');

//     notifier.value = 21;
//     await tester.pump();

//     expect(Provider.of<String>(context, listen: false), '21');
//   });

//   test('new value is available in didChangeDependencies', () async {
//     final didChangeDependencies = ValueBuilderMock<int>(-1);
//     final build = ValueBuilderMock<int>(-1);

//     await tester.pumpComponent(
//       InheritedProvider.value(
//         value: 0,
//         child: Test<int>(
//           didChangeDependencies: didChangeDependencies,
//           build: build,
//         ),
//       ),
//     );
//     verify(didChangeDependencies(argThat(isNotNull), 0)).called(1);
//     verify(build(argThat(isNotNull), 0)).called(1);

//     verifyNoMoreInteractions(didChangeDependencies);
//     verifyNoMoreInteractions(build);

//     await tester.pumpComponent(
//       InheritedProvider.value(
//         value: 1,
//         child: Test<int>(
//           didChangeDependencies: didChangeDependencies,
//           build: build,
//         ),
//       ),
//     );
//     verify(didChangeDependencies(argThat(isNotNull), 1)).called(1);
//     verify(build(argThat(isNotNull), 1)).called(1);
//     verifyNoMoreInteractions(didChangeDependencies);
//     verifyNoMoreInteractions(build);
//   });

//   test('builder receives the current value and updates independently from `update`', () async {
//     final child = Container();

//     final notifier = ValueNotifier(0);
//     final builder = TransitionBuilderMock((c, child) sync* {
//       final notifier = Provider.of<ValueNotifier<int>>(c);
//       yield Text(
//         '${notifier.value}',
//       );
//     });

//     await tester.pumpComponent(
//       ChangeNotifierProvider.value(
//         value: notifier,
//         builder: builder,
//         child: child,
//       ),
//     );

//     verify(builder(argThat(isNotNull), child)).called(1);
//     verifyNoMoreInteractions(builder);
//     expect(find.text('0'), findsOneComponent);

//     notifier.value++;
//     await tester.pump();

//     verify(builder(argThat(isNotNull), child)).called(1);
//     verifyNoMoreInteractions(builder);
//     expect(find.text('1'), findsOneComponent);
//   });

//   test('builder can _not_ rebuild when provider updates', () async {
//     final child = Container();

//     final notifier = ValueNotifier(0);
//     final builder = TransitionBuilderMock((c, child) sync* {
//       yield const Text('foo');
//     });

//     await tester.pumpComponent(
//       ChangeNotifierProvider.value(
//         value: notifier,
//         builder: builder,
//         child: child,
//       ),
//     );

//     verify(builder(argThat(isNotNull), child)).called(1);
//     verifyNoMoreInteractions(builder);
//     expect(find.text('foo'), findsOneComponent);

//     notifier.value++;
//     await tester.pump();

//     verifyNoMoreInteractions(builder);
//     expect(find.text('foo'), findsOneComponent);
//   });

//   test('builder rebuilds if provider is recreated', () async {
//     final child = Container();

//     final notifier = ValueNotifier(0);
//     final builder = TransitionBuilderMock((c, child) sync* {
//       yield const Text('foo');
//     });

//     await tester.pumpComponent(
//       ChangeNotifierProvider.value(
//         value: notifier,
//         builder: builder,
//         child: child,
//       ),
//     );

//     verify(builder(argThat(isNotNull), child)).called(1);
//     verifyNoMoreInteractions(builder);
//     expect(find.text('foo'), findsOneComponent);

//     await tester.pumpComponent(
//       ChangeNotifierProvider.value(
//         value: notifier,
//         builder: builder,
//         child: child,
//       ),
//     );

//     verify(builder(argThat(isNotNull), child)).called(1);
//     verifyNoMoreInteractions(builder);
//     expect(find.text('foo'), findsOneComponent);
//   });

//   test('provider.of throws if listen:true outside of the widget tree', () async {
//     await tester.pumpComponent(
//       InheritedProvider<int>.value(
//         value: 42,
//         child: const Context(),
//       ),
//     );

//     expect(
//       () => Provider.of<int>(context),
//       throwsA(
//         isA<AssertionError>().having(
//           (source) => source.toString(),
//           'toString',
//           endsWith('''
// Tried to listen to a value exposed with provider, from outside of the widget tree.

// This is likely caused by an event handler (like a button's onPressed) that called
// Provider.of without passing `listen: false`.

// To fix, write:
// Provider.of<int>(context, listen: false);

// It is unsupported because may pointlessly rebuild the widget associated to the
// event handler, when the widget tree doesn't care about the value.

// The context used was: Context
// '''),
//         ),
//       ),
//     );

//     expect(Provider.of<int>(context, listen: false), equals(42));
//   });

//   test('InheritedProvider throws if no child is provided with default constructor', () async {
//     await runZonedGuarded(
//       () async {
//         await tester.pumpComponent(
//           InheritedProvider<int>(
//             create: (_) => 42,
//           ),
//         );
//       },
//       (error, stack) {
//         expect(
//           error,
//           isA<AssertionError>().having(
//             (source) => source.toString(),
//             'toString',
//             contains('InheritedProvider<int> used outside of MultiProvider must specify a child'),
//           ),
//         );
//       },
//     );
//   });

//   test('InheritedProvider throws if no child is provided with value constructor', () async {
//     await runZonedGuarded(
//       () async {
//         await tester.pumpComponent(
//           InheritedProvider<int>.value(
//             value: 42,
//           ),
//         );
//       },
//       (error, stack) {
//         expect(
//           error,
//           isA<AssertionError>().having(
//             (source) => source.toString(),
//             'toString',
//             contains('InheritedProvider<int> used outside of MultiProvider must specify a child'),
//           ),
//         );
//       },
//     );
//   });

//   test('DeferredInheritedProvider throws if no child is provided with default constructor', () async {
//     await runZonedGuarded(
//       () async {
//         await tester.pumpComponent(
//           DeferredInheritedProvider<int, int>(
//             create: (_) => 42,
//             startListening: (_, __, ___, ____) {
//               return () {};
//             },
//           ),
//         );
//       },
//       (error, stack) {
//         expect(
//           error,
//           isA<AssertionError>().having(
//             (source) => source.toString(),
//             'toString',
//             contains('DeferredInheritedProvider<int, int> used outside of MultiProvider must specify a child'),
//           ),
//         );
//       },
//     );
//   });

//   test('DeferredInheritedProvider throws if no child is provided with value constructor', () async {
//     await runZonedGuarded(
//       () async {
//         await tester.pumpComponent(
//           DeferredInheritedProvider<int, int>.value(
//             value: 42,
//             startListening: (_, __, ___, ____) {
//               return () {};
//             },
//           ),
//         );
//       },
//       (error, stack) {
//         expect(
//           error,
//           isA<AssertionError>().having(
//             (source) => source.toString(),
//             'toString',
//             contains('DeferredInheritedProvider<int, int> used outside of MultiProvider must specify a child'),
//           ),
//         );
//       },
//     );
//   });

//   group('diagnostics', () {
//     test('InheritedProvider.value', () async {
//       await tester.pumpComponent(
//         InheritedProvider<int>.value(
//           value: 42,
//           startListening: (_, __) => throw Error(),
//           child: Container(),
//         ),
//       );

//       final rootElement = find.byElementPredicate((_) => true).first;

//       expect(
//         rootElement.toString(),
//         contains('InheritedProvider<int>(value: 42)'),
//       );

//       await tester.pumpComponent(
//         InheritedProvider<int>.value(
//           value: 42,
//           startListening: (_, __) => () {},
//           child: TextOf<int>(),
//         ),
//       );

//       expect(
//         rootElement.toString(),
//         contains('InheritedProvider<int>(value: 42, listening to value)'),
//       );
//     });

//     test("InheritedProvider doesn't break lazy loading", () async {
//       await tester.pumpComponent(
//         InheritedProvider<int>(
//           create: (_) => 42,
//           child: Container(),
//         ),
//       );

//       final rootElement = find.byElementPredicate((_) => true).first;

//       expect(
//         rootElement.toString(),
//         contains('InheritedProvider<int>(value: <not yet loaded>)'),
//       );

//       Provider.of<int>(find.byType(Container).evaluate().single, listen: false);

//       expect(
//         rootElement.toString(),
//         contains('InheritedProvider<int>(value: 42)'),
//       );
//     });

//     test('InheritedProvider show if listening', () async {
//       await tester.pumpComponent(
//         InheritedProvider<int>(
//           create: (_) => 24,
//           startListening: (_, __) => () {},
//           child: Container(),
//         ),
//       );

//       final rootElement = find.byElementPredicate((element) => true).first;

//       expect(
//         rootElement.toString(),
//         contains('InheritedProvider<int>(value: <not yet loaded>)'),
//       );

//       Provider.of<int>(find.byType(Container).evaluate().single, listen: false);

//       expect(
//         rootElement.toString(),
//         contains('InheritedProvider<int>(value: 24, listening to value)'),
//       );
//     });

//     test('DeferredInheritedProvider.value', () async {
//       await tester.pumpComponent(
//         DeferredInheritedProvider<int, int>.value(
//           value: 42,
//           startListening: (_, setState, __, ___) {
//             setState(24);
//             return () {};
//           },
//           child: Container(),
//         ),
//       );

//       final rootElement = find.byElementPredicate((element) => true).first;

//       expect(
//         rootElement.toString(),
//         contains(
//           '''
// DeferredInheritedProvider<int, int>(controller: 42, value: <not yet loaded>)''',
//         ),
//       );

//       Provider.of<int>(find.byType(Container).evaluate().single, listen: false);

//       expect(
//         rootElement.toString(),
//         contains('''
// DeferredInheritedProvider<int, int>(controller: 42, value: 24)'''),
//       );
//     });

//     test('DeferredInheritedProvider', () async {
//       await tester.pumpComponent(
//         DeferredInheritedProvider<int, int>(
//           create: (_) => 42,
//           startListening: (_, setState, __, ___) {
//             setState(24);
//             return () {};
//           },
//           child: Container(),
//         ),
//       );

//       final rootElement = find.byElementPredicate((element) => true).first;

//       expect(
//         rootElement.toString(),
//         contains(
//           '''
// DeferredInheritedProvider<int, int>(controller: <not yet loaded>, value: <not yet loaded>)''',
//         ),
//       );

//       Provider.of<int>(find.byType(Container).evaluate().single, listen: false);

//       expect(
//         rootElement.toString(),
//         contains('''
// DeferredInheritedProvider<int, int>(controller: 42, value: 24)'''),
//       );
//     });
//   });

//   group('InheritedProvider.value()', () {
//     test('markNeedsNotifyDependents during startListening is noop', () async {
//       await tester.pumpComponent(
//         InheritedProvider<int>.value(
//           value: 42,
//           startListening: (e, value) {
//             e.markNeedsNotifyDependents();
//             return () {};
//           },
//           child: TextOf<int>(),
//         ),
//       );
//     });

//     test('startListening called again when create returns new value', () async {
//       final stopListening = StopListeningMock();
//       final startListening = StartListeningMock<int>(stopListening);

//       await tester.pumpComponent(
//         InheritedProvider<int>.value(
//           value: 42,
//           startListening: startListening,
//           child: TextOf<int>(),
//         ),
//       );

//       final element = findInheritedContext<int>();

//       verify(startListening(element, 42)).called(1);
//       verifyNoMoreInteractions(startListening);
//       verifyZeroInteractions(stopListening);

//       final stopListening2 = StopListeningMock();
//       final startListening2 = StartListeningMock<int>(stopListening2);

//       await tester.pumpComponent(
//         InheritedProvider<int>.value(
//           value: 24,
//           startListening: startListening2,
//           child: TextOf<int>(),
//         ),
//       );

//       verifyNoMoreInteractions(startListening);
//       verifyInOrder([
//         stopListening(),
//         startListening2(element, 24),
//       ]);
//       verifyNoMoreInteractions(startListening2);
//       verifyZeroInteractions(stopListening2);

//       await tester.pumpComponent(Container());

//       verifyNoMoreInteractions(startListening);
//       verify(stopListening2()).called(1);
//     });

//     test('startListening', () async {
//       final stopListening = StopListeningMock();
//       final startListening = StartListeningMock<int>(stopListening);

//       await tester.pumpComponent(
//         InheritedProvider<int>.value(
//           value: 42,
//           startListening: startListening,
//           child: Container(),
//         ),
//       );

//       verifyZeroInteractions(startListening);

//       await tester.pumpComponent(
//         InheritedProvider<int>.value(
//           value: 42,
//           startListening: startListening,
//           child: TextOf<int>(),
//         ),
//       );

//       final element = findInheritedContext<int>();

//       verify(startListening(element, 42)).called(1);
//       verifyNoMoreInteractions(startListening);
//       verifyZeroInteractions(stopListening);

//       await tester.pumpComponent(
//         InheritedProvider<int>.value(
//           value: 42,
//           startListening: startListening,
//           child: TextOf<int>(),
//         ),
//       );

//       verifyNoMoreInteractions(startListening);
//       verifyZeroInteractions(stopListening);

//       await tester.pumpComponent(Container());

//       verifyNoMoreInteractions(startListening);
//       verify(stopListening()).called(1);
//     });

//     test(
//       "stopListening not called twice if rebuild doesn't have listeners",
//       () async {
//         final stopListening = StopListeningMock();
//         final startListening = StartListeningMock<int>(stopListening);

//         await tester.pumpComponent(
//           InheritedProvider<int>.value(
//             value: 42,
//             startListening: startListening,
//             child: TextOf<int>(),
//           ),
//         );
//         verify(startListening(argThat(isNotNull), 42)).called(1);
//         verifyZeroInteractions(stopListening);

//         final stopListening2 = StopListeningMock();
//         final startListening2 = StartListeningMock<int>(stopListening2);
//         await tester.pumpComponent(
//           InheritedProvider<int>.value(
//             value: 24,
//             startListening: startListening2,
//             child: Container(),
//           ),
//         );

//         verifyNoMoreInteractions(startListening);
//         verify(stopListening()).called(1);
//         verifyZeroInteractions(startListening2);
//         verifyZeroInteractions(stopListening2);

//         await tester.pumpComponent(Container());

//         verifyNoMoreInteractions(startListening);
//         verifyNoMoreInteractions(stopListening);
//         verifyZeroInteractions(startListening2);
//         verifyZeroInteractions(stopListening2);
//       },
//     );

//     test('pass down current value', () async {
//       int? value;
//       final child = Consumer<int>(
//         builder: (_, v, __) sync* {
//           value = v;
//           yield Container();
//         },
//       );

//       await tester.pumpComponent(
//         InheritedProvider<int>.value(value: 42, child: child),
//       );

//       expect(value, equals(42));

//       await tester.pumpComponent(
//         InheritedProvider<int>.value(value: 43, child: child),
//       );

//       expect(value, equals(43));
//     });

//     test('default updateShouldNotify', () async {
//       var buildCount = 0;

//       final child = Consumer<int>(builder: (_, __, ___) sync* {
//         buildCount++;
//         yield Container();
//       });

//       await tester.pumpComponent(
//         InheritedProvider<int>.value(value: 42, child: child),
//       );
//       expect(buildCount, equals(1));

//       await tester.pumpComponent(
//         InheritedProvider<int>.value(value: 42, child: child),
//       );
//       expect(buildCount, equals(1));

//       await tester.pumpComponent(
//         InheritedProvider<int>.value(value: 43, child: child),
//       );
//       expect(buildCount, equals(2));
//     });

//     test('custom updateShouldNotify', () async {
//       var buildCount = 0;
//       final updateShouldNotify = UpdateShouldNotifyMock<int>();

//       final child = Consumer<int>(builder: (_, __, ___) sync* {
//         buildCount++;
//         yield Container();
//       });

//       await tester.pumpComponent(
//         InheritedProvider<int>.value(
//           value: 42,
//           updateShouldNotify: updateShouldNotify,
//           child: child,
//         ),
//       );
//       expect(buildCount, equals(1));
//       verifyZeroInteractions(updateShouldNotify);

//       when(updateShouldNotify(any, any)).thenReturn(false);
//       await tester.pumpComponent(
//         InheritedProvider<int>.value(
//           value: 43,
//           updateShouldNotify: updateShouldNotify,
//           child: child,
//         ),
//       );
//       expect(buildCount, equals(1));
//       verify(updateShouldNotify(42, 43)).called(1);

//       when(updateShouldNotify(any, any)).thenReturn(true);
//       await tester.pumpComponent(
//         InheritedProvider<int>.value(
//           value: 44,
//           updateShouldNotify: updateShouldNotify,
//           child: child,
//         ),
//       );
//       expect(buildCount, equals(2));
//       verify(updateShouldNotify(43, 44)).called(1);

//       verifyNoMoreInteractions(updateShouldNotify);
//     });
//   });

//   group('InheritedProvider()', () {
//     test('hasValue', () async {
//       await tester.pumpComponent(InheritedProvider(
//         create: (_) => 42,
//         child: const Context(),
//       ));

//       final inheritedContext = find
//           .byElementPredicate((e) {
//             return e is InheritedContext;
//           })
//           .evaluate()
//           .single as InheritedContext;

//       expect(inheritedContext.hasValue, isFalse);

//       inheritedContext.value;

//       expect(inheritedContext.hasValue, isTrue);
//     });

//     test('provider calls update if rebuilding only due to didChangeDependencies', () async {
//       final mock = ValueBuilderMock<String>('');

//       final provider = ProxyProvider0<String>(
//         create: (_) => '',
//         update: (c, p) {
//           mock(c, p);
//           return c.watch<int>().toString();
//         },
//         child: TextOf<String>(),
//       );

//       await tester.pumpComponent(Provider.value(value: 0, child: provider));

//       expect(find.text('0'), findsOneComponent);
//       verify(mock(any, '')).called(1);
//       verifyNoMoreInteractions(mock);

//       await tester.pumpComponent(Provider.value(value: 1, child: provider));

//       expect(find.text('1'), findsOneComponent);
//       verify(mock(any, '0')).called(1);
//       verifyNoMoreInteractions(mock);
//     });

//     test("provider notifying dependents doesn't call update", () async {
//       final notifier = ValueNotifier(0);
//       final mock = ValueBuilderMock<ValueNotifier<int>>(notifier);

//       await tester.pumpComponent(
//         ChangeNotifierProxyProvider0<ValueNotifier<int>>(
//           create: (_) => notifier,
//           update: mock,
//           child: TextOf<ValueNotifier<int>>(),
//         ),
//       );

//       verify(mock(any, notifier)).called(1);
//       verifyNoMoreInteractions(mock);

//       notifier.value++;
//       await tester.pump();

//       verifyNoMoreInteractions(mock);

//       await tester.pumpComponent(
//         ChangeNotifierProxyProvider0<ValueNotifier<int>>(
//           create: (_) => notifier,
//           update: mock,
//           child: TextOf<ValueNotifier<int>>(),
//         ),
//       );

//       verify(mock(any, notifier)).called(1);
//       verifyNoMoreInteractions(mock);
//     });

//     test('update can call Provider.of with listen:true', () async {
//       await tester.pumpComponent(
//         InheritedProvider<int>.value(
//           value: 42,
//           child: InheritedProvider<String>(
//             update: (context, __) => Provider.of<int>(context).toString(),
//             child: TextOf<String>(),
//           ),
//         ),
//       );

//       expect(find.text('42'), findsOneComponent);
//     });

//     test('update lazy loaded can call Provider.of with listen:true', () async {
//       await tester.pumpComponent(
//         InheritedProvider<int>.value(
//           value: 42,
//           child: InheritedProvider<String>(
//             update: (context, __) => Provider.of<int>(context).toString(),
//             child: const Context(),
//           ),
//         ),
//       );

//       expect(Provider.of<String>(context, listen: false), equals('42'));
//     });

//     test('markNeedsNotifyDependents during startListening is noop', () async {
//       await tester.pumpComponent(
//         InheritedProvider<int>(
//           update: (_, __) => 24,
//           startListening: (e, value) {
//             e.markNeedsNotifyDependents();
//             return () {};
//           },
//           child: TextOf<int>(),
//         ),
//       );
//     });

//     test(
//       'update can obtain parent of the same type than self',
//       () async {
//         await tester.pumpComponent(
//           InheritedProvider<String>.value(
//             value: 'root',
//             child: InheritedProvider<String>(
//               update: (context, _) {
//                 return Provider.of(context);
//               },
//               child: TextOf<String>(),
//             ),
//           ),
//         );

//         expect(find.text('root'), findsOneComponent);
//       },
//     );
//     test('_debugCheckInvalidValueType', () async {
//       final checkType = DebugCheckValueTypeMock<int>();

//       await tester.pumpComponent(
//         InheritedProvider<int>(
//           create: (_) => 0,
//           update: (_, __) => 1,
//           debugCheckInvalidValueType: checkType,
//           child: TextOf<int>(),
//         ),
//       );

//       verifyInOrder([
//         checkType(0),
//         checkType(1),
//       ]);
//       verifyNoMoreInteractions(checkType);

//       await tester.pumpComponent(
//         InheritedProvider<int>(
//           create: (_) => 0,
//           update: (_, __) => 1,
//           debugCheckInvalidValueType: checkType,
//           child: TextOf<int>(),
//         ),
//       );

//       verifyNoMoreInteractions(checkType);

//       await tester.pumpComponent(
//         InheritedProvider<int>(
//           create: (_) => 0,
//           update: (_, __) => 2,
//           debugCheckInvalidValueType: checkType,
//           child: TextOf<int>(),
//         ),
//       );

//       verify(checkType(2)).called(1);
//       verifyNoMoreInteractions(checkType);
//     });

//     test('startListening', () async {
//       final stopListening = StopListeningMock();
//       final startListening = StartListeningMock<int>(stopListening);
//       final dispose = DisposeMock<int>();

//       await tester.pumpComponent(
//         InheritedProvider<int>(
//           update: (_, __) => 42,
//           startListening: startListening,
//           dispose: dispose,
//           child: TextOf<int>(),
//         ),
//       );

//       final element = findInheritedContext<int>();

//       verify(startListening(element, 42)).called(1);
//       verifyNoMoreInteractions(startListening);
//       verifyZeroInteractions(stopListening);
//       verifyZeroInteractions(dispose);

//       await tester.pumpComponent(
//         InheritedProvider<int>(
//           update: (_, __) => 42,
//           startListening: startListening,
//           dispose: dispose,
//           child: TextOf<int>(),
//         ),
//       );

//       verifyNoMoreInteractions(startListening);
//       verifyZeroInteractions(stopListening);
//       verifyZeroInteractions(dispose);

//       await tester.pumpComponent(Container());

//       verifyNoMoreInteractions(startListening);
//       verifyInOrder([
//         stopListening(),
//         dispose(element, 42),
//       ]);
//       verifyNoMoreInteractions(dispose);
//       verifyNoMoreInteractions(stopListening);
//     });

//     test('startListening called again when create returns new value', () async {
//       final stopListening = StopListeningMock();
//       final startListening = StartListeningMock<int>(stopListening);

//       await tester.pumpComponent(
//         InheritedProvider<int>(
//           update: (_, __) => 42,
//           startListening: startListening,
//           child: TextOf<int>(),
//         ),
//       );

//       final element = findInheritedContext<int>();

//       verify(startListening(element, 42)).called(1);
//       verifyNoMoreInteractions(startListening);
//       verifyZeroInteractions(stopListening);

//       final stopListening2 = StopListeningMock();
//       final startListening2 = StartListeningMock<int>(stopListening2);

//       await tester.pumpComponent(
//         InheritedProvider<int>(
//           update: (_, __) => 24,
//           startListening: startListening2,
//           child: TextOf<int>(),
//         ),
//       );

//       verifyNoMoreInteractions(startListening);
//       verifyInOrder([
//         stopListening(),
//         startListening2(element, 24),
//       ]);
//       verifyNoMoreInteractions(startListening2);
//       verifyZeroInteractions(stopListening2);

//       await tester.pumpComponent(Container());

//       verifyNoMoreInteractions(startListening);
//       verify(stopListening2()).called(1);
//     });

//     test(
//       "stopListening not called twice if rebuild doesn't have listeners",
//       () async {
//         final stopListening = StopListeningMock();
//         final startListening = StartListeningMock<int>(stopListening);

//         await tester.pumpComponent(
//           InheritedProvider<int>(
//             update: (_, __) => 42,
//             startListening: startListening,
//             child: TextOf<int>(),
//           ),
//         );
//         verify(startListening(argThat(isNotNull), 42)).called(1);
//         verifyZeroInteractions(stopListening);

//         final stopListening2 = StopListeningMock();
//         final startListening2 = StartListeningMock<int>(stopListening2);
//         await tester.pumpComponent(
//           InheritedProvider<int>(
//             update: (_, __) => 24,
//             startListening: startListening2,
//             child: Container(),
//           ),
//         );

//         verifyNoMoreInteractions(startListening);
//         verify(stopListening()).called(1);
//         verifyZeroInteractions(startListening2);
//         verifyZeroInteractions(stopListening2);

//         await tester.pumpComponent(Container());

//         verifyNoMoreInteractions(startListening);
//         verifyNoMoreInteractions(stopListening);
//         verifyZeroInteractions(startListening2);
//         verifyZeroInteractions(stopListening2);
//       },
//     );

//     test(
//       'fails if initialValueBuilder calls inheritFromElement/inheritFromWidgetOfExactType',
//       () async {
//         await runZonedGuarded(
//           () async {
//             await tester.pumpComponent(
//               InheritedProvider<int>.value(
//                 value: 42,
//                 child: InheritedProvider<double>(
//                   create: (context) => Provider.of<int>(context).toDouble(),
//                   child: Consumer<double>(
//                     builder: (_, __, ___) sync* {
//                       yield Container();
//                     },
//                   ),
//                 ),
//               ),
//             );
//           },
//           (error, stack) {
//             expect(tester, isAssertionError);
//           },
//         );
//       },
//     );

//     test(
//       'builder is called on every rebuild '
//       'and after a dependency change',
//       () async {
//         int? lastValue;
//         final child = Consumer<int>(
//           builder: (_, value, __) sync* {
//             lastValue = value;
//             yield Container();
//           },
//         );
//         final update = ValueBuilderMock<int>(-1);
//         when(update(any, any)).thenAnswer((i) => (i.positionalArguments[1] as int) * 2);

//         await tester.pumpComponent(
//           InheritedProvider<int>(
//             create: (_) => 42,
//             update: update,
//             child: Container(),
//           ),
//         );

//         final inheritedElement = findInheritedContext<int>();
//         verifyZeroInteractions(update);

//         await tester.pumpComponent(
//           InheritedProvider<int>(
//             create: (_) => 42,
//             update: update,
//             child: child,
//           ),
//         );

//         verify(update(inheritedElement, 42)).called(1);
//         expect(lastValue, equals(84));

//         await tester.pumpComponent(
//           InheritedProvider<int>(
//             create: (_) => 42,
//             update: update,
//             child: child,
//           ),
//         );

//         verify(update(inheritedElement, 84)).called(1);
//         expect(lastValue, equals(168));

//         verifyNoMoreInteractions(update);
//       },
//     );
//     test(
//       'builder with no updateShouldNotify use ==',
//       () async {
//         int? lastValue;
//         var buildCount = 0;
//         final child = Consumer<int?>(
//           builder: (_, value, __) sync* {
//             lastValue = value;
//             buildCount++;
//             yield Container();
//           },
//         );

//         await tester.pumpComponent(
//           InheritedProvider<int?>(
//             create: (_) => null,
//             update: (_, __) => 42,
//             child: child,
//           ),
//         );

//         expect(lastValue, equals(42));
//         expect(buildCount, equals(1));

//         await tester.pumpComponent(
//           InheritedProvider<int?>(
//             create: (_) => null,
//             update: (_, __) => 42,
//             child: child,
//           ),
//         );

//         expect(lastValue, equals(42));
//         expect(buildCount, equals(1));

//         await tester.pumpComponent(
//           InheritedProvider<int?>(
//             create: (_) => null,
//             update: (_, __) => 43,
//             child: child,
//           ),
//         );

//         expect(lastValue, equals(43));
//         expect(buildCount, equals(2));
//       },
//     );
//     test(
//       'builder calls updateShouldNotify callback',
//       () async {
//         final updateShouldNotify = UpdateShouldNotifyMock<int>();

//         int? lastValue;
//         var buildCount = 0;
//         final child = Consumer<int>(
//           builder: (_, value, __) sync* {
//             lastValue = value;
//             buildCount++;
//             yield Container();
//           },
//         );

//         await tester.pumpComponent(
//           InheritedProvider<int>(
//             update: (_, __) => 42,
//             updateShouldNotify: updateShouldNotify,
//             child: child,
//           ),
//         );

//         verifyZeroInteractions(updateShouldNotify);
//         expect(lastValue, equals(42));
//         expect(buildCount, equals(1));

//         when(updateShouldNotify(any, any)).thenReturn(true);
//         await tester.pumpComponent(
//           InheritedProvider<int>(
//             update: (_, __) => 42,
//             updateShouldNotify: updateShouldNotify,
//             child: child,
//           ),
//         );

//         verify(updateShouldNotify(42, 42)).called(1);
//         expect(lastValue, equals(42));
//         expect(buildCount, equals(2));

//         when(updateShouldNotify(any, any)).thenReturn(false);
//         await tester.pumpComponent(
//           InheritedProvider<int>(
//             update: (_, __) => 43,
//             updateShouldNotify: updateShouldNotify,
//             child: child,
//           ),
//         );

//         verify(updateShouldNotify(42, 43)).called(1);
//         expect(lastValue, equals(42));
//         expect(buildCount, equals(2));

//         verifyNoMoreInteractions(updateShouldNotify);
//       },
//     );
//     test('initialValue is transmitted to valueBuilder', () async {
//       int? lastValue;
//       await tester.pumpComponent(
//         InheritedProvider<int>(
//           create: (_) => 0,
//           update: (_, last) {
//             lastValue = last;
//             return 42;
//           },
//           child: const Context(),
//         ),
//       );

//       expect(of<int>(), equals(42));
//       expect(lastValue, equals(0));
//     });

//     test('calls builder again if dependencies change', () async {
//       final valueBuilder = ValueBuilderMock<int>(-1);

//       when(valueBuilder(any, any)).thenAnswer((invocation) {
//         return int.parse(Provider.of<String>(
//           invocation.positionalArguments.first as BuildContext,
//         ));
//       });

//       var buildCount = 0;
//       final child = InheritedProvider<int>(
//         create: (_) => 0,
//         update: valueBuilder,
//         child: Consumer<int>(
//           builder: (_, value, __) sync* {
//             buildCount++;
//             yield Text(
//               value.toString(),
//             );
//           },
//         ),
//       );

//       await tester.pumpComponent(
//         InheritedProvider<String>.value(
//           value: '42',
//           child: child,
//         ),
//       );

//       expect(buildCount, equals(1));
//       expect(find.text('42'), findsOneComponent);

//       await tester.pumpComponent(
//         InheritedProvider<String>.value(
//           value: '24',
//           child: child,
//         ),
//       );

//       expect(buildCount, equals(2));
//       expect(find.text('24'), findsOneComponent);

//       await tester.pumpComponent(
//         InheritedProvider<String>.value(
//           value: '24',
//           updateShouldNotify: (_, __) => true,
//           child: child,
//         ),
//       );

//       expect(buildCount, equals(2));
//       expect(find.text('24'), findsOneComponent);
//     });

//     test('exposes initialValue if valueBuilder is null', () async {
//       await tester.pumpComponent(
//         InheritedProvider<int>(
//           create: (_) => 42,
//           child: const Context(),
//         ),
//       );

//       expect(of<int>(), equals(42));
//     });

//     test('call dispose on unmount', () async {
//       final dispose = DisposeMock<int>();
//       await tester.pumpComponent(
//         InheritedProvider<int>(
//           update: (_, __) => 42,
//           dispose: dispose,
//           child: const Context(),
//         ),
//       );

//       expect(of<int>(), equals(42));

//       verifyZeroInteractions(dispose);

//       final context = findInheritedContext<int>();

//       await tester.pumpComponent(Container());

//       verify(dispose(context, 42)).called(1);
//       verifyNoMoreInteractions(dispose);
//     });

//     test('builder unmount, dispose not called if value never read', () async {
//       final dispose = DisposeMock<int>();

//       await tester.pumpComponent(
//         InheritedProvider<int>(
//           update: (_, __) => 42,
//           dispose: dispose,
//           child: Container(),
//         ),
//       );

//       await tester.pumpComponent(Container());

//       verifyZeroInteractions(dispose);
//     });

//     test('call dispose after new value', () async {
//       final dispose = DisposeMock<int>();
//       await tester.pumpComponent(
//         InheritedProvider<int>(
//           update: (_, __) => 42,
//           dispose: dispose,
//           child: const Context(),
//         ),
//       );

//       expect(of<int>(), equals(42));

//       final dispose2 = DisposeMock<int>();
//       await tester.pumpComponent(
//         InheritedProvider<int>(
//           update: (_, __) => 42,
//           dispose: dispose2,
//           child: Container(),
//         ),
//       );

//       verifyZeroInteractions(dispose);
//       verifyZeroInteractions(dispose2);

//       final context = findInheritedContext<int>();

//       final dispose3 = DisposeMock<int>();
//       await tester.pumpComponent(
//         InheritedProvider<int>(
//           update: (_, __) => 24,
//           dispose: dispose3,
//           child: Container(),
//         ),
//       );

//       verifyZeroInteractions(dispose);
//       verifyZeroInteractions(dispose3);
//       verify(dispose2(context, 42)).called(1);
//       verifyNoMoreInteractions(dispose);
//     });

//     test('valueBuilder works without initialBuilder', () async {
//       int? lastValue;
//       await tester.pumpComponent(
//         InheritedProvider<int>(
//           update: (_, last) {
//             lastValue = last;
//             return 42;
//           },
//           child: const Context(),
//         ),
//       );

//       expect(of<int>(), equals(42));
//       expect(lastValue, equals(null));

//       await tester.pumpComponent(
//         InheritedProvider<int>(
//           update: (_, last) {
//             lastValue = last;
//             return 24;
//           },
//           child: const Context(),
//         ),
//       );

//       expect(of<int>(), equals(24));
//       expect(lastValue, equals(42));
//     });
//     test('throws if both builder and initialBuilder are missing', () {
//       expect(
//         () => InheritedProvider<int>(child: Container()),
//         throwsAssertionError,
//       );
//     });

//     test('calls initialValueBuilder lazily once', () async {
//       final initialValueBuilder = InitialValueBuilderMock<int>(-1);
//       when(initialValueBuilder(any)).thenReturn(42);

//       await tester.pumpComponent(
//         InheritedProvider<int>(
//           create: initialValueBuilder,
//           child: const Context(),
//         ),
//       );

//       verifyZeroInteractions(initialValueBuilder);

//       final inheritedProviderElement = findInheritedContext<int>();

//       expect(of<int>(), equals(42));
//       verify(initialValueBuilder(inheritedProviderElement)).called(1);

//       await tester.pumpComponent(
//         InheritedProvider<int>(
//           create: initialValueBuilder,
//           child: const Context(),
//         ),
//       );

//       expect(of<int>(), equals(42));
//       verifyNoMoreInteractions(initialValueBuilder);
//     });
//   });

//   group('DeferredInheritedProvider.value()', () {
//     test('hasValue', () async {
//       await tester.pumpComponent(InheritedProvider.value(
//         value: 42,
//         child: Container(),
//       ));

//       final inheritedContext = find
//           .byElementPredicate((e) {
//             return e is InheritedContext;
//           })
//           .evaluate()
//           .single as InheritedContext;

//       expect(inheritedContext.hasValue, isTrue);

//       inheritedContext.value;

//       expect(inheritedContext.hasValue, isTrue);
//     });

//     test('startListening', () async {
//       final stopListening = StopListeningMock();
//       final startListening = DeferredStartListeningMock<ValueNotifier<int>, int>(
//         (e, setState, controller, value) {
//           setState(controller.value);
//           return stopListening;
//         },
//       );
//       final controller = ValueNotifier<int>(0);

//       await tester.pumpComponent(
//         DeferredInheritedProvider<ValueNotifier<int>, int>.value(
//           value: controller,
//           startListening: startListening,
//           child: const Context(),
//         ),
//       );

//       verifyZeroInteractions(startListening);

//       expect(of<int>(), equals(0));

//       verify(startListening(
//         argThat(isNotNull),
//         argThat(isNotNull),
//         controller,
//         null,
//       )).called(1);

//       expect(of<int>(), equals(0));
//       verifyNoMoreInteractions(startListening);
//       verifyZeroInteractions(stopListening);

//       await tester.pumpComponent(
//         DeferredInheritedProvider<ValueNotifier<int>, int>.value(
//           value: controller,
//           startListening: startListening,
//           child: const Context(),
//         ),
//       );

//       verifyNoMoreInteractions(startListening);
//       verifyZeroInteractions(stopListening);

//       await tester.pumpComponent(Container());

//       verifyNoMoreInteractions(startListening);
//       verify(stopListening()).called(1);
//     });

//     test("startListening doesn't need setState if already initialized", () async {
//       final startListening = DeferredStartListeningMock<ValueNotifier<int>, int>(
//         (e, setState, controller, value) {
//           setState(controller.value);
//           return () {};
//         },
//       );
//       final controller = ValueNotifier<int>(0);

//       await tester.pumpComponent(
//         DeferredInheritedProvider<ValueNotifier<int>, int>.value(
//           value: controller,
//           startListening: startListening,
//           child: TextOf<int>(),
//         ),
//       );

//       expect(find.text('0'), findsOneComponent);

//       final startListening2 = DeferredStartListeningMock<ValueNotifier<int>, int>();
//       when(startListening2(any, any, any, any)).thenReturn(() {});
//       final controller2 = ValueNotifier<int>(0);

//       await tester.pumpComponent(
//         DeferredInheritedProvider<ValueNotifier<int>, int>.value(
//           value: controller2,
//           startListening: startListening2,
//           child: TextOf<int>(),
//         ),
//       );

//       expect(
//         find.text('0'),
//         findsOneComponent,
//         reason: 'startListening2 did not call setState but startListening did',
//       );
//     });

//     test('setState without updateShouldNotify', () async {
//       void Function(int value)? setState;
//       var buildCount = 0;

//       await tester.pumpComponent(
//         DeferredInheritedProvider<int, int>.value(
//           value: 0,
//           startListening: (_, s, __, ___) {
//             setState = s;
//             setState!(0);
//             return () {};
//           },
//           child: Consumer<int>(
//             builder: (_, value, __) sync* {
//               buildCount++;
//               yield Text('$value');
//             },
//           ),
//         ),
//       );

//       expect(find.text('0'), findsOneComponent);
//       expect(buildCount, equals(1));

//       setState!(0);
//       await tester.pump();

//       expect(buildCount, equals(1));
//       expect(find.text('0'), findsOneComponent);

//       setState!(1);
//       await tester.pump();

//       expect(find.text('1'), findsOneComponent);
//       expect(buildCount, equals(2));

//       setState!(1);
//       await tester.pump();

//       expect(find.text('1'), findsOneComponent);
//       expect(buildCount, equals(2));
//     });

//     test('setState with updateShouldNotify', () async {
//       final updateShouldNotify = UpdateShouldNotifyMock<int>();
//       when(updateShouldNotify(any, any)).thenAnswer((i) {
//         return i.positionalArguments[0] != i.positionalArguments[1];
//       });
//       void Function(int value)? setState;
//       var buildCount = 0;

//       await tester.pumpComponent(
//         DeferredInheritedProvider<int, int>.value(
//           value: 0,
//           updateShouldNotify: updateShouldNotify,
//           startListening: (_, s, __, ___) {
//             setState = s;
//             setState!(0);
//             return () {};
//           },
//           child: Consumer<int>(
//             builder: (_, value, __) sync* {
//               buildCount++;
//               yield Text('$value');
//             },
//           ),
//         ),
//       );

//       expect(find.text('0'), findsOneComponent);
//       expect(buildCount, equals(1));
//       verifyZeroInteractions(updateShouldNotify);

//       setState!(0);
//       await tester.pump();

//       verify(updateShouldNotify(0, 0)).called(1);
//       verifyNoMoreInteractions(updateShouldNotify);
//       expect(buildCount, equals(1));
//       expect(find.text('0'), findsOneComponent);

//       setState!(1);
//       await tester.pump();

//       verify(updateShouldNotify(0, 1)).called(1);
//       verifyNoMoreInteractions(updateShouldNotify);
//       expect(find.text('1'), findsOneComponent);
//       expect(buildCount, equals(2));

//       setState!(1);
//       await tester.pump();

//       verify(updateShouldNotify(1, 1)).called(1);
//       verifyNoMoreInteractions(updateShouldNotify);
//       expect(find.text('1'), findsOneComponent);
//       expect(buildCount, equals(2));
//     });

//     test('startListening never leave the widget uninitialized', () async {
//       await runZonedGuarded(
//         () async {
//           final startListening = DeferredStartListeningMock<ValueNotifier<int>, int>();
//           when(startListening(any, any, any, any)).thenReturn(() {});
//           final controller = ValueNotifier<int>(0);

//           await tester.pumpComponent(
//             DeferredInheritedProvider<ValueNotifier<int>, int>.value(
//               value: controller,
//               startListening: startListening,
//               child: TextOf<int>(),
//             ),
//           );
//         },
//         (error, stack) {
//           expect(
//             error,
//             isAssertionError,
//             reason: 'startListening did not call setState',
//           );
//         },
//       );
//     });

//     test('startListening called again on controller change', () async {
//       var buildCount = 0;
//       final child = Consumer<int>(builder: (_, value, __) sync* {
//         buildCount++;
//         yield Text('$value');
//       });

//       final stopListening = StopListeningMock();
//       final startListening = DeferredStartListeningMock<ValueNotifier<int>, int>(
//         (e, setState, controller, value) {
//           setState(controller.value);
//           return stopListening;
//         },
//       );
//       final controller = ValueNotifier<int>(0);

//       await tester.pumpComponent(
//         DeferredInheritedProvider<ValueNotifier<int>, int>.value(
//           value: controller,
//           startListening: startListening,
//           child: child,
//         ),
//       );

//       expect(buildCount, equals(1));
//       expect(find.text('0'), findsOneComponent);
//       verify(startListening(any, any, controller, null)).called(1);
//       verifyZeroInteractions(stopListening);

//       final stopListening2 = StopListeningMock();
//       final startListening2 = DeferredStartListeningMock<ValueNotifier<int>, int>(
//         (e, setState, controller, value) {
//           setState(controller.value);
//           return stopListening2;
//         },
//       );
//       final controller2 = ValueNotifier<int>(1);

//       await tester.pumpComponent(
//         DeferredInheritedProvider<ValueNotifier<int>, int>.value(
//           value: controller2,
//           startListening: startListening2,
//           child: child,
//         ),
//       );

//       expect(buildCount, equals(2));
//       expect(find.text('1'), findsOneComponent);
//       verifyInOrder([
//         stopListening(),
//         startListening2(argThat(isNotNull), argThat(isNotNull), controller2, 0),
//       ]);
//       verifyNoMoreInteractions(startListening);
//       verifyNoMoreInteractions(stopListening);
//       verifyZeroInteractions(stopListening2);

//       await tester.pumpComponent(Container());

//       verifyNoMoreInteractions(startListening);
//       verifyNoMoreInteractions(stopListening);
//       verifyNoMoreInteractions(startListening2);
//       verify(stopListening2()).called(1);
//     });
//   });

//   group('DeferredInheritedProvider()', () {
//     test("create can't call inherited widgets", () async {
//       await runZonedGuarded(
//         () async {
//           await tester.pumpComponent(
//             InheritedProvider<String>.value(
//               value: 'hello',
//               child: DeferredInheritedProvider<int, int>(
//                 create: (context) {
//                   Provider.of<String>(context);
//                   return 42;
//                 },
//                 startListening: (_, setState, ___, ____) {
//                   setState(0);
//                   return () {};
//                 },
//                 child: TextOf<int>(),
//               ),
//             ),
//           );
//           expect(false, isTrue);
//         },
//         (error, stack) {
//           expect(true, isTrue);
//         },
//       );
//     });

//     test('creates the value lazily', () async {
//       final create = InitialValueBuilderMock<String>('0');
//       final stopListening = StopListeningMock();
//       final startListening = DeferredStartListeningMock<String, int>(
//         (_, setState, __, ___) {
//           setState(0);
//           return stopListening;
//         },
//       );

//       await tester.pumpComponent(
//         DeferredInheritedProvider<String, int>(
//           create: create,
//           startListening: startListening,
//           child: const Context(),
//         ),
//       );

//       verifyZeroInteractions(create);
//       verifyZeroInteractions(startListening);
//       verifyZeroInteractions(stopListening);

//       expect(of<int>(), equals(0));

//       verify(create(argThat(isNotNull))).called(1);
//       verify(startListening(argThat(isNotNull), argThat(isNotNull), '0', null)).called(1);

//       expect(of<int>(), equals(0));

//       verifyNoMoreInteractions(create);
//       verifyNoMoreInteractions(startListening);
//       verifyZeroInteractions(stopListening);
//     });

//     test('dispose', () async {
//       final dispose = DisposeMock<String>();
//       final stopListening = StopListeningMock();

//       await tester.pumpComponent(
//         DeferredInheritedProvider<String, int>(
//           create: (_) => '42',
//           startListening: (_, setState, __, ___) {
//             setState(0);
//             return stopListening;
//           },
//           dispose: dispose,
//           child: const Context(),
//         ),
//       );

//       expect(of<int>(), equals(0));

//       verifyZeroInteractions(dispose);

//       await tester.pumpComponent(Container());

//       verifyInOrder([
//         stopListening(),
//         dispose(argThat(isNotNull), '42'),
//       ]);
//       verifyNoMoreInteractions(dispose);
//     });

//     test('dispose no-op if never built', () async {
//       final dispose = DisposeMock<String>();

//       await tester.pumpComponent(
//         DeferredInheritedProvider<String, int>(
//           create: (_) => '42',
//           startListening: (_, setState, __, ___) {
//             setState(0);
//             return () {};
//           },
//           dispose: dispose,
//           child: const Context(),
//         ),
//       );

//       verifyZeroInteractions(dispose);

//       await tester.pumpComponent(Container());

//       verifyZeroInteractions(dispose);
//     });
//   });

//   test('startListening markNeedsNotifyDependents', () async {
//     InheritedContext<int?>? element;
//     var buildCount = 0;

//     await tester.pumpComponent(
//       InheritedProvider<int>(
//         update: (_, __) => 24,
//         startListening: (e, value) {
//           element = e;
//           return () {};
//         },
//         child: Consumer<int>(
//           builder: (_, __, ___) sync* {
//             buildCount++;
//             yield Container();
//           },
//         ),
//       ),
//     );

//     expect(buildCount, equals(1));

//     element!.markNeedsNotifyDependents();
//     await tester.pump();

//     expect(buildCount, equals(2));

//     await tester.pump();

//     expect(buildCount, equals(2));
//   });

//   test('InheritedProvider can be subclassed', () async {
//     await tester.pumpComponent(
//       SubclassProvider(
//         key: UniqueKey(),
//         create: (_) => 42,
//         child: const Context(),
//       ),
//     );

//     expect(of<int>(), equals(42));

//     await tester.pumpComponent(
//       SubclassProvider.value(
//         key: UniqueKey(),
//         value: 24,
//         child: const Context(),
//       ),
//     );

//     expect(of<int>(), equals(24));
//   });

//   test('DeferredInheritedProvider can be subclassed', () async {
//     await tester.pumpComponent(
//       DeferredSubclassProvider(
//         key: UniqueKey(),
//         value: 42,
//         child: const Context(),
//       ),
//     );

//     expect(of<int>(), equals(42));

//     await tester.pumpComponent(
//       DeferredSubclassProvider.value(
//         key: UniqueKey(),
//         value: 24,
//         child: const Context(),
//       ),
//     );

//     expect(of<int>(), equals(24));
//   });

//   test('can be used with MultiProvider', () async {
//     await tester.pumpComponent(
//       MultiProvider(
//         providers: [
//           InheritedProvider.value(value: 42),
//         ],
//         child: const Context(),
//       ),
//     );

//     expect(of<int>(), equals(42));
//   });

//   test('throw if the widget ctor changes', () async {
//     await runZonedGuarded(
//       () async {
//         await tester.pumpComponent(
//           InheritedProvider<int>(
//             update: (_, __) => 42,
//             child: Container(),
//           ),
//         );

//         expect(true, isTrue);
//       },
//       (error, stack) {
//         expect(false, isTrue);
//       },
//     );

//     await runZonedGuarded(
//       () async {
//         await tester.pumpComponent(
//           InheritedProvider<int>.value(
//             value: 42,
//             child: Container(),
//           ),
//         );

//         expect(false, isTrue);
//       },
//       (error, stack) {
//         expect(error, isStateError);
//       },
//     );
//   });

//   test('InheritedProvider lazy loading can be disabled', () async {
//     final startListening = StartListeningMock<int>(() {});

//     await tester.pumpComponent(
//       InheritedProvider(
//         key: UniqueKey(),
//         create: (_) => 42,
//         startListening: startListening,
//         lazy: false,
//         child: Container(),
//       ),
//     );
//     verify(startListening(argThat(isNotNull), 42)).called(1);
//   });

//   test('InheritedProvider.value lazy loading can be disabled', () async {
//     final startListening = StartListeningMock<int>(() {});

//     await tester.pumpComponent(
//       InheritedProvider.value(
//         key: UniqueKey(),
//         value: 42,
//         startListening: startListening,
//         lazy: false,
//         child: Container(),
//       ),
//     );

//     verify(startListening(argThat(isNotNull), 42)).called(1);
//     verifyNoMoreInteractions(startListening);
//   });

//   test(
//     "InheritedProvider subclass don't have to specify default lazy value",
//     () async {
//       final create = InitialValueBuilderMock<int>(42);

//       await tester.pumpComponent(
//         SubclassProvider(
//           key: UniqueKey(),
//           create: create,
//           child: const Context(),
//         ),
//       );

//       verifyZeroInteractions(create);
//       expect(of<int>(), equals(42));
//       verify(create(argThat(isNotNull))).called(1);
//       verifyNoMoreInteractions(create);
//     },
//   );
//   test('DeferredInheritedProvider lazy loading can be disabled', () async {
//     final startListening = DeferredStartListeningMock<int, int>((a, setState, c, d) {
//       setState(0);
//       return () {};
//     });

//     await tester.pumpComponent(
//       DeferredInheritedProvider<int, int>(
//         key: UniqueKey(),
//         create: (_) => 42,
//         startListening: startListening,
//         lazy: false,
//         child: Container(),
//       ),
//     );

//     verify(startListening(argThat(isNotNull), argThat(isNotNull), 42, null)).called(1);
//     verifyNoMoreInteractions(startListening);
//   });

//   test('DeferredInheritedProvider.value lazy loading can be disabled', () async {
//     final startListening = DeferredStartListeningMock<int, int>((a, setState, c, d) {
//       setState(0);
//       return () {};
//     });

//     await tester.pumpComponent(
//       DeferredInheritedProvider<int, int>.value(
//         key: UniqueKey(),
//         value: 42,
//         startListening: startListening,
//         lazy: false,
//         child: Container(),
//       ),
//     );

//     verify(startListening(argThat(isNotNull), argThat(isNotNull), 42, null)).called(1);
//     verifyNoMoreInteractions(startListening);
//   });

//   test('selector', () async {
//     final notifier = ValueNotifier(0);
//     var buildCount = 0;

//     await tester.pumpComponent(
//       ChangeNotifierProvider(
//         create: (_) => notifier,
//         child: Builder(builder: (context) sync* {
//           buildCount++;
//           final isEven = context.select((ValueNotifier<int> value) => value.value.isEven);

//           yield Text('$isEven');
//         }),
//       ),
//     );

//     expect(buildCount, 1);
//     expect(find.text('true'), findsOneComponent);

//     notifier.value = 1;
//     await tester.pump();

//     expect(buildCount, 2);
//     expect(find.text('false'), findsOneComponent);

//     notifier.value = 3;
//     await tester.pump();

//     expect(buildCount, 2);
//     expect(find.text('false'), findsOneComponent);
//   });

//   test('can select multiple types from same provider', () async {
//     var buildCount = 0;

//     final builder = Builder(builder: (context) sync* {
//       buildCount++;
//       final isNotNull = context.select((int? value) => value != null);
//       final isAbove0 = context.select((int? value) {
//         return (value == null || value > 0).toString();
//       });

//       yield Text('$isNotNull $isAbove0');
//     });

//     await tester.pumpComponent(Provider<int?>.value(value: 0, child: builder));

//     expect(buildCount, 1);
//     expect(find.text('true false'), findsOneComponent);

//     await tester.pumpComponent(Provider<int?>.value(value: -1, child: builder));

//     expect(buildCount, 1);

//     await tester.pumpComponent(Provider<int?>.value(value: 1, child: builder));

//     expect(buildCount, 2);
//     expect(find.text('true true'), findsOneComponent);

//     await tester.pumpComponent(Provider<int?>.value(value: null, child: builder));

//     expect(buildCount, 3);
//     expect(find.text('false true'), findsOneComponent);
//   });

//   test('can select same type on two different providers', () async {
//     var buildCount = 0;

//     final builder = Builder(builder: (context) sync* {
//       buildCount++;
//       final intValue = context.select((int value) => value.toString());
//       final stringValue = context.select((String value) => value);

//       yield Text('$intValue $stringValue');
//     });

//     await tester.pumpComponent(
//       MultiProvider(
//         providers: [
//           Provider.value(value: 0),
//           Provider.value(value: 'a'),
//         ],
//         child: builder,
//       ),
//     );

//     expect(buildCount, 1);
//     expect(find.text('0 a'), findsOneComponent);

//     await tester.pumpComponent(
//       MultiProvider(
//         providers: [
//           Provider.value(value: 0),
//           Provider.value(value: 'a'),
//         ],
//         child: builder,
//       ),
//     );

//     expect(buildCount, 1);

//     await tester.pumpComponent(
//       MultiProvider(
//         providers: [
//           Provider.value(value: 1),
//           Provider.value(value: 'a'),
//         ],
//         child: builder,
//       ),
//     );

//     expect(buildCount, 2);
//     expect(find.text('1 a'), findsOneComponent);
//   });

//   test('can select same type twice on same provider', () async {
//     var buildCount = 0;
//     final child = Builder(builder: (context) sync* {
//       buildCount++;
//       final value = context.select((int value) => value.isEven);
//       final value2 = context.select((int value) => value.isNegative);

//       yield Text('$value $value2');
//     });

//     await tester.pumpComponent(Provider.value(value: 0, child: child));

//     expect(find.text('true false'), findsOneComponent);
//     expect(buildCount, 1);

//     await tester.pumpComponent(Provider.value(value: 2, child: child));

//     expect(find.text('true false'), findsOneComponent);
//     expect(buildCount, 1);

//     await tester.pumpComponent(Provider.value(value: -2, child: child));

//     expect(find.text('true true'), findsOneComponent);
//     expect(buildCount, 2);

//     await tester.pumpComponent(Provider.value(value: -4, child: child));

//     expect(find.text('true true'), findsOneComponent);
//     expect(buildCount, 2);

//     await tester.pumpComponent(Provider.value(value: -3, child: child));

//     expect(find.text('false true'), findsOneComponent);
//     expect(buildCount, 3);

//     await tester.pumpComponent(Provider.value(value: -2, child: child));

//     expect(find.text('true true'), findsOneComponent);
//     expect(buildCount, 4);
//   });

//   test('StateError is thrown when lookup fails within create', () async {
//     const expected = 'Tried to read a provider that threw during the creation of its value.\n'
//         'The exception occurred during the creation of type int.';
//     await runZonedGuarded(
//       () async {
//         await tester.pumpComponent(
//           Provider(
//             lazy: false,
//             create: (context) {
//               context.read<String>();
//               return 42;
//             },
//             child: const SizedBox(),
//           ),
//         );
//       },
//       (error, stack) {
//         expect(error, isStateError);
//         expect(
//           error,
//           contains(
//             isA<Exception>().having(
//               (e) => e,
//               'exception',
//               isA<StateError>().having(
//                 (s) => s.message,
//                 'message',
//                 startsWith(expected),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   });

//   test('StateError is thrown when exception occurs in create', () async {
//     await runZonedGuarded(
//       () async {
//         await tester.pumpComponent(
//           Provider<String>(
//             lazy: false,
//             create: (_) => throw Exception('oops'),
//             child: const SizedBox(),
//           ),
//         );
//       },
//       (error, stack) {
//         expect(
//           error,
//           contains(
//             isA<Exception>().having(
//               (e) => e,
//               'exception',
//               isA<StateError>().having(
//                 (s) => s.message,
//                 'message',
//                 startsWith('''
// Tried to read a provider that threw during the creation of its value.
// The exception occurred during the creation of type String.

// ══╡ EXCEPTION CAUGHT BY PROVIDER ╞═══════════════════════════════
// The following _Exception was thrown:
// Exception: oops

// When the exception was thrown, this was the stack:
// #0'''),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   });

//   test('Exception is thrown when exception occurs in rebuild', () async {
//     const errorMessage = 'oops';
//     await runZonedGuarded(
//       () async {
//         final provider = InheritedProvider<String>(
//           create: (_) => '',
//           update: (c, p) {
//             throw Exception(errorMessage);
//           },
//           child: TextOf<String>(),
//         );
//         await tester.pumpComponent(Provider.value(value: 0, child: provider));
//       },
//       (error, stack) {
//         expect(
//           error,
//           contains(
//             isA<Exception>().having(
//               (e) => e,
//               'exception',
//               isA<Exception>().having(
//                 (s) => s.toString(),
//                 'toString',
//                 contains(errorMessage),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   });

//   test('Exception is propagated when context.watch is called after a provider threw', () async {
//     final exception = Exception('oops');
//     await runZonedGuarded(
//       () async {
//         await tester.pumpComponent(
//           Provider<String>(
//             create: (_) => throw exception,
//             child: Builder(
//               builder: (context) sync* {
//                 yield Text(context.watch<String>());
//               },
//             ),
//           ),
//         );
//       },
//       (error, stack) {
//         expect(
//           error,
//           contains(
//             isA<Exception>().having(
//               (e) => e,
//               'exception',
//               exception,
//             ),
//           ),
//         );
//       },
//     );
//   });
// }

// class Model {
//   int? a;
//   String? b;
// }

// class Example extends StatelessComponent {
//   const Example({Key? key}) : super(key: key);

//   @override
//   Iterable<Component> build(BuildContext context) sync* {
//     final a = context.select((Model model) => model.a);
//     final b = context.select((Model model) => model.b);
//     yield Text('$a $b');
//   }
// }

// class Test<T> extends StatefulComponent {
//   const Test({
//     Key? key,
//     this.didChangeDependencies,
//     this.build,
//   }) : super(key: key);

//   final ValueBuilderMock<T>? didChangeDependencies;
//   final ValueBuilderMock<T>? build;

//   @override
//   _TestState<T> createState() => _TestState<T>();
// }

// class _TestState<T> extends State<Test<T>> {
//   @override
//   void didChangeDependencies() {
//     component.didChangeDependencies?.call(this.context, Provider.of<T>(this.context));
//     super.didChangeDependencies();
//   }

//   @override
//   Iterable<Component> build(BuildContext context) sync* {
//     component.build?.call(this.context, Provider.of<T>(this.context));
//     yield Container();
//   }
// }

// class SubclassProvider extends InheritedProvider<int> {
//   SubclassProvider({
//     Key? key,
//     required int Function(BuildContext c) create,
//     bool? lazy,
//     Component? child,
//   }) : super(key: key, create: create, lazy: lazy, child: child);

//   SubclassProvider.value({
//     Key? key,
//     required int value,
//     Component? child,
//   }) : super.value(key: key, value: value, child: child);
// }

// class DeferredSubclassProvider extends DeferredInheritedProvider<int, int> {
//   DeferredSubclassProvider({
//     Key? key,
//     required int value,
//     Component? child,
//   }) : super(
//           key: key,
//           create: (_) => value,
//           startListening: (_, setState, ___, ____) {
//             setState(value);
//             return () {};
//           },
//           child: child,
//         );

//   DeferredSubclassProvider.value({
//     Key? key,
//     required int value,
//     Component? child,
//   }) : super.value(
//           key: key,
//           value: value,
//           startListening: (_, setState, ___, ____) {
//             setState(value);
//             return () {};
//           },
//           child: child,
//         );
// }

// class StateNotifier<T> extends ValueNotifier<T> {
//   StateNotifier(T value) : super(value);

//   Locator? read;

//   void update(Locator watch) {}
// }

// class _Controller1 extends StateNotifier<Counter1> {
//   _Controller1() : super(Counter1(0));

//   void increment() => value = Counter1(value.count + 1);
// }

// class Counter1 {
//   Counter1(this.count);

//   final int count;
// }

// class _Controller2 extends StateNotifier<Counter2> {
//   _Controller2() : super(Counter2(0));

//   void increment() => value = Counter2(value.count + 1);

//   @override
//   void update(T Function<T>() watch) {
//     watch<Counter1>();
//     watch<_Controller1>();
//   }
// }

// class Counter2 {
//   Counter2(this.count);

//   final int count;
// }

// // A stripped version of StateNotifierProvider
// class StateNotifierProvider<Controller extends StateNotifier<Value>, Value> extends SingleChildStatelessComponent {
//   const StateNotifierProvider({
//     Key? key,
//     required this.create,
//     this.lazy,
//     Component? child,
//   }) : super(key: key, child: child);

//   final Create<Controller> create;
//   final bool? lazy;

//   @override
//   Iterable<Component> buildWithChild(BuildContext context, Component? child) sync* {
//     yield InheritedProvider<Controller>(
//       create: (context) {
//         assert(debugIsInInheritedProviderCreate);
//         assert(!debugIsInInheritedProviderUpdate);
//         return create(context)..read = context.read;
//       },
//       update: (context, controller) {
//         assert(!debugIsInInheritedProviderCreate);
//         assert(debugIsInInheritedProviderUpdate);
//         return controller!..update(context.watch);
//       },
//       dispose: (_, controller) => controller.dispose(),
//       child: DeferredInheritedProvider<Controller, Value>(
//         lazy: lazy,
//         create: (context) {
//           assert(debugIsInInheritedProviderCreate);
//           assert(!debugIsInInheritedProviderUpdate);
//           return context.read<Controller>();
//         },
//         startListening: (context, setState, controller, _) {
//           setState(controller.value);
//           void listener() => setState(controller.value);
//           controller.addListener(listener);
//           return () => controller.removeListener(listener);
//         },
//         child: child,
//       ),
//     );
//   }
// }
