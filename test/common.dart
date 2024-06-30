// import 'dart:async';

// import 'package:jaspr/jaspr.dart';
// import 'package:jaspr_provider/jaspr_provider.dart';
// import 'package:jaspr_test/jaspr_test.dart';
// import 'package:mockito/mockito.dart';

// Element findElementOfComponent<T extends Component>() {
//   return find.byType(T).first.evaluate().first;
// }

// final bool isSoundMode = <int?>[] is! List<int>;

// InheritedContext<T?> findInheritedContext<T>() {
//   return find.byElementPredicate((e) => e is InheritedContext<T?>).first.evaluate().first as InheritedContext<T?>;
// }

// /// Given `T`, returns a `Provider<T?>`.
// ///
// /// For use in legacy tests: they can't instantiate a `Provider<T?>` directly
// /// because they can't write `<T?>`. But, they can pass around a `Provider<T?`>.
// Provider<T?> nullableProviderOfValue<T>(T value, Provider? child) => Provider<T?>.value(
//       value: value,
//       child: child,
//     );

// /// Given `T`, returns a `Provider<T>`.
// ///
// /// For legacy tests to get a `Provider<T>`.
// Provider<T> nullSafeProviderOfValue<T>(T value, Provider? child) => Provider<T>.value(
//       value: value,
//       child: child,
//     );

// class InitialValueBuilderMock<T> extends Mock {
//   InitialValueBuilderMock(this._value) {
//     when(this(any)).thenAnswer((_) => _value);
//   }

//   final T _value;

//   T call(BuildContext? context) {
//     return super.noSuchMethod(
//       Invocation.method(#call, [context]),
//       returnValue: _value,
//       returnValueForMissingStub: _value,
//     ) as T;
//   }
// }

// class ValueBuilderMock<T> extends Mock {
//   ValueBuilderMock(this._value) {
//     when(this(any, any)).thenReturn(_value);
//   }

//   final T _value;

//   T call(BuildContext? context, T? previous) {
//     return super.noSuchMethod(
//       Invocation.method(#call, [context, previous]),
//       returnValue: _value,
//       returnValueForMissingStub: _value,
//     ) as T;
//   }
// }

// class TransitionBuilderMock extends Mock {
//   TransitionBuilderMock([Iterable<Component> Function(BuildContext c, Component child)? cb]) {
//     if (cb != null) {
//       when(this(any, any)).thenAnswer((i) {
//         final context = i.positionalArguments.first as BuildContext;
//         final child = i.positionalArguments[1] as Component;
//         return cb(context, child);
//       });
//     }
//   }

//   Iterable<Component> call(BuildContext? context, Component? child) sync* {
//     yield super.noSuchMethod(
//       Invocation.method(#call, [context, child]),
//       returnValue: Container(),
//     ) as Component;
//   }
// }

// class StartListeningMock<T> extends Mock {
//   StartListeningMock(VoidCallback value) {
//     when(this(any, any)).thenReturn(value);
//   }

//   VoidCallback call(InheritedContext<T?>? context, T? value) {
//     return super.noSuchMethod(
//       Invocation.method(#call, [context, value]),
//       returnValue: () {},
//     ) as VoidCallback;
//   }
// }

// class StopListeningMock extends Mock {
//   void call();
// }

// class DisposeMock<T> extends Mock {
//   void call(BuildContext? context, T? value) {
//     super.noSuchMethod(
//       Invocation.method(#call, [context, value]),
//     );
//   }
// }

// class MockNotifier extends Mock implements ChangeNotifier {
//   @override
//   void addListener(VoidCallback? listener);

//   @override
//   void removeListener(VoidCallback? listener);

//   @override
//   bool get hasListeners => super.noSuchMethod(
//         Invocation.getter(#hasListeners),
//         returnValue: false,
//         returnValueForMissingStub: false,
//       ) as bool;
// }

// class ValueComponentBuilderMock<T> extends Mock {
//   ValueComponentBuilderMock([
//     Iterable<Component> Function(BuildContext c, T value, Component child)? cb,
//   ]) {
//     if (cb != null) {
//       when(this(any, any, any)).thenAnswer((i) {
//         final context = i.positionalArguments.first as BuildContext;
//         final value = i.positionalArguments[1] as T;
//         final child = i.positionalArguments[2] as Component;
//         return cb(context, value, child);
//       });
//     }
//   }

//   Iterable<Component> call(BuildContext? context, T? value, Component? child) sync* {
//     yield super.noSuchMethod(
//       Invocation.method(#call, [context, value, child]),
//       returnValue: Container(),
//       returnValueForMissingStub: Container(),
//     ) as Component;
//   }
// }

// class BuilderMock extends Mock {
//   BuilderMock([Component Function(BuildContext c)? cb]) {
//     if (cb != null) {
//       when(this(any)).thenAnswer((i) {
//         final context = i.positionalArguments.first as BuildContext;
//         return cb(context);
//       });
//     }
//   }

//   Component call(BuildContext? context) {
//     return super.noSuchMethod(
//       Invocation.method(#call, [context]),
//       returnValue: Container(),
//       returnValueForMissingStub: Container(),
//     ) as Component;
//   }
// }

// class StreamMock<T> extends Mock implements Stream<T> {
//   @override
//   StreamSubscription<T> listen(
//     void Function(T event)? onData, {
//     Function? onError,
//     void Function()? onDone,
//     bool? cancelOnError,
//   }) {
//     return super.noSuchMethod(
//       Invocation.method(#listen, [
//         onData
//       ], {
//         #onError: onError,
//         #onDone: onDone,
//         #cancelOnError: cancelOnError,
//       }),
//       returnValue: StreamSubscriptionMock<T>(),
//       returnValueForMissingStub: StreamSubscriptionMock<T>(),
//     ) as StreamSubscription<T>;
//   }
// }

// class FutureMock<T> extends Mock implements Future<T> {}

// class StreamSubscriptionMock<T> extends Mock implements StreamSubscription<T> {
//   @override
//   Future<void> cancel() {
//     return super.noSuchMethod(
//       Invocation.method(#cancel, []),
//       returnValue: Future<void>.value(),
//       returnValueForMissingStub: Future<void>.value(),
//     ) as Future<void>;
//   }
// }

// class MockConsumerBuilder<T> extends Mock {
//   Iterable<Component> call(BuildContext? context, T? value, Component? child) sync* {
//     yield super.noSuchMethod(
//       Invocation.method(#call, [context, value, child]),
//       returnValue: Container(),
//       returnValueForMissingStub: Container(),
//     ) as Component;
//   }
// }

// class UpdateShouldNotifyMock<T> extends Mock {
//   bool call(T? old, T? newValue) {
//     return super.noSuchMethod(
//       Invocation.method(#call, [old, newValue]),
//       returnValue: false,
//       returnValueForMissingStub: false,
//     ) as bool;
//   }
// }

// class TextOf<T> extends StatelessComponent {
//   TextOf({Key? key}) : super(key: key);

//   @override
//   Iterable<Component> build(BuildContext context) sync* {
//     yield Text(Provider.of<T>(context).toString());
//   }
// }

// class DeferredStartListeningMock<T, R> extends Mock {
//   DeferredStartListeningMock([
//     VoidCallback Function(
//       InheritedContext<R?> context,
//       void Function(R value) setState,
//       T controller,
//       R? value,
//     )?
//         call,
//   ]) {
//     if (call != null) {
//       when(this(any, any, any, any)).thenAnswer((invoc) {
//         return Function.apply(
//           call,
//           invoc.positionalArguments,
//           invoc.namedArguments,
//         ) as VoidCallback;
//       });
//     }
//   }

//   VoidCallback call(
//     InheritedContext<R?>? context,
//     void Function(R value)? setState,
//     T? controller,
//     R? value,
//   ) =>
//       super.noSuchMethod(
//         Invocation.method(
//           #call,
//           [context, setState, controller, value],
//         ),
//         returnValue: () {},
//         returnValueForMissingStub: () {},
//       ) as VoidCallback;
// }

// class DebugCheckValueTypeMock<T> extends Mock {
//   void call(T value);
// }

// class A {}

// class B {}

// class C {}

// class D {}

// class E {}

// class F {}

// class MockCombinedBuilder extends Mock {
//   Iterable<Component> call(Combined? foo) sync* {
//     yield super.noSuchMethod(
//       Invocation.method(#call, [foo]),
//       returnValue: Container(),
//       returnValueForMissingStub: Container(),
//     ) as Component;
//   }
// }

// class CombinerMock extends Mock {
//   Combined call(BuildContext? context, A? a, Combined? foo) {
//     return super.noSuchMethod(
//       Invocation.method(#call, [context, a, foo]),
//       returnValue: const Combined(),
//       returnValueForMissingStub: const Combined(),
//     ) as Combined;
//   }
// }

// class ProviderBuilderMock extends Mock {
//   Component call(BuildContext context, Combined value, Component child);
// }

// class MyStream extends Fake implements Stream<int> {}

// @immutable
// class Combined {
//   const Combined([
//     this.context,
//     this.previous,
//     this.a,
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
//   final Combined? previous;
//   final BuildContext? context;

//   @override
//   // ignore: hash_and_equals
//   bool operator ==(Object other) =>
//       other is Combined &&
//       other.context == context &&
//       other.previous == previous &&
//       other.a == a &&
//       other.b == b &&
//       other.c == c &&
//       other.e == e &&
//       other.f == f;
// }

// class MyListenable extends ChangeNotifier {}

// int buildCountOf(BuildCount component) {
//   return ((find.byComponent(component).evaluate().single as StatefulElement).state as _BuildCountState).buildCount;
// }

// class BuildCount extends StatefulComponent {
//   const BuildCount(this.builder, {Key? key}) : super(key: key);

//   final ComponentBuilder builder;

//   @override
//   _BuildCountState createState() => _BuildCountState();
// }

// class _BuildCountState extends State<BuildCount> {
//   int buildCount = 0;

//   @override
//   Iterable<Component> build(BuildContext context) {
//     buildCount++;
//     return component.builder(context);
//   }
// }

// Matcher throwsProviderNotFound<T>() {
//   return throwsA(isA<ProviderNotFoundException>().having((err) => err.valueType, 'valueType', T));
// }

// class Container extends StatelessComponent {
//   Container({this.child, Key? key}) : super(key: key);

//   final Component? child;

//   @override
//   Iterable<Component> build(BuildContext context) sync* {
//     yield DomComponent(
//       tag: 'div',
//       child: child,
//     );
//   }
// }

// class GestureDetector extends StatelessComponent {
//   GestureDetector({
//     required this.child,
//     this.onTap,
//   });

//   final Component child;
//   final VoidCallback? onTap;

//   @override
//   Iterable<Component> build(BuildContext context) sync* {
//     yield DomComponent(
//       tag: 'button',
//       events: {
//         'click': (dynamic event) => onTap?.call(),
//       },
//       child: child,
//     );
//   }
// }

// class SizedBox extends StatelessComponent {
//   const SizedBox({this.child});

//   final Component? child;

//   @override
//   Iterable<Component> build(BuildContext context) sync* {
//     final child = this.child;
//     if (child != null) {
//       yield child;
//     }
//   }
// }
