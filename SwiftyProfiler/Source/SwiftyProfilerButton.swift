import UIKit

public class SwiftyProfilerButton: UIButton {
    
    private static let SIZE = CGSizeMake(50.0, 50.0)
    private static let TOP_RIGHT_CORNER = CGPointMake(UIScreen.mainScreen().bounds.width - SIZE.width, SIZE.height)
    
    static func newInstance() -> SwiftyProfilerButton {
        return SwiftyProfilerButton(frame: CGRect(origin: TOP_RIGHT_CORNER, size: SIZE))
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = UIColor(red: 0.525, green: 0.886, blue: 0.835, alpha: 1.0)
        self.setTitle("SP", forState: .Normal)
        self.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.masksToBounds = true
    }
    
    public override func didMoveToSuperview() {
        self.addTarget(self, action: Selector("showLog:"), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func showLog(sender: UIButton) {
        guard let vc = UIApplication.sharedApplication().keyWindow?.getTopViewController() else {
            return
        }
        
        let swiftyProfilerStoryboard = UIStoryboard(name: "SwiftyProfiler", bundle: nil)
        
        if let profilerLogViewController = swiftyProfilerStoryboard.instantiateViewControllerWithIdentifier("SwiftyProfilerLog") as? SwiftyProfilerLogController {
            profilerLogViewController.onDismiss = {
                sender.hidden = false
                sender.enabled = true
            }
            
            vc.presentViewController(profilerLogViewController, animated: true) {
                sender.hidden = true
                sender.enabled = false
            }
        }
    }
}