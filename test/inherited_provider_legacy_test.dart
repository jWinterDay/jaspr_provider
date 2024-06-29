// // Mixed mode: test is legacy, runtime is legacy, package:provider is null safe.
// // @dart=2.11
// import 'package:jaspr/jaspr.dart';
// import 'package:jaspr_provider/jaspr_provider.dart';
// import 'package:jaspr_test/jaspr_test.dart';

// import 'common.dart';

// BuildContext get context => find.byType(Context).evaluate().single;

// class Context extends StatelessComponent {
//   const Context({Key key}) : super(key: key);

//   @override
//   Iterable<Component> build(BuildContext context) sync* {
//     yield Container();
//   }
// }

// void main() {
//   ComponentTester tester;

//   setUpAll(() {
//     tester = ComponentTester.setUp();
//   });

//   test('allows nulls in mixed mode', () async {
//     // ignore: avoid_returning_null
//     int initialValueBuilder(BuildContext _) => null;

//     await tester.pumpComponent(
//       InheritedProvider<int>(
//         create: initialValueBuilder,
//         child: const Context(),
//       ),
//     );

//     expect(Provider.of<int>(context, listen: false), equals(null));
//     expect(Provider.of<int>(context, listen: false), equals(null));
//   });

//   test('throw ProviderNotFoundException in mixed mode if no provider exists', () async {
//     await tester.pumpComponent(const Context());

//     expect(
//       () => context.read<int>(),
//       throwsProviderNotFound<int>(),
//     );
//   });
// }
