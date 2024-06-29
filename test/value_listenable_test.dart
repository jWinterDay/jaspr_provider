// import 'package:jaspr/jaspr.dart';
// import 'package:jaspr_provider/jaspr_provider.dart';
// import 'package:jaspr_test/jaspr_test.dart';
// import 'package:mockito/mockito.dart';

// import 'common.dart';

// class ValueNotifierMock<T> extends Mock implements ValueNotifier<T> {
//   ValueNotifierMock(this.fallbackValue);

//   final T fallbackValue;

//   @override
//   T get value => super.noSuchMethod(
//         Invocation.getter(#value),
//         returnValue: fallbackValue,
//         returnValueForMissingStub: fallbackValue,
//       ) as T;

//   @override
//   void addListener(VoidCallback? listener) {
//     super.noSuchMethod(
//       Invocation.method(#addListener, [listener]),
//     );
//   }

//   @override
//   void removeListener(VoidCallback? listener) {
//     super.noSuchMethod(
//       Invocation.method(#removeListener, [listener]),
//     );
//   }
// }

// void main() {
//   late ComponentTester tester;

//   setUpAll(() {
//     tester = ComponentTester.setUp();
//   });

//   group('valueListenableProvider', () {
//     test('rebuilds when value change', () async {
//       final listenable = ValueNotifier(0);

//       final child = Builder(builder: (context) sync* {
//         yield Text(Provider.of<int>(context).toString());
//       });

//       await tester.pumpComponent(
//         ValueListenableProvider.value(
//           value: listenable,
//           child: child,
//         ),
//       );

//       expect(find.text('0'), findsOneComponent);
//       listenable.value++;
//       await tester.pump();
//       expect(find.text('1'), findsOneComponent);
//     });

//     test("don't rebuild dependents by default", () async {
//       var buildCount = 0;
//       final listenable = ValueNotifier(0);
//       final child = Builder(builder: (context) sync* {
//         buildCount++;
//         yield Container();
//       });

//       await tester.pumpComponent(
//         ValueListenableProvider.value(
//           value: listenable,
//           child: child,
//         ),
//       );

//       expect(buildCount, 1);

//       await tester.pumpComponent(
//         ValueListenableProvider.value(
//           value: listenable,
//           child: child,
//         ),
//       );

//       expect(buildCount, 1);
//     });

//     test('pass keys', () async {
//       const key = GlobalKey();
//       await tester.pumpComponent(
//         ValueListenableProvider.value(
//           key: key,
//           value: ValueNotifier(42),
//           child: Container(),
//         ),
//       );

//       expect(key.currentComponent, isA<ValueListenableProvider<int>>());
//     });

//     test("don't listen again if Value instance doesn't change", () async {
//       final valueNotifier = ValueNotifierMock<int>(0);
//       await tester.pumpComponent(
//         ValueListenableProvider.value(
//           value: valueNotifier,
//           child: TextOf<int>(),
//         ),
//       );
//       await tester.pumpComponent(
//         ValueListenableProvider.value(
//           value: valueNotifier,
//           child: TextOf<int>(),
//         ),
//       );

//       verify(valueNotifier.addListener(any)).called(1);
//       verify(valueNotifier.value);
//       verifyNoMoreInteractions(valueNotifier);
//     });

//     test('pass updateShouldNotify', () async {
//       final shouldNotify = UpdateShouldNotifyMock<int>();
//       when(shouldNotify(0, 1)).thenReturn(true);

//       final notifier = ValueNotifier(0);
//       await tester.pumpComponent(
//         ValueListenableProvider.value(
//           value: notifier,
//           updateShouldNotify: shouldNotify,
//           child: TextOf<int>(),
//         ),
//       );

//       verifyZeroInteractions(shouldNotify);

//       notifier.value++;
//       await tester.pump();

//       verify(shouldNotify(0, 1)).called(1);
//       verifyNoMoreInteractions(shouldNotify);
//     });
//   });
// }
