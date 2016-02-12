import UIKit

public class SwiftyProfilerManager: NSObject {
    
    // MARK: AppDelegate methods

    func applicationDidBecomeActive(application: UIApplication) {
        guard let window = application.keyWindow else {
            return
        }
        
        if Configuration.sharedInstance.guiEnabled {
        }
    }
}