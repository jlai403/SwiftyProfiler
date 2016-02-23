import Foundation

public class SwiftyProfiler: NSObject {
    
    public var enabled: Bool  {
        get {
            return Configuration.sharedInstance.enabled
        }
    }
    
    public static let sharedInstance = SwiftyProfiler()
    
    private var timings = [String: Timing]()
    
    private override init() {
    }
    
    public func startRecording(label: String) {
        if !enabled {
            return
        }
        
        timings[label] = Timing(label: label, start: NSDate())
    }
    
    public func stopRecording(label: String) {
        if !enabled {
            return
        }
        
        if let timing = timings[label] {
            timing.stop = NSDate()
            debugLog(timing)
        }
    }
    
    private func debugLog(timing: Timing) {
        NSLog("\(timing.label) completed in %.2fms", timing.elapsedTime().toMillis());
    }
    
    public func record(label: String, block: ()->()) {
        startRecording(label)
        block()
        stopRecording(label)
    }
 
    public func getResults(label: String) -> Timing? {
        return timings[label]
    }
    
    public func clear() {
        timings.removeAll()
    }
    
    public func getTimings() -> [Timing] {
        return self.timings.map({ (key, value) -> Timing in return value })
    }
}
