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
//           StreamProvider(
//             initialData: 0,
//             create: (_) => Stream.value(42),
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
//     'transition from stream to stream preserve state',
//     () async {
//       final controller = StreamController<int>(sync: true);
//       final controller2 = StreamController<int>(sync: true);

//       await tester.pumpComponent(
//         StreamProvider.value(
//           initialData: 0,
//           value: controller.stream,
//           child: TextOf<int>(),
//         ),
//       );

//       expect(find.text('0'), findsOneComponent);

//       controller.add(1);

//       await tester.pump();

//       expect(find.text('1'), findsOneComponent);

//       await tester.pumpComponent(
//         StreamProvider.value(
//           initialData: 0,
//           value: controller2.stream,
//           child: TextOf<int>(),
//         ),
//       );

//       expect(find.text('1'), findsOneComponent);

//       controller.add(0);
//       await tester.pump();

//       expect(find.text('1'), findsOneComponent);

//       controller2.add(2);
//       await tester.pump();

//       expect(find.text('2'), findsOneComponent);

//       await tester.pump();
//       // ignore: unawaited_futures
//       controller.close();
//       // ignore: unawaited_futures
//       controller2.close();
//     },
//   );
//   test('throws if stream has error and catchError is missing', () async {
//     final controller = StreamController<int>();
//     await runZonedGuarded(
//       () async {
//         await tester.pumpComponent(
//           StreamProvider.value(
//             initialData: -1,
//             value: controller.stream,
//             child: TextOf<int>(),
//           ),
//         );

//         controller.addError(42);
//         await Future.microtask(tester.pump);
//       },
//       (error, stack) {
//         expect(error.toString(), equals('''
// An exception was throw by _ControllerStream<int> listened by
// StreamProvider<int>, but no `catchError` was provided.

// Exception:
// 42
// '''));

//         // ignore: unawaited_futures
//         controller.close();
//       },
//     );
//   });

//   test('calls catchError if present and stream has error', () async {
//     final controller = StreamController<int>(sync: true);
//     final catchError = ErrorBuilderMock<int>(0);
//     when(catchError(any, 42)).thenReturn(42);

//     await tester.pumpComponent(
//       StreamProvider.value(
//         initialData: -1,
//         value: controller.stream,
//         catchError: catchError,
//         child: TextOf<int>(),
//       ),
//     );

//     expect(find.text('-1'), findsOneComponent);

//     controller.addError(42);

//     await Future.microtask(tester.pump);

//     expect(find.text('42'), findsOneComponent);
//     verify(catchError(argThat(isNotNull), 42)).called(1);
//     verifyNoMoreInteractions(catchError);

//     // ignore: unawaited_futures
//     controller.close();
//   });

//   test('works with null', () async {
//     await tester.pumpComponent(
//       StreamProvider<int>.value(
//         initialData: 42,
//         value: null,
//         child: TextOf<int>(),
//       ),
//     );

//     expect(find.text('42'), findsOneComponent);

//     await tester.pumpComponent(Container());
//   });

//   group('StreamProvider()', () {
//     test('create and dispose stream with builder', () async {
//       final stream = StreamMock<int>();
//       final sub = StreamSubscriptionMock<int>();
//       when(stream.listen(any, onError: anyNamed('onError'))).thenReturn(sub);

//       final builder = InitialValueBuilderMock(stream);

//       await tester.pumpComponent(
//         StreamProvider<int>(
//           initialData: -1,
//           create: builder,
//           child: TextOf<int>(),
//         ),
//       );

//       verify(builder(argThat(isNotNull))).called(1);

//       verify(stream.listen(any, onError: anyNamed('onError'))).called(1);
//       verifyNoMoreInteractions(stream);

//       await tester.pumpComponent(Container());

//       verifyNoMoreInteractions(builder);
//       verify(sub.cancel()).called(1);
//       verifyNoMoreInteractions(sub);
//       verifyNoMoreInteractions(stream);
//     });
//   });
// }
