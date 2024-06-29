// import 'package:jaspr/jaspr.dart';
// import 'package:jaspr_provider/jaspr_provider.dart';
// import 'package:jaspr_provider/src/value_listenable_provider.dart';
// import 'package:jaspr_test/jaspr_test.dart';
// import 'package:mockito/mockito.dart' as mockito show when;
// import 'package:mockito/mockito.dart';

// import 'common.dart';

// void mockImplementation<T extends Function>(dynamic Function() when, T mock) {
//   mockito.when<dynamic>(when()).thenAnswer((invo) {
//     return Function.apply(mock, invo.positionalArguments, invo.namedArguments);
//   });
// }

// void main() {
//   final selector = MockSelector<int>(-1);
//   final builder = MockBuilder<int>();
//   late ComponentTester tester;

//   setUpAll(() {
//     tester = ComponentTester.setUp();
//   });

//   tearDown(() {
//     clearInteractions(builder);
//     clearInteractions(selector);
//   });

//   void mockBuilder(ValueComponentBuilder<int> implementation) {
//     mockImplementation(() => builder(any, any, any), implementation);
//   }

//   test('Deep compare maps by default', () async {
//     var value = <int, int>{};
//     final builder = MockBuilder<Map<int, int>>();
//     when(builder(any, any, any)).thenReturn([Container()]);

//     final selector = Selector0<Map<int, int>>(
//       selector: (_) => value,
//       builder: builder,
//     );
//     await tester.pumpComponent(selector);

//     verify(builder(argThat(isNotNull), value, null)).called(1);
//     verifyNoMoreInteractions(builder);

//     final element = find.byComponent(selector).evaluate().first;

//     value = {0: 0, 1: 1};
//     element.markNeedsBuild();
//     await tester.pump();

//     verify(builder(argThat(isNotNull), value, null)).called(1);
//     verifyNoMoreInteractions(builder);

//     value = {0: 0, 1: 1};
//     element.markNeedsBuild();
//     await tester.pump();

//     verifyNoMoreInteractions(builder);
//   });

//   test('Deep compare iterables by default', () async {
//     var value = <int>[].whereType<int>();
//     final builder = MockBuilder<Iterable<int>>();
//     when(builder(any, any, any)).thenReturn([Container()]);

//     final selector = Selector0<Iterable<int>>(
//       selector: (_) => value,
//       builder: builder,
//     );
//     await tester.pumpComponent(selector);

//     verify(builder(argThat(isNotNull), value, null)).called(1);
//     verifyNoMoreInteractions(builder);

//     final element = find.byComponent(selector).evaluate().first;

//     value = [1, 2].whereType<int>();
//     element.markNeedsBuild();
//     await tester.pump();

//     verify(builder(argThat(isNotNull), value, null)).called(1);
//     verifyNoMoreInteractions(builder);

//     value = [1, 2].whereType<int>();
//     element.markNeedsBuild();
//     await tester.pump();

//     verifyNoMoreInteractions(builder);
//   });

//   test('Deep compare sets by default', () async {
//     var value = <int>{};
//     final builder = MockBuilder<Set<int>>();
//     when(builder(any, any, any)).thenReturn([Container()]);

//     final selector = Selector0<Set<int>>(
//       selector: (_) => value,
//       builder: builder,
//     );
//     await tester.pumpComponent(selector);

//     verify(builder(argThat(isNotNull), value, null)).called(1);
//     verifyNoMoreInteractions(builder);

//     final element = find.byComponent(selector).evaluate().first;

//     value = {1, 2};
//     element.markNeedsBuild();
//     await tester.pump();

//     verify(builder(argThat(isNotNull), value, null)).called(1);
//     verifyNoMoreInteractions(builder);

//     value = {1, 2};
//     element.markNeedsBuild();
//     await tester.pump();

//     verifyNoMoreInteractions(builder);
//   });

//   test('Deep compare lists by default', () async {
//     var value = <int>[];
//     final builder = MockBuilder<List<int>>();
//     when(builder(any, any, any)).thenReturn([Container()]);

//     final selector = Selector0<List<int>>(
//       selector: (_) => value,
//       builder: builder,
//     );
//     await tester.pumpComponent(selector);

//     verify(builder(argThat(isNotNull), value, null)).called(1);
//     verifyNoMoreInteractions(builder);

//     final element = find.byComponent(selector).evaluate().first;

//     value = [1, 2];
//     element.markNeedsBuild();
//     await tester.pump();

//     verify(builder(argThat(isNotNull), value, null)).called(1);
//     verifyNoMoreInteractions(builder);

//     value = [1, 2];
//     element.markNeedsBuild();
//     await tester.pump();

//     verifyNoMoreInteractions(builder);
//   });

//   test('custom shouldRebuid', () async {
//     var value = 0;
//     var shouldRebuild = true;
//     final mockShouldRebuild = MockShouldRebuild<int>();
//     when(mockShouldRebuild(any, any)).thenAnswer((_) => shouldRebuild);

//     final builder = MockBuilder<int>();
//     when(builder(any, any, any)).thenReturn([Container()]);

//     final selector = Selector0<int>(
//       selector: (_) => value,
//       shouldRebuild: mockShouldRebuild,
//       builder: builder,
//     );
//     await tester.pumpComponent(selector);

//     verifyZeroInteractions(mockShouldRebuild);
//     verify(builder(argThat(isNotNull), 0, null)).called(1);
//     verifyNoMoreInteractions(builder);

//     final element = find.byComponent(selector).evaluate().first;

//     value = 1;
//     element.markNeedsBuild();
//     await tester.pump();

//     verify(mockShouldRebuild(0, 1)).called(1);
//     verifyNoMoreInteractions(mockShouldRebuild);
//     verify(builder(argThat(isNotNull), 1, null)).called(1);
//     verifyNoMoreInteractions(builder);

//     shouldRebuild = false;
//     value = 2;
//     element.markNeedsBuild();
//     await tester.pump();

//     verify(mockShouldRebuild(1, 2)).called(1);
//     verifyNoMoreInteractions(mockShouldRebuild);
//     verifyNoMoreInteractions(builder);
//   });

//   test('passes `child` and `key`', () async {
//     const key = GlobalKey();
//     await tester.pumpComponent(
//       Selector0<void>(
//         key: key,
//         selector: (_) {},
//         builder: (_, __, child) sync* {
//           yield child!;
//         },
//         child: const Text('42'),
//       ),
//     );

//     expect(key.currentContext, isNotNull);

//     expect(find.text('42'), findsOneComponent);
//   });

//   test('calls builder if the callback changes', () async {
//     await tester.pumpComponent(
//       Selector0<int>(
//         selector: (_) => 42,
//         builder: (_, __, ___) sync* {
//           yield const Text('foo');
//         },
//       ),
//     );

//     expect(find.text('foo'), findsOneComponent);

//     await tester.pumpComponent(
//       Selector0<int>(
//         selector: (_) => 42,
//         builder: (_, __, ___) sync* {
//           yield const Text('bar');
//         },
//       ),
//     );

//     expect(find.text('bar'), findsOneComponent);
//   });

//   test('works with MultiProvider', () async {
//     const key = GlobalKey();
//     int selector(BuildContext _) => 42;
//     Iterable<Component> builder(BuildContext _, int __, Component? child) => [child!];
//     const child = Text('foo');

//     await tester.pumpComponent(
//       MultiProvider(
//         providers: [
//           Selector0<int>(
//             key: key,
//             selector: selector,
//             builder: builder,
//           ),
//         ],
//         child: child,
//       ),
//     );

//     final widget = find.byComponentPredicate((w) => w is Selector0<int>).evaluate().first.component as Selector0<int>;

//     expect(find.text('foo'), findsOneComponent);
//     expect(widget.key, key);
//     expect(
//       widget.selector,
//       equals(selector),
//     );
//     expect(
//       widget.builder,
//       equals(builder),
//     );
//   });

//   test(
//       "don't call builder again if it rebuilds "
//       'but selector returns the same thing', () async {
//     when(selector(any)).thenReturn(42);

//     mockBuilder((_, value, ___) sync* {
//       yield Text(value.toString());
//     });

//     await tester.pumpComponent(
//       Selector0<int>(
//         selector: selector,
//         builder: builder,
//       ),
//     );

//     verify(selector(argThat(isNotNull))).called(1);
//     verifyNoMoreInteractions(selector);

//     verify(builder(argThat(isNotNull), 42, null)).called(1);
//     verifyNoMoreInteractions(selector);

//     expect(find.text('42'), findsOneComponent);

//     find.byComponentPredicate((w) => w is Selector0).evaluate().first.markNeedsBuild();

//     await tester.pump();

//     verify(selector(argThat(isNotNull))).called(1);
//     verifyNoMoreInteractions(builder);
//     verifyNoMoreInteractions(selector);
//     expect(find.text('42'), findsOneComponent);
//   });

//   test(
//       'call builder again if it rebuilds '
//       'abd selector returns the a different variable', () async {
//     when(selector(any)).thenReturn(42);

//     mockBuilder((_, value, ___) sync* {
//       yield Text(value.toString());
//     });

//     await tester.pumpComponent(
//       Selector0<int>(
//         selector: selector,
//         builder: builder,
//       ),
//     );

//     verify(selector(argThat(isNotNull))).called(1);
//     verifyNoMoreInteractions(selector);

//     verify(builder(argThat(isNotNull), 42, null)).called(1);
//     verifyNoMoreInteractions(selector);

//     expect(find.text('42'), findsOneComponent);

//     find.byComponentPredicate((w) => w is Selector0).evaluate().first.markNeedsBuild();

//     when(selector(any)).thenReturn(24);

//     await tester.pump();

//     verify(selector(argThat(isNotNull))).called(1);
//     verify(builder(argThat(isNotNull), 24, null)).called(1);
//     verifyNoMoreInteractions(selector);
//     verifyNoMoreInteractions(builder);
//     expect(find.text('24'), findsOneComponent);
//   });

//   test('Selector', () async {
//     await tester.pumpComponent(
//       MultiProvider(
//         providers: [
//           Provider.value(value: A()),
//         ],
//         child: Selector<A, String>(
//           selector: (_, a) => '$a',
//           builder: (_, value, __) => [Text(value)],
//         ),
//       ),
//     );

//     expect(find.text('A'), findsOneComponent);
//   });

//   test('Selector2', () async {
//     await tester.pumpComponent(
//       MultiProvider(
//         providers: [
//           Provider.value(value: A()),
//           Provider.value(value: B()),
//         ],
//         child: Selector2<A, B, String>(
//           selector: (_, a, b) => '$a $b',
//           builder: (_, value, __) => [Text(value)],
//         ),
//       ),
//     );

//     expect(find.text('A B'), findsOneComponent);
//   });

//   test('Selector3', () async {
//     await tester.pumpComponent(
//       MultiProvider(
//         providers: [
//           Provider.value(value: A()),
//           Provider.value(value: B()),
//           Provider.value(value: C()),
//         ],
//         child: Selector3<A, B, C, String>(
//           selector: (_, a, b, c) => '$a $b $c',
//           builder: (_, value, __) => [Text(value)],
//         ),
//       ),
//     );

//     expect(find.text('A B C'), findsOneComponent);
//   });

//   test('Selector4', () async {
//     await tester.pumpComponent(
//       MultiProvider(
//         providers: [
//           Provider.value(value: A()),
//           Provider.value(value: B()),
//           Provider.value(value: C()),
//           Provider.value(value: D()),
//         ],
//         child: Selector4<A, B, C, D, String>(
//           selector: (_, a, b, c, d) => '$a $b $c $d',
//           builder: (_, value, __) => [Text(value)],
//         ),
//       ),
//     );

//     expect(find.text('A B C D'), findsOneComponent);
//   });

//   test('Selector5', () async {
//     await tester.pumpComponent(
//       MultiProvider(
//         providers: [
//           Provider.value(value: A()),
//           Provider.value(value: B()),
//           Provider.value(value: C()),
//           Provider.value(value: D()),
//           Provider.value(value: E()),
//         ],
//         child: Selector5<A, B, C, D, E, String>(
//           selector: (_, a, b, c, d, e) => '$a $b $c $d $e',
//           builder: (_, value, __) => [Text(value)],
//         ),
//       ),
//     );

//     expect(find.text('A B C D E'), findsOneComponent);
//   });

//   test('Selector6', () async {
//     await tester.pumpComponent(
//       MultiProvider(
//         providers: [
//           Provider.value(value: A()),
//           Provider.value(value: B()),
//           Provider.value(value: C()),
//           Provider.value(value: D()),
//           Provider.value(value: E()),
//           Provider.value(value: F()),
//         ],
//         child: Selector6<A, B, C, D, E, F, String>(
//           selector: (_, a, b, c, d, e, f) => '$a $b $c $d $e $f',
//           builder: (_, value, __) => [Text(value)],
//         ),
//       ),
//     );

//     expect(find.text('A B C D E F'), findsOneComponent);
//   });
// }

// mixin _ToString {
//   @override
//   String toString() {
//     return runtimeType.toString();
//   }
// }

// class A with _ToString {}

// class B with _ToString {}

// class C with _ToString {}

// class D with _ToString {}

// class E with _ToString {}

// class F with _ToString {}

// class MockSelector<T> extends Mock {
//   MockSelector(this._fallback);

//   final T _fallback;

//   T call(BuildContext? context) {
//     return super.noSuchMethod(
//       Invocation.method(#call, [context]),
//       returnValue: _fallback,
//     ) as T;
//   }
// }

// class MockShouldRebuild<T> extends Mock {
//   bool call(T? prev, T? next) {
//     return super.noSuchMethod(
//       Invocation.method(#call, [prev, next]),
//       returnValue: false,
//     ) as bool;
//   }
// }

// class MockBuilder<T> extends Mock {
//   Iterable<Component> call(BuildContext? context, T? value, Component? child) {
//     return super.noSuchMethod(
//       Invocation.method(#call, [context, value, child]),
//       returnValue: Container(),
//     ) as Iterable<Component>;
//   }
// }
