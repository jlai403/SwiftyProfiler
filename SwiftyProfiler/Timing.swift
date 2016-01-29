import Foundation

public class Timing {
    
    var label: String
    var start: NSDate?
    var stop: NSDate?
    
    private init(label: String) {
        self.label = label
    }
    
    convenience init(label:String, start: NSDate) {
        self.init(label: label)
        self.start = start
    }
    
    public func debugLog() {
        NSLog("'\(label)' completed in %.5f", elapsedTime())
    }
    
    public func elapsedTime() -> NSTimeInterval {
        guard let start = start, stop = stop else {
            return -1
        }
        
        return stop.timeIntervalSinceDate(start)
    }
}

extension NSTimeInterval {
    
    func toMillis() -> Double {
        return toSecs() * 1000
    }
    
    func toSecs() -> Double {
        return self % 60
    }
    
}