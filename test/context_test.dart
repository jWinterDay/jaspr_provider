// import 'dart:async';

// import 'package:jaspr/jaspr.dart';
// import 'package:jaspr_provider/jaspr_provider.dart';
// import 'package:jaspr_provider/src/value_listenable_provider.dart';
// import 'package:jaspr_test/jaspr_test.dart';
// import 'package:mockito/mockito.dart';

// import 'common.dart';

// void main() {
//   late ComponentTester tester;

//   setUpAll(() {
//     tester = ComponentTester.setUp();
//   });
  
//   group('context.watch<T?>', () {
//     test('can watch T', () async {
//       final notifier = ValueNotifier(0);

//       await tester.pumpComponent(
//         ChangeNotifierProvider<ValueNotifier<int>>.value(
//           value: notifier,
//           child: Builder(
//             builder: (context) sync* {
//               final notifier = context.watch<ValueNotifier<int>?>();

//               yield Text(notifier?.value.toString() ?? '');
//             },
//           ),
//         ),
//       );

//       expect(find.text('0'), findsOneComponent);

//       notifier.value++;
//       await tester.pump();

//       expect(find.text('1'), findsOneComponent);
//     });

//     test('can watch T?', () async {
//       final notifier = ValueNotifier(0);

//       await tester.pumpComponent(
//         ChangeNotifierProvider<ValueNotifier<int>?>.value(
//           value: notifier,
//           child: Builder(
//             builder: (context) sync* {
//               final notifier = context.watch<ValueNotifier<int>?>();

//               yield Text(notifier?.value.toString() ?? '');
//             },
//           ),
//         ),
//       );

//       expect(find.text('0'), findsOneComponent);

//       notifier.value++;
//       await tester.pump();

//       expect(find.text('1'), findsOneComponent);
//     });

//     test('handles provider missing', () async {
//       await tester.pumpComponent(
//         Builder(
//           builder: (context) sync* {
//             final notifier = context.watch<ValueNotifier<int>?>();

//             yield Text(notifier?.value.toString() ?? '');
//           },
//         ),
//       );

//       expect(find.text(''), findsOneComponent);
//     });

//     test('supports relocating with GlobalKey from no provider to a provider', () async {
//       final widget = Builder(
//         key: const GlobalKey(),
//         builder: (context) sync* {
//           final notifier = context.watch<ValueNotifier<int>?>();

//           yield Text(notifier?.value.toString() ?? '');
//         },
//       );

//       await tester.pumpComponent(widget);

//       expect(find.text(''), findsOneComponent);

//       final notifier = ValueNotifier(0);
//       await tester.pumpComponent(
//         ChangeNotifierProvider<ValueNotifier<int>?>.value(
//           value: notifier,
//           child: widget,
//         ),
//       );

//       expect(find.text('0'), findsOneComponent);

//       notifier.value++;
//       await tester.pump();

//       expect(find.text('1'), findsOneComponent);
//     });
//   });

//   group('context.watch<T>', () {
//     test('can watch T?', () async {
//       final notifier = ValueNotifier(0);

//       await tester.pumpComponent(
//         ChangeNotifierProvider<ValueNotifier<int>?>.value(
//           value: notifier,
//           child: Builder(
//             builder: (context) sync* {
//               final notifier = context.watch<ValueNotifier<int>>();

//               yield Text(notifier.value.toString());
//             },
//           ),
//         ),
//       );

//       expect(find.text('0'), findsOneComponent);

//       notifier.value++;
//       await tester.pump();

//       expect(find.text('1'), findsOneComponent);
//     });

//     test('on T? will throw ProvierNullException if the result is null', () async {
//       await runZonedGuarded(
//         () async {
//           await tester.pumpComponent(
//             ChangeNotifierProvider<ValueNotifier<int>?>.value(
//               value: null,
//               child: Builder(
//                 builder: (context) sync* {
//                   final notifier = context.watch<ValueNotifier<int>>();

//                   yield Text(notifier.value.toString());
//                 },
//               ),
//             ),
//           );
//         },
//         (error, stack) {
//           expect(error, isA<ProviderNullException>());
//         },
//       );
//     }, skip: !isSoundMode);
//   });

//   group('context.select<T?>', () {
//     test('can watch T', () async {
//       final notifier = ValueNotifier(0);

//       await tester.pumpComponent(
//         ChangeNotifierProvider<ValueNotifier<int>>.value(
//           value: notifier,
//           child: Builder(
//             builder: (context) sync* {
//               final value = context.select<ValueNotifier<int>?, int?>((n) => n?.value);

//               yield Text(value?.toString() ?? '');
//             },
//           ),
//         ),
//       );

//       expect(find.text('0'), findsOneComponent);

//       notifier.value++;
//       await tester.pump();

//       expect(find.text('1'), findsOneComponent);
//     });

//     test('can watch T?', () async {
//       final notifier = ValueNotifier(0);

//       await tester.pumpComponent(
//         ChangeNotifierProvider<ValueNotifier<int>?>.value(
//           value: notifier,
//           child: Builder(
//             builder: (context) sync* {
//               final value = context.select<ValueNotifier<int>?, int?>((n) => n?.value);

//               yield Text(value?.toString() ?? '');
//             },
//           ),
//         ),
//       );

//       expect(find.text('0'), findsOneComponent);

//       notifier.value++;
//       await tester.pump();

//       expect(find.text('1'), findsOneComponent);
//     });

//     test('handles provider missing', () async {
//       await tester.pumpComponent(
//         Builder(
//           builder: (context) sync* {
//             final value = context.select<ValueNotifier<int>?, int?>((n) => n?.value);

//             yield Text(
//               value?.toString() ?? '',
//             );
//           },
//         ),
//       );

//       expect(find.text(''), findsOneComponent);
//     });

//     test('supports relocating with GlobalKey from no provider to a provider', () async {
//       final widget = Builder(
//         key: const GlobalKey(),
//         builder: (context) sync* {
//           final value = context.select<ValueNotifier<int>?, int?>((n) => n?.value);

//           yield Text(value?.toString() ?? '');
//         },
//       );

//       await tester.pumpComponent(widget);

//       expect(find.text(''), findsOneComponent);

//       final notifier = ValueNotifier(0);
//       await tester.pumpComponent(
//         ChangeNotifierProvider<ValueNotifier<int>?>.value(
//           value: notifier,
//           child: widget,
//         ),
//       );

//       expect(find.text('0'), findsOneComponent);

//       notifier.value++;
//       await tester.pump();

//       expect(find.text('1'), findsOneComponent);
//     });
//   });

//   group('context.select<T>', () {
//     test('can watch T?', () async {
//       final notifier = ValueNotifier(0);

//       await tester.pumpComponent(
//         ChangeNotifierProvider<ValueNotifier<int>?>.value(
//           value: notifier,
//           child: Builder(
//             builder: (context) sync* {
//               final value = context.select<ValueNotifier<int>, int>((n) => n.value);

//               yield Text(value.toString());
//             },
//           ),
//         ),
//       );

//       expect(find.text('0'), findsOneComponent);

//       notifier.value++;
//       await tester.pump();

//       expect(find.text('1'), findsOneComponent);
//     });

//     test('can watch T', () async {
//       final notifier = ValueNotifier(0);

//       await tester.pumpComponent(
//         ChangeNotifierProvider<ValueNotifier<int>>.value(
//           value: notifier,
//           child: Builder(
//             builder: (context) sync* {
//               final value = context.select<ValueNotifier<int>, int>((n) => n.value);

//               yield Text(value.toString());
//             },
//           ),
//         ),
//       );

//       expect(find.text('0'), findsOneComponent);

//       notifier.value++;
//       await tester.pump();

//       expect(find.text('1'), findsOneComponent);
//     });

//     test('on T? will throw ProvierNullException if the result is null', () async {
//       await runZonedGuarded(
//         () async {
//           await tester.pumpComponent(
//             ChangeNotifierProvider<ValueNotifier<int>?>.value(
//               value: null,
//               child: Builder(
//                 builder: (context) sync* {
//                   final value = context.select<ValueNotifier<int>, int>((n) => n.value);

//                   yield Text(value.toString());
//                 },
//               ),
//             ),
//           );
//         },
//         (error, stack) {
//           expect(error, isA<ProviderNullException>());
//         },
//       );
//     });

//     test('on T? will throw ProvierNullException if new value is null', () async {
//       await runZonedGuarded(
//         () async {
//           final child = Builder(
//             builder: (context) sync* {
//               final value = context.select<ValueNotifier<int>, int>((n) => n.value);

//               yield Text(value.toString());
//             },
//           );

//           await tester.pumpComponent(
//             ChangeNotifierProvider<ValueNotifier<int>?>.value(
//               value: ValueNotifier(0),
//               child: child,
//             ),
//           );

//           expect(find.text('0'), findsOneComponent);

//           await tester.pumpComponent(
//             ChangeNotifierProvider<ValueNotifier<int>?>.value(
//               value: null,
//               child: child,
//             ),
//           );
//         },
//         (error, stack) {
//           expect(error, isA<ProviderNullException>());
//         },
//       );
//     });
//   });

//   group('BuildContext', () {
//     test('internal selected value is updated', () async {
//       final notifier = ValueNotifier([false, false, false]);

//       final callCounts = <int, int>{
//         0: 0,
//         1: 0,
//         2: 0,
//       };

//       Component buildIndex(int index) {
//         return Builder(builder: (c) sync* {
//           callCounts[index] = callCounts[index]! + 1;
//           final selected = c.select<ValueNotifier<List<bool>>, bool>((notifier) {
//             return notifier.value[index];
//           });
//           yield Text('$index $selected');
//         });
//       }

//       await tester.pumpComponent(
//         ChangeNotifierProvider(
//           create: (_) => notifier,
//           child: Builder(
//             builder: (context) sync* {
//               yield buildIndex(0);
//               yield buildIndex(1);
//               yield buildIndex(2);
//             },
//           ),
//         ),
//       );

//       expect(find.text('0 false'), findsOneComponent);
//       expect(callCounts[0], 1);
//       expect(find.text('1 false'), findsOneComponent);
//       expect(callCounts[1], 1);
//       expect(find.text('2 false'), findsOneComponent);
//       expect(callCounts[2], 1);

//       notifier.value = [false, true, false];
//       await tester.pump();

//       expect(find.text('0 false'), findsOneComponent);
//       expect(callCounts[0], 1);
//       expect(find.text('1 true'), findsOneComponent);
//       expect(callCounts[1], 2);
//       expect(find.text('2 false'), findsOneComponent);
//       expect(callCounts[2], 1);

//       notifier.value = [false, false, false];
//       await tester.pump();

//       expect(find.text('0 false'), findsOneComponent);
//       expect(callCounts[0], 1);
//       expect(find.text('1 false'), findsOneComponent);
//       expect(callCounts[1], 3);
//       expect(find.text('2 false'), findsOneComponent);
//       expect(callCounts[2], 1);

//       notifier.value = [true, false, false];
//       await tester.pump();

//       expect(find.text('0 true'), findsOneComponent);
//       expect(callCounts[0], 2);
//       expect(find.text('1 false'), findsOneComponent);
//       expect(callCounts[1], 3);
//       expect(find.text('2 false'), findsOneComponent);
//       expect(callCounts[2], 1);

//       notifier.value = [true, false, false];
//       await tester.pump();

//       expect(find.text('0 true'), findsOneComponent);
//       expect(callCounts[0], 2);
//       expect(find.text('1 false'), findsOneComponent);
//       expect(callCounts[1], 3);
//       expect(find.text('2 false'), findsOneComponent);
//       expect(callCounts[2], 1);
//     });

//     test('create can use read without being lazy', () async {
//       await tester.pumpComponent(
//         MultiProvider(
//           providers: [
//             Provider(create: (context) => 42),
//             Provider(
//               lazy: false,
//               create: (context) => context.read<int>().toString(),
//             ),
//           ],
//           child: Consumer<String>(
//             builder: (c, value, _) sync* {
//               yield Text(value);
//             },
//           ),
//         ),
//       );

//       expect(find.text('42'), findsOneComponent);
//     });
//     test('watch can be used inside InheritedProvider.update', () async {
//       await tester.pumpComponent(
//         Provider.value(
//           value: 42,
//           child: InheritedProvider<String>(
//             update: (c, _) {
//               return c.watch<int>().toString();
//             },
//             child: Consumer<String>(
//               builder: (c, value, _) sync* {
//                 yield Text(value);
//               },
//             ),
//           ),
//         ),
//       );
//     });
//     test("select doesn't fail if it loads a provider that depends on other providers", () async {
//       await tester.pumpComponent(
//         MultiProvider(
//           providers: [
//             Provider(create: (_) => 42),
//             ProxyProvider<int, String>(
//               create: (c) => '${c.read<int>()}',
//               update: (c, _, __) => '${c.watch<int>() * 2}',
//             ),
//           ],
//           child: Builder(
//             builder: (context) sync* {
//               final value = context.select((String value) => value);
//               yield Text(value);
//             },
//           ),
//         ),
//       );

//       expect(find.text('84'), findsOneComponent);
//     });

//     test("don't call old selectors if the child rebuilds individually", () async {
//       final notifier = ValueNotifier(0);

//       var buildCount = 0;
//       final selector = MockSelector.identity<ValueNotifier<int>>(ValueNotifier(0));
//       final child = Builder(builder: (c) sync* {
//         buildCount++;
//         c.select<ValueNotifier<int>, ValueNotifier<int>>(selector);
//         yield Container();
//       });

//       await tester.pumpComponent(
//         ChangeNotifierProvider.value(
//           value: notifier,
//           child: child,
//         ),
//       );

//       expect(buildCount, 1);
//       verify(selector(notifier)).called(1);
//       verifyNoMoreInteractions(selector);

//       find.byComponent(child).evaluate().first.markNeedsBuild();
//       await tester.pump();

//       expect(buildCount, 2);
//       verify(selector(notifier)).called(1);
//       verifyNoMoreInteractions(selector);

//       notifier.notifyListeners();
//       await tester.pump();

//       expect(buildCount, 2);
//       verify(selector(notifier)).called(1);
//       verifyNoMoreInteractions(selector);
//     });

//     test('selects throws inside click handlers', () async {
//       await runZonedGuarded(
//         () async {
//           await tester.pumpComponent(
//             Provider.value(
//               value: 42,
//               child: Builder(builder: (context) sync* {
//                 yield GestureDetector(
//                   onTap: () {
//                     context.select((int a) => a);
//                   },
//                   child: Container(),
//                 );
//               }),
//             ),
//           );

//           await tester.click(find.byType(GestureDetector));
//         },
//         (error, stack) {
//           expect(error, isAssertionError);
//         },
//       );
//     });

//     test('select throws if try to read dynamic', () async {
//       await runZonedGuarded(
//         () async {
//           await tester.pumpComponent(
//             Builder(builder: (c) sync* {
//               c.select<dynamic, dynamic>((dynamic i) => i);
//               yield Container();
//             }),
//           );
//         },
//         (error, stack) {
//           expect(error, isAssertionError);
//         },
//       );
//     });

//     test('select throws ProviderNotFoundException', () async {
//       await runZonedGuarded(
//         () async {
//           await tester.pumpComponent(
//             Builder(builder: (c) sync* {
//               c.select((int i) => i);
//               yield Container();
//             }),
//           );
//         },
//         (error, stack) {
//           expect(error, isA<ProviderNotFoundException>());
//         },
//       );
//     });

//     test('select throws if watch called inside the callback from build', () async {
//       await runZonedGuarded(
//         () async {
//           await tester.pumpComponent(
//             Provider.value(
//               value: 42,
//               child: Builder(builder: (context) sync* {
//                 context.select((int i) {
//                   context.watch<int>();
//                   return i;
//                 });
//                 yield Container();
//               }),
//             ),
//           );
//         },
//         (error, stack) {
//           expect(error, isAssertionError);
//         },
//       );
//     });

//     test('select throws if read called inside the callback from build', () async {
//       await runZonedGuarded(
//         () async {
//           await tester.pumpComponent(
//             Provider.value(
//               value: 42,
//               child: Builder(builder: (context) sync* {
//                 context.select((int i) {
//                   context.read<int>();
//                   return i;
//                 });
//                 yield Container();
//               }),
//             ),
//           );
//         },
//         (error, stack) {
//           expect(error, isAssertionError);
//         },
//       );
//     });

//     test('select throws if select called inside the callback from build', () async {
//       await runZonedGuarded(
//         () async {
//           await tester.pumpComponent(
//             Provider.value(
//               value: 42,
//               child: Builder(builder: (context) sync* {
//                 context.select((int i) {
//                   context.select((int i) => i);
//                   return i;
//                 });
//                 yield Container();
//               }),
//             ),
//           );
//         },
//         (error, stack) {
//           expect(error, isAssertionError);
//         },
//       );
//     });

//     test('select throws if read called inside the callback on dependency change', () async {
//       await runZonedGuarded(
//         () async {
//           var shouldCall = false;
//           final child = Builder(builder: (context) sync* {
//             context.select((int i) {
//               if (shouldCall) {
//                 context.read<int>();
//               }
//               // trigger selector call without rebuilding
//               return 0;
//             });
//             yield const Text('foo');
//           });

//           await tester.pumpComponent(
//             Provider.value(
//               value: 42,
//               child: child,
//             ),
//           );

//           expect(find.text('foo'), findsOneComponent);
//           shouldCall = true;
//           await tester.pumpComponent(
//             Provider.value(
//               value: 21,
//               child: child,
//             ),
//           );
//         },
//         (error, stack) {
//           expect(error, isAssertionError);
//         },
//       );
//     });

//     test('select throws if watch called inside the callback on dependency change', () async {
//       await runZonedGuarded(
//         () async {
//           var shouldCall = false;
//           final child = Builder(builder: (context) sync* {
//             context.select((int i) {
//               if (shouldCall) {
//                 context.watch<int>();
//               }
//               // trigger selector call without rebuilding
//               return 0;
//             });
//             yield const Text('foo');
//           });

//           await tester.pumpComponent(
//             Provider.value(
//               value: 42,
//               child: child,
//             ),
//           );

//           expect(find.text('foo'), findsOneComponent);
//           shouldCall = true;
//           await tester.pumpComponent(
//             Provider.value(
//               value: 21,
//               child: child,
//             ),
//           );
//         },
//         (error, stack) {
//           expect(error, isAssertionError);
//         },
//       );
//     });

//     test('select throws if select called inside the callback on dependency change', () async {
//       await runZonedGuarded(
//         () async {
//           var shouldCall = false;
//           final child = Builder(builder: (context) sync* {
//             context.select((int i) {
//               if (shouldCall) {
//                 context.select((int i) => i);
//               }
//               // trigger selector call without rebuilding
//               return 0;
//             });
//             yield const Text('foo');
//           });

//           await tester.pumpComponent(
//             Provider.value(
//               value: 42,
//               child: child,
//             ),
//           );

//           expect(find.text('foo'), findsOneComponent);
//           shouldCall = true;
//           await tester.pumpComponent(
//             Provider.value(
//               value: 21,
//               child: child,
//             ),
//           );
//         },
//         (error, stack) {
//           expect(error, isAssertionError);
//         },
//       );
//     });

//     test('can call read inside didChangeDependencies', () async {
//       await tester.pumpComponent(
//         Provider.value(
//           value: 42,
//           child: StatefulTest(
//             didChangeDependencies: (context) {
//               context.read<int>();
//             },
//             child: const Text('42'),
//           ),
//         ),
//       );

//       expect(find.text('42'), findsOneComponent);
//     });

//     test('select cannot be called inside didChangeDependencies', () async {
//       Object? error;
//       await tester.pumpComponent(
//         Provider.value(
//           value: 42,
//           child: StatefulTest(
//             didChangeDependencies: (c) {
//               try {
//                 c.select((int i) => i);
//               } catch (err) {
//                 error = err;
//               }
//             },
//             builder: (context) sync* {
//               yield Container();
//             },
//           ),
//         ),
//       );

//       expect(error, isAssertionError);
//     });

//     test('select in initState throws', () async {
//       await runZonedGuarded(
//         () async {
//           await tester.pumpComponent(
//             Provider.value(
//               value: 42,
//               child: StatefulTest(
//                 initState: (c) {
//                   c.select((int i) => i);
//                 },
//                 child: Container(),
//               ),
//             ),
//           );
//         },
//         (error, stack) {
//           expect(error, isAssertionError);
//         },
//       );
//     });

//     test('watch in initState throws', () async {
//       await runZonedGuarded(
//         () async {
//           await tester.pumpComponent(
//             Provider.value(
//               value: 42,
//               child: StatefulTest(
//                 initState: (c) {
//                   c.watch<int>();
//                 },
//                 child: Container(),
//               ),
//             ),
//           );
//         },
//         (error, stack) {
//           expect(error, isAssertionError);
//         },
//       );
//     });

//     test('read in initState works', () async {
//       int? value;
//       await tester.pumpComponent(
//         Provider.value(
//           value: 42,
//           child: StatefulTest(
//             initState: (c) {
//               value = c.read<int>();
//             },
//             child: Container(),
//           ),
//         ),
//       );

//       expect(value, 42);
//     });

//     test('consumer can be removed and selector stops to be called', () async {
//       final selector = MockSelector.identity<int>(0);

//       final child = Builder(builder: (c) sync* {
//         c.select<int, int>(selector);
//         yield Container();
//       });

//       await tester.pumpComponent(
//         Provider.value(
//           value: 0,
//           child: child,
//         ),
//       );

//       verify(selector(0)).called(1);
//       verifyNoMoreInteractions(selector);

//       await tester.pumpComponent(
//         Provider.value(
//           value: 42,
//           child: Container(),
//         ),
//       );

//       // necessary call because didChangeDependencies may be called even
//       // if the widget will be unmounted in the same frame
//       verify(selector(42)).called(1);
//       verifyNoMoreInteractions(selector);

//       await tester.pumpComponent(
//         Provider.value(
//           value: 84,
//           child: Container(),
//         ),
//       );

//       verifyNoMoreInteractions(selector);
//     });

//     test('context.select deeply compares maps', () async {
//       final notifier = ValueNotifier(<int, int>{});

//       var buildCount = 0;
//       final selector = MockSelector.identity<Map<int, int>>({});
//       final child = Builder(builder: (c) sync* {
//         buildCount++;
//         c.select<Map<int, int>, Map<int, int>>(selector);
//         yield Container();
//       });

//       await tester.pumpComponent(
//         ValueListenableBuilder<Map<int, int>>(
//           valueListenable: notifier,
//           builder: (context, value, _) sync* {
//             yield Provider.value(
//               value: value,
//               child: child,
//             );
//           },
//         ),
//       );

//       expect(buildCount, 1);
//       verify(selector(notifier.value)).called(1);
//       verifyNoMoreInteractions(selector);

//       notifier.value = {0: 0, 1: 1};
//       await tester.pump();

//       expect(buildCount, 2);
//       verify(selector(notifier.value)).called(2);
//       verifyNoMoreInteractions(selector);

//       notifier.value = {0: 0, 1: 1};

//       await tester.pump();

//       expect(buildCount, 2);
//       verify(selector(notifier.value)).called(1);
//       verifyNoMoreInteractions(selector);
//     });

//     test('context.select deeply compares lists', () async {
//       final notifier = ValueNotifier(<int>[]);

//       var buildCount = 0;
//       final selector = MockSelector.identity<List<int>>([]);
//       final child = Builder(builder: (c) sync* {
//         buildCount++;
//         c.select<List<int>, List<int>>(selector);
//         yield Container();
//       });

//       await tester.pumpComponent(
//         ValueListenableBuilder<List<int>>(
//           valueListenable: notifier,
//           builder: (context, value, _) sync* {
//             yield Provider.value(
//               value: value,
//               child: child,
//             );
//           },
//         ),
//       );

//       expect(buildCount, 1);
//       verify(selector(notifier.value)).called(1);
//       verifyNoMoreInteractions(selector);

//       notifier.value = [0, 1];
//       await tester.pump();

//       expect(buildCount, 2);
//       verify(selector(notifier.value)).called(2);
//       verifyNoMoreInteractions(selector);

//       notifier.value = [0, 1];
//       await tester.pump();

//       expect(buildCount, 2);
//       verify(selector(notifier.value)).called(1);
//       verifyNoMoreInteractions(selector);
//     });

//     test('context.select deeply compares iterables', () async {
//       final notifier = ValueNotifier<Iterable<int>>(<int>[]);

//       var buildCount = 0;
//       final selector = MockSelector.identity<Iterable<int>>({});
//       final child = Builder(builder: (c) sync* {
//         buildCount++;
//         c.select<Iterable<int>, Iterable<int>>(selector);
//         yield Container();
//       });

//       await tester.pumpComponent(
//         ValueListenableBuilder<Iterable<int>>(
//           valueListenable: notifier,
//           builder: (context, value, _) sync* {
//             yield Provider.value(
//               value: value,
//               child: child,
//             );
//           },
//         ),
//       );

//       expect(buildCount, 1);
//       verify(selector(notifier.value)).called(1);
//       verifyNoMoreInteractions(selector);

//       notifier.value = [0, 1];
//       await tester.pump();

//       expect(buildCount, 2);
//       verify(selector(notifier.value)).called(2);
//       verifyNoMoreInteractions(selector);

//       notifier.value = [0, 1];
//       await tester.pump();

//       expect(buildCount, 2);
//       verify(selector(notifier.value)).called(1);
//       verifyNoMoreInteractions(selector);
//     });

//     test('context.select deeply compares sets', () async {
//       final notifier = ValueNotifier<Set<int>>(<int>{});

//       var buildCount = 0;
//       final selector = MockSelector.identity<Set<int>>({});
//       final child = Builder(builder: (c) sync* {
//         buildCount++;
//         c.select<Set<int>, Set<int>>(selector);
//         yield Container();
//       });

//       await tester.pumpComponent(
//         ValueListenableBuilder<Set<int>>(
//           valueListenable: notifier,
//           builder: (context, value, _) sync* {
//             yield Provider.value(
//               value: value,
//               child: child,
//             );
//           },
//         ),
//       );

//       expect(buildCount, 1);
//       verify(selector(notifier.value)).called(1);
//       verifyNoMoreInteractions(selector);

//       notifier.value = {0, 1};
//       await tester.pump();

//       expect(buildCount, 2);
//       verify(selector(notifier.value)).called(2);
//       verifyNoMoreInteractions(selector);

//       notifier.value = {0, 1};
//       await tester.pump();

//       expect(buildCount, 2);
//       verify(selector(notifier.value)).called(1);
//       verifyNoMoreInteractions(selector);
//     });

//     test('context.watch listens to value changes', () async {
//       final child = Builder(builder: (context) sync* {
//         final value = context.watch<int>();
//         yield Text('$value');
//       });

//       await tester.pumpComponent(
//         Provider.value(
//           value: 42,
//           child: child,
//         ),
//       );

//       expect(find.text('42'), findsOneComponent);

//       await tester.pumpComponent(
//         Provider.value(
//           value: 24,
//           child: child,
//         ),
//       );

//       expect(find.text('24'), findsOneComponent);
//     });
//   });

//   test('clears select dependencies for all dependents', () async {
//     var buildCountChild1 = 0;
//     var buildCountChild2 = 0;

//     final select1 = MockSelector<int, int>(0, (v) => 0);
//     final select2 = MockSelector<int, int>(0, (v) => 0);

//     Component build(int value) {
//       return Provider.value(
//           value: value,
//           child: Builder(
//             builder: (context) sync* {
//               yield Builder(builder: (c) sync* {
//                 buildCountChild1++;
//                 c.select<int, int>(select1.call);
//                 yield Container();
//               });
//               yield Builder(builder: (c) sync* {
//                 buildCountChild2++;
//                 c.select<int, int>(select2.call);
//                 yield Container();
//               });
//             },
//           ));
//     }

//     await tester.pumpComponent(build(0));

//     expect(buildCountChild1, 1);
//     expect(buildCountChild2, 1);
//     verify(select1(0)).called(1);
//     verifyNoMoreInteractions(select1);
//     verify(select2(0)).called(1);
//     verifyNoMoreInteractions(select2);

//     await tester.pumpComponent(build(1));

//     expect(buildCountChild1, 2);
//     expect(buildCountChild2, 2);
//     verify(select1(1)).called(2);
//     verifyNoMoreInteractions(select1);
//     verify(select2(1)).called(2);
//     verifyNoMoreInteractions(select2);

//     await tester.pumpComponent(build(2));

//     expect(buildCountChild1, 3);
//     expect(buildCountChild2, 3);
//     verify(select1(2)).called(2);
//     verifyNoMoreInteractions(select1);
//     verify(select2(2)).called(2);
//     verifyNoMoreInteractions(select2);
//   });
// }

// class StatefulTest extends StatefulComponent {
//   const StatefulTest({
//     Key? key,
//     this.initState,
//     this.child,
//     this.didChangeDependencies,
//     this.builder,
//     this.dispose,
//   }) : super(key: key);

//   final void Function(BuildContext c)? initState;
//   final void Function(BuildContext c)? didChangeDependencies;
//   final ComponentBuilder? builder;
//   final Component? child;
//   final void Function(BuildContext c)? dispose;

//   @override
//   _StatefulTestState createState() => _StatefulTestState();
// }

// class _StatefulTestState extends State<StatefulTest> {
//   @override
//   void initState() {
//     super.initState();
//     component.initState?.call(context);
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     component.didChangeDependencies?.call(context);
//   }

//   @override
//   void dispose() {
//     component.dispose?.call(context);
//     super.dispose();
//   }

//   @override
//   Iterable<Component> build(BuildContext context) sync* {
//     if (component.builder != null) {
//       yield* component.builder!(context);
//       return;
//     }
//     yield component.child!;
//   }
// }

// class MockSelector<T, R> extends Mock {
//   MockSelector(this.fallback, R Function(T v) cb) {
//     when(this(any)).thenAnswer((i) {
//       return cb(i.positionalArguments.first as T);
//     });
//   }

//   static MockSelector<T, T> identity<T>(T fallback) {
//     return MockSelector<T, T>(fallback, (v) => v);
//   }

//   final R fallback;

//   R call(T? v) => super.noSuchMethod(
//         Invocation.method(#call, [v]),
//         returnValue: fallback,
//         returnValueForMissingStub: fallback,
//       ) as R;
// }
