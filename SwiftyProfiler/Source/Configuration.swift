import Foundation

public class Configuration: NSObject {
    
    public static var sharedInstance = Configuration()
    
    private var configSettings: NSDictionary
    
    private override init() {
        if let path = NSBundle(forClass: self.dynamicType).pathForResource("SwiftyProfiler", ofType: "plist") {
            self.configSettings = NSDictionary(contentsOfFile: path)!
        } else {
            fatalError("SwiftyProfiler.plist not found.")
        }
    }
    
    public var enabled: Bool {
        get {
            if let setting = configSettings["enabled"] as? Bool {
                return setting
            }
            fatalError("'enabled' property not found.")
        }
    }
    
    public var guiEnabled: Bool {
        get {
            if let setting = configSettings["gui_enabled"] as? Bool {
                return setting
            }
            fatalError("'gui_enabled' property not found.")
        }
    }
}