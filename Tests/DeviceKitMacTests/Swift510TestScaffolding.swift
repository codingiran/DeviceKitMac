// Swift 5.10 cannot discover Swift Testing tests itself. Use the bridge provided
// by swift-testing 0.6.0; Swift 6 discovers the @Test functions directly.
#if compiler(<6.0)
    import Testing
    import XCTest

    final class Swift510TestScaffolding: XCTestCase {
        func testAll() async {
            await XCTestScaffold.runAllTests(hostedBy: self)
        }
    }
#endif
