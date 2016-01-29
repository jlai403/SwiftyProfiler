import Foundation

public class SwiftyProfiler {
    
    public static var ENABLED: Bool = true
    
    public static let sharedInstance = SwiftyProfiler()
    
    private var timings = [String: Timing]()
    
    private init() {
    }
    
    public func startRecording(label: String) {
        if !SwiftyProfiler.ENABLED {
            return
        }
        
        timings[label] = Timing(label: label, start: NSDate())
    }
    
    public func stopRecording(label: String) {
        if !SwiftyProfiler.ENABLED {
            return
        }
        
        if let timing = timings[label] {
            timing.stop = NSDate()
        }
    }
 
    public func getResults(label: String) -> Timing? {
        return timings[label]
    }
    
    public func clear() {
        timings.removeAll()
    }
}
