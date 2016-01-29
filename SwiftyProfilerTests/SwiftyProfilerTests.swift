
import XCTest
@testable import SwiftyProfiler

public class SwiftyProfilerTests: XCTestCase {
    
    override public func setUp() {
        super.setUp()
        SwiftyProfiler.ENABLED = true
    }
    
    override public func tearDown() {
        super.tearDown()
        SwiftyProfiler.sharedInstance.clear()
    }
    
    func test_stopRecording() {
        // assemble
        let label = "test_stopRecording"
        SwiftyProfiler.sharedInstance.startRecording(label)
        sleep(2)
        
        // act
        SwiftyProfiler.sharedInstance.stopRecording(label)
        
        // assert
        let timing = SwiftyProfiler.sharedInstance.getResults(label)
        
        XCTAssertNotNil(timing)
        XCTAssertEqualWithAccuracy(2.0, timing!.elapsedTime().toSecs(), accuracy: 0.1)
        XCTAssertEqualWithAccuracy(2000.0, timing!.elapsedTime().toMillis(), accuracy: 100.0)
    }
}
