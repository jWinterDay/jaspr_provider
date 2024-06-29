// // ignore_for_file: invalid_use_of_protected_member

// import 'package:jaspr/jaspr.dart';
// import 'package:jaspr_provider/jaspr_provider.dart';
// import 'package:jaspr_test/jaspr_test.dart';
// import 'package:mockito/mockito.dart';

// import 'common.dart';

// void main() {
//   late ComponentTester tester;

//   setUpAll(() {
//     tester = ComponentTester.setUp();
//   });

//   group('ListenableProvider', () {
//     test('works with MultiProvider', () async {
//       const key = GlobalKey();
//       final listenable = ChangeNotifier();

//       await tester.pumpComponent(
//         MultiProvider(
//           providers: [
//             ListenableProvider.value(value: listenable),
//           ],
//           child: Container(key: key),
//         ),
//       );

//       expect(Provider.of<ChangeNotifier>(key.currentContext!, listen: false), listenable);
//     });

//     test(
//       'asserts that the created notifier can have listeners',
//       () async {
//         const key = GlobalKey();
//         final notifier = ValueNotifier(0)..addListener(() {});

//         await tester.pumpComponent(
//           ListenableProvider(
//             create: (_) => notifier,
//             child: Container(key: key),
//           ),
//         );

//         expect(
//           Provider.of<ValueNotifier<int>>(key.currentContext!, listen: false),
//           notifier,
//         );
//       },
//     );

//     group('value constructor', () {
//       test('pass down key', () async {
//         final listenable = ChangeNotifier();
//         const keyProvider = GlobalKey();

//         await tester.pumpComponent(
//           ListenableProvider.value(
//             key: keyProvider,
//             value: listenable,
//             child: Container(),
//           ),
//         );
//         expect(
//           keyProvider.currentComponent,
//           isNotNull,
//         );
//       });
//       test(
//         'changing the Listenable instance rebuilds dependents',
//         () async {
//           final mockBuilder = MockConsumerBuilder<MockNotifier>();
//           when(mockBuilder(any, any, any)).thenReturn([Container()]);
//           final child = Consumer<MockNotifier>(builder: mockBuilder);

//           final previousListenable = MockNotifier();
//           await tester.pumpComponent(
//             ListenableProvider.value(
//               value: previousListenable,
//               child: child,
//             ),
//           );

//           clearInteractions(mockBuilder);
//           clearInteractions(previousListenable);

//           final listenable = MockNotifier();
//           await tester.pumpComponent(
//             ListenableProvider.value(
//               value: listenable,
//               child: child,
//             ),
//           );

//           verify(previousListenable.removeListener(any)).called(1);
//           verify(listenable.addListener(any)).called(1);
//           verifyNoMoreInteractions(previousListenable);
//           verifyNoMoreInteractions(listenable);

//           final context = find.byComponent(child).evaluate().first;
//           verify(mockBuilder(context, listenable, null));
//         },
//       );
//     }, skip: true);
//     test("don't listen again if listenable instance doesn't change", () async {
//       final listenable = MockNotifier();
//       await tester.pumpComponent(
//         ListenableProvider<ChangeNotifier>.value(
//           value: listenable,
//           child: TextOf<ChangeNotifier>(),
//         ),
//       );
//       await tester.pumpComponent(
//         ListenableProvider<ChangeNotifier>.value(
//           value: listenable,
//           child: TextOf<ChangeNotifier>(),
//         ),
//       );

//       verify(listenable.addListener(any)).called(1);
//       verifyNoMoreInteractions(listenable);
//     });

//     test('works with null (default)', () async {
//       const key = GlobalKey();

//       await tester.pumpComponent(
//         ListenableProvider<ChangeNotifier?>.value(
//           value: null,
//           child: Container(key: key),
//         ),
//       );

//       expect(
//         Provider.of<ChangeNotifier?>(key.currentContext!, listen: false),
//         null,
//       );
//     });

//     test('works with null (create)', () async {
//       const key = GlobalKey();

//       await tester.pumpComponent(
//         ListenableProvider<ChangeNotifier?>(
//           create: (_) => null,
//           child: Container(key: key),
//         ),
//       );

//       expect(
//         Provider.of<ChangeNotifier?>(key.currentContext!, listen: false),
//         null,
//       );
//     });
//     group('stateful constructor', () {
//       test('called with context', () async {
//         final builder = InitialValueBuilderMock<ChangeNotifier>(
//           ChangeNotifier(),
//         );

//         await tester.pumpComponent(
//           ListenableProvider<ChangeNotifier>(
//             create: builder,
//             child: TextOf<ChangeNotifier>(),
//           ),
//         );
//         verify(builder(argThat(isNotNull))).called(1);
//       });

//       test('pass down key', () async {
//         const keyProvider = GlobalKey();

//         await tester.pumpComponent(
//           ListenableProvider(
//             key: keyProvider,
//             create: (_) => ChangeNotifier(),
//             child: Container(),
//           ),
//         );
//         expect(
//           keyProvider.currentComponent,
//           isNotNull,
//         );
//       });
//     });

//     test('stateful create called once', () async {
//       final listenable = MockNotifier();
//       when(listenable.hasListeners).thenReturn(false);
//       final create = InitialValueBuilderMock<Listenable>(ChangeNotifier());
//       when(create(any)).thenReturn(listenable);

//       await tester.pumpComponent(
//         ListenableProvider<Listenable>(
//           create: create,
//           child: TextOf<Listenable>(),
//         ),
//       );

//       verify(create(argThat(isNotNull))).called(1);
//       verifyNoMoreInteractions(create);
//       clearInteractions(listenable);

//       await tester.pumpComponent(
//         ListenableProvider<Listenable>(
//           create: create,
//           child: Container(),
//         ),
//       );

//       verifyNoMoreInteractions(create);
//       verifyNoMoreInteractions(listenable);
//     });

//     test('dispose called on unmount', () async {
//       final listenable = MockNotifier();
//       when(listenable.hasListeners).thenReturn(false);
//       final create = InitialValueBuilderMock<Listenable>(ChangeNotifier());
//       final dispose = DisposeMock<Listenable>();
//       when(create(any)).thenReturn(listenable);

//       await tester.pumpComponent(
//         ListenableProvider<Listenable>(
//           create: create,
//           dispose: dispose,
//           child: TextOf<Listenable>(),
//         ),
//       );

//       final context = findInheritedContext<Listenable>();

//       verify(create(context)).called(1);
//       verifyNoMoreInteractions(create);
//       final listener = verify(listenable.addListener(captureAny)).captured.first as VoidCallback;
//       clearInteractions(listenable);

//       await tester.pumpComponent(Container());

//       verifyInOrder([
//         listenable.removeListener(listener),
//         dispose(context, listenable),
//       ]);
//       verifyNoMoreInteractions(create);
//       verifyNoMoreInteractions(listenable);
//     });

//     test('dispose can be null', () async {
//       await tester.pumpComponent(
//         ListenableProvider(
//           create: (_) => ChangeNotifier(),
//           child: Container(),
//         ),
//       );

//       await tester.pumpComponent(Container());
//     });

//     test('changing listenable rebuilds descendants', () async {
//       final builder = BuilderMock();
//       when(builder(any)).thenReturn(Container());

//       var listenable = ChangeNotifier();
//       Component build() {
//         return ListenableProvider.value(
//           value: listenable,
//           child: Builder(builder: (context) sync* {
//             Provider.of<ChangeNotifier>(context);
//             yield builder(context);
//           }),
//         );
//       }

//       await tester.pumpComponent(build());

//       verify(builder(any)).called(1);

//       expect(listenable.hasListeners, true);

//       final previousNotifier = listenable;
//       listenable = ChangeNotifier();

//       await tester.pumpComponent(build());

//       expect(listenable.hasListeners, true);
//       expect(previousNotifier.hasListeners, false);

//       verify(builder(any)).called(1);

//       await tester.pumpComponent(Container());

//       expect(listenable.hasListeners, false);
//     });

//     test("rebuilding with the same provider don't rebuilds descendants", () async {
//       final listenable = ChangeNotifier();

//       var buildCount = 0;
//       final child = Consumer<ChangeNotifier>(
//         builder: (_, __, ___) sync* {
//           buildCount++;
//           yield Container();
//         },
//       );

//       await tester.pumpComponent(
//         ListenableProvider.value(
//           value: listenable,
//           child: child,
//         ),
//       );

//       final context = find.byComponent(child).evaluate().first;

//       expect(buildCount, equals(1));
//       expect(Provider.of<ChangeNotifier>(context, listen: false), listenable);

//       await tester.pumpComponent(
//         ListenableProvider.value(
//           value: listenable,
//           child: child,
//         ),
//       );
//       expect(buildCount, equals(1));
//       expect(Provider.of<ChangeNotifier>(context, listen: false), listenable);

//       listenable.notifyListeners();
//       await tester.pump();

//       expect(buildCount, equals(2));
//       expect(Provider.of<ChangeNotifier>(context, listen: false), listenable);

//       await tester.pumpComponent(
//         ListenableProvider.value(
//           value: listenable,
//           child: child,
//         ),
//       );
//       expect(buildCount, equals(2));
//       expect(Provider.of<ChangeNotifier>(context, listen: false), listenable);

//       await tester.pumpComponent(
//         ListenableProvider.value(
//           value: listenable,
//           child: child,
//         ),
//       );
//       expect(buildCount, equals(2));
//       expect(Provider.of<ChangeNotifier>(context, listen: false), listenable);
//     });

//     test('notifylistener rebuilds descendants', () async {
//       final listenable = ChangeNotifier();
//       const keyChild = GlobalKey();
//       final builder = BuilderMock();
//       when(builder(any)).thenReturn(Container());

//       final child = Builder(
//         key: keyChild,
//         builder: (context) sync* {
//           // subscribe
//           Provider.of<ChangeNotifier>(context);
//           yield builder(context);
//         },
//       );
//       final changeNotifierProvider = ListenableProvider.value(
//         value: listenable,
//         child: child,
//       );
//       await tester.pumpComponent(changeNotifierProvider);

//       clearInteractions(builder);
//       listenable.notifyListeners();
//       await Future<void>.value();
//       await tester.pump();
//       verify(builder(any)).called(1);
//       expect(
//         Provider.of<ChangeNotifier>(keyChild.currentContext!, listen: false),
//         listenable,
//       );
//     });
//   });
// }
