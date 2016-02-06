import Foundation

public class Configuration {
    
    public static var sharedInstance = Configuration()
    
    private var configSettings: NSDictionary
    
    private init() {
        if let path = NSBundle(forClass: self.dynamicType).pathForResource("SwiftyProfiler", ofType: "plist") {
            self.configSettings = NSDictionary(contentsOfFile: path)!
        } else {
            fatalError("SwiftyProfiler.plist not found.")
        }
    }
    
    public var enabled: Bool {
        get {
            return configSettings["enabled"] as! Bool
        }
    }
}