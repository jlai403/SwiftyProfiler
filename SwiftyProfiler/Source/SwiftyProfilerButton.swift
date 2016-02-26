import UIKit

public class SwiftyProfilerButton: UIButton {
    
    private static let SIZE = CGSizeMake(50.0, 50.0)
    private static let LEFT_EDGE = CGFloat(0.0)
    private static let RIGHT_EDGE = UIScreen.mainScreen().bounds.width - SIZE.width
    private static let TOP_RIGHT_CORNER = CGPointMake(RIGHT_EDGE, SIZE.height)

    
    private var beingDragged: Bool = false
    
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
        self.addTarget(self, action: Selector("dragBegan:event:"), forControlEvents: UIControlEvents.TouchDown)
        self.addTarget(self, action: Selector("dragMoving:event:"), forControlEvents: UIControlEvents.TouchDragInside)
        self.addTarget(self, action: Selector("dragEnded:event:"), forControlEvents: [UIControlEvents.TouchUpInside, UIControlEvents.TouchUpOutside])
    }
    
    func showLog(sender: UIButton) {
        guard let vc = UIApplication.sharedApplication().keyWindow?.getTopViewController() else {
            return
        }
        
        if self.beingDragged {
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

    func dragBegan(sender: UIButton, event: UIEvent) {
        self.performSelector(Selector("showLog:"), withObject: sender, afterDelay: 0.1)
    }
    
    func dragMoving(sender: UIButton, event: UIEvent) {
        self.beingDragged = true
        
        if let touches = event.touchesForView(sender), touch = touches.first {
            move(touch)
        }
    }
    
    func dragEnded(sender: UIButton, event: UIEvent) {
        animateMoveToEdge {
            self.beingDragged = false
        }
    }
    
    private func move(touch: UITouch) {
        let previousLocation = touch.previousLocationInView(self)
        let location = touch .locationInView(self)
        let deltaX = location.x - previousLocation.x
        let deltaY = location.y - previousLocation.y
        self.center = CGPointMake(self.center.x + deltaX, self.center.y + deltaY);
    }
    
    private func animateMoveToEdge(onComplete: ()->Void) {
        let midX = UIScreen.mainScreen().bounds.midX
        var frame = self.frame
        frame.origin.x = self.center.x < midX ? SwiftyProfilerButton.LEFT_EDGE : SwiftyProfilerButton.RIGHT_EDGE
        
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.CurveEaseOut,
            animations: { () -> Void in
                self.frame = frame
            },
            completion: { (finished) -> Void in
                onComplete()
            }
        )
    }
}