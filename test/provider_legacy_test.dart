// // Mixed mode: test is legacy, runtime is legacy, package:provider is null safe.
// // @dart=2.11
// import 'package:jaspr/jaspr.dart';
// import 'package:jaspr_provider/jaspr_provider.dart';
// import 'package:jaspr_test/jaspr_test.dart';

// import 'common.dart';

// void main() {
//   ComponentTester tester;

//   setUpAll(() {
//     tester = ComponentTester.setUp();
//   });

//   // See `provider_test.dart` for corresponding sound mode test.
//   test('unsound provide T? inject T*', () async {
//     double value;

//     final builder = Builder(
//       builder: (context) sync* {
//         // Look up a Provider<double>.
//         value = Provider.of<double>(context, listen: false);
//         yield Container();
//       },
//     );

//     await tester.pumpComponent(
//       // Install a Provider<double?>.
//       nullableProviderOfValue<double>(
//         24,
//         Provider<int>.value(
//           value: 42,
//           child: builder,
//         ),
//       ),
//     );

//     // Provider<double> not found, uses Provider<double?> instead.
//     expect(value, equals(24.0));
//   });

//   test('unsound provide T inject T*', () async {
//     double value;

//     final builder = Builder(
//       builder: (context) sync* {
//         // Look up a Provider<double>.
//         value = Provider.of<double>(context, listen: false);
//         yield Container();
//       },
//     );

//     await tester.pumpComponent(
//       // Install a Provider<double>.
//       nullSafeProviderOfValue<double>(
//         24,
//         Provider<int>.value(
//           value: 42,
//           child: builder,
//         ),
//       ),
//     );

//     // Provider<double> not found, uses Provider<double?> instead.
//     expect(value, equals(24.0));
//   });

//   test('unsound provide T* inject T*', () async {
//     double value;

//     final builder = Builder(
//       builder: (context) sync* {
//         // Look up a Provider<double>.
//         value = Provider.of<double>(context, listen: false);
//         yield Container();
//       },
//     );

//     await tester.pumpComponent(
//       // Install a Provider<double*>.
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

//   /// with nulls
//   test('unsound provide null T? inject T*', () async {
//     double value;

//     final builder = Builder(
//       builder: (context) sync* {
//         // Look up a Provider<double>.
//         value = Provider.of<double>(context, listen: false);
//         yield Container();
//       },
//     );

//     await tester.pumpComponent(
//       // Install a Provider<double?>.
//       nullableProviderOfValue<double>(
//         null,
//         Provider<int>.value(
//           value: 42,
//           child: builder,
//         ),
//       ),
//     );

//     // Provider<double> not found, uses Provider<double?> instead.
//     expect(value, equals(null));
//   });

//   test('unsound provide null T inject T*', () async {
//     double value;

//     final builder = Builder(
//       builder: (context) sync* {
//         // Look up a Provider<double>.
//         value = Provider.of<double>(context, listen: false);
//         yield Container();
//       },
//     );

//     await tester.pumpComponent(
//       // Install a Provider<double>.
//       nullSafeProviderOfValue<double>(
//         null,
//         Provider<int>.value(
//           value: 42,
//           child: builder,
//         ),
//       ),
//     );

//     // Provider<double> not found, uses Provider<double?> instead.
//     expect(value, equals(null));
//   });

//   test('unsound provide null T* inject T*', () async {
//     double value;

//     final builder = Builder(
//       builder: (context) sync* {
//         // Look up a Provider<double>.
//         value = Provider.of<double>(context, listen: false);
//         yield Container();
//       },
//     );

//     await tester.pumpComponent(
//       // Install a Provider<double*>.
//       Provider<double>.value(
//         // ignore: avoid_redundant_argument_values
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
