// import 'dart:async';

// import 'package:jaspr/jaspr.dart';
// import 'package:jaspr_provider/jaspr_provider.dart';
// import 'package:jaspr_test/jaspr_test.dart';
// import 'package:mockito/mockito.dart';

// import 'common.dart';

// class ErrorBuilderMock<T> extends Mock {
//   ErrorBuilderMock(this.fallback);

//   final T fallback;

//   T call(BuildContext? context, Object? error) {
//     return super.noSuchMethod(
//       Invocation.method(#call, [context, error]),
//       returnValue: fallback,
//       returnValueForMissingStub: fallback,
//     ) as T;
//   }
// }

// void main() {
//   late ComponentTester tester;

//   setUpAll(() {
//     tester = ComponentTester.setUp();
//   });

//   test('works with MultiProvider', () async {
//     await tester.pumpComponent(
//       MultiProvider(
//         providers: [
//           FutureProvider.value(
//             initialData: 0,
//             value: Future.value(42),
//           ),
//         ],
//         child: TextOf<int>(),
//       ),
//     );

//     expect(find.text('0'), findsOneComponent);

//     await Future.microtask(tester.pump);

//     expect(find.text('42'), findsOneComponent);
//   });

//   test(
//     '(catchError) previous future completes after transition is no-op',
//     () async {
//       final controller = Completer<int>();
//       final controller2 = Completer<int>();

//       await tester.pumpComponent(
//         FutureProvider.value(
//           initialData: 0,
//           value: controller.future,
//           child: TextOf<int>(),
//         ),
//       );

//       expect(find.text('0'), findsOneComponent);

//       await tester.pumpComponent(
//         FutureProvider.value(
//           initialData: 1,
//           value: controller2.future,
//           child: TextOf<int>(),
//         ),
//       );

//       expect(find.text('0'), findsOneComponent);

//       controller.complete(1);
//       await Future.microtask(tester.pump);

//       expect(find.text('0'), findsOneComponent);

//       controller2.complete(2);

//       await Future.microtask(tester.pump);

//       expect(find.text('0'), findsNothing);
//       expect(find.text('2'), findsOneComponent);
//     },
//   );
//   test(
//     'previous future completes after transition is no-op',
//     () async {
//       final controller = Completer<int>();
//       final controller2 = Completer<int>();

//       await tester.pumpComponent(
//         FutureProvider.value(
//           initialData: 0,
//           value: controller.future,
//           child: TextOf<int>(),
//         ),
//       );

//       expect(find.text('0'), findsOneComponent);

//       await tester.pumpComponent(
//         FutureProvider.value(
//           initialData: 1,
//           value: controller2.future,
//           child: TextOf<int>(),
//         ),
//       );

//       expect(find.text('0'), findsOneComponent);

//       controller.complete(1);
//       await Future.microtask(tester.pump);

//       expect(find.text('0'), findsOneComponent);

//       controller2.complete(2);
//       await Future.microtask(tester.pump);

//       expect(find.text('2'), findsOneComponent);
//     },
//   );
//   test(
//     'transition from future to future preserve state',
//     () async {
//       final controller = Completer<int>();
//       final controller2 = Completer<int>();

//       await tester.pumpComponent(
//         FutureProvider.value(
//           initialData: 0,
//           value: controller.future,
//           child: TextOf<int>(),
//         ),
//       );

//       expect(find.text('0'), findsOneComponent);

//       controller.complete(1);

//       await Future.microtask(tester.pump);

//       expect(find.text('1'), findsOneComponent);

//       await tester.pumpComponent(
//         FutureProvider.value(
//           initialData: 0,
//           value: controller2.future,
//           child: TextOf<int>(),
//         ),
//       );

//       expect(find.text('1'), findsOneComponent);

//       controller2.complete(2);
//       await Future.microtask(tester.pump);

//       expect(find.text('2'), findsOneComponent);
//     },
//   );
//   test('throws if future has error and catchError is missing', () async {
//     await runZonedGuarded(
//       () async {
//         final controller = Completer<int>();

//         await tester.pumpComponent(
//           FutureProvider.value(
//             initialData: 0,
//             value: controller.future,
//             child: TextOf<int>(),
//           ),
//         );

//         controller.completeError(42);
//         await Future.microtask(tester.pump);
//       },
//       (error, stack) {
//         expect(error.toString(), equals('''
// An exception was throw by Future<int> listened by
// FutureProvider<int>, but no `catchError` was provided.

// Exception:
// 42
// '''));
//       },
//     );
//   });

//   test('calls catchError if present and future has error', () async {
//     final controller = Completer<int>();
//     final catchError = ErrorBuilderMock<int>(0);
//     when(catchError(any, 42)).thenReturn(42);

//     await tester.pumpComponent(
//       FutureProvider.value(
//         initialData: null,
//         value: controller.future,
//         catchError: catchError,
//         child: TextOf<int?>(),
//       ),
//     );

//     expect(find.text('null'), findsOneComponent);

//     controller.completeError(42);

//     await Future.microtask(tester.pump);

//     expect(find.text('42'), findsOneComponent);
//     verify(catchError(argThat(isNotNull), 42)).called(1);
//     verifyNoMoreInteractions(catchError);
//   });

//   test('works with null', () async {
//     await tester.pumpComponent(
//       FutureProvider<int>.value(
//         initialData: 42,
//         value: null,
//         child: TextOf<int>(),
//       ),
//     );

//     expect(find.text('42'), findsOneComponent);

//     await tester.pumpComponent(Container());
//   });

//   test('create and dispose future with builder', () async {
//     final completer = Completer<int>();

//     await tester.pumpComponent(
//       FutureProvider<int>(
//         initialData: 42,
//         create: (_) => completer.future,
//         child: TextOf<int>(),
//       ),
//     );

//     expect(find.text('42'), findsOneComponent);

//     completer.complete(24);

//     await Future.microtask(tester.pump);

//     expect(find.text('24'), findsOneComponent);
//   });
// }
