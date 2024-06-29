// import 'package:jaspr/jaspr.dart';
// import 'package:jaspr_provider/jaspr_provider.dart';
// import 'package:jaspr_test/jaspr_test.dart';
// import 'package:mockito/mockito.dart';

// import 'common.dart';

// class ValueBuilder extends Mock {
//   int? call(BuildContext? context);
// }

// class Dispose extends Mock {
//   void call(BuildContext context, int value);
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
//           Provider(
//             create: (_) => 42,
//           ),
//         ],
//         child: TextOf<int>(),
//       ),
//     );

//     expect(find.text('42'), findsOneComponent);
//   });

//   test('calls create only once', () async {
//     final create = ValueBuilder();

//     await tester.pumpComponent(Provider<int?>(
//       create: create,
//       child: TextOf<int?>(),
//     ));

//     await tester.pumpComponent(Provider<int?>(
//       create: create,
//       child: TextOf<int?>(),
//     ));

//     await tester.pumpComponent(Container());

//     verify(create(any)).called(1);
//   });

//   test('dispose', () async {
//     final dispose = Dispose();

//     await tester.pumpComponent(
//       Provider<int>(
//         create: (_) => 42,
//         dispose: dispose,
//         child: TextOf<int>(),
//       ),
//     );

//     final context = findInheritedContext<int>();

//     verifyZeroInteractions(dispose);
//     await tester.pumpComponent(Container());
//     verify(dispose(context, 42)).called(1);
//   });
// }
