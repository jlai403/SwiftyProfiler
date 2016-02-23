import Foundation
import UIKit

public class SwiftyProfilerLogController: UIViewController {
    
    public var onDismiss: (()->())!
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var logsTableView: UITableView!
    private var swiftyProfilerTableViewData: SwiftyProfilerTableViewData!
    
    public override func viewDidLoad() {
        setupTable()
    }
    
    private func setupTable() {
        self.swiftyProfilerTableViewData = SwiftyProfilerTableViewData()
        self.logsTableView.delegate = swiftyProfilerTableViewData
        self.logsTableView.dataSource = swiftyProfilerTableViewData
    }
    
    public override func viewWillAppear(animated: Bool) {
        self.logsTableView.reloadData()
    }
    
    @IBAction func dismiss(sender: AnyObject) {
        self.dismissViewControllerAnimated(true) {
            self.onDismiss()
        }
    }
}

class SwiftyProfilerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var elapsedMsLabel: UILabel!
}

class SwiftyProfilerTableViewData: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private var timings: [Timing]
    
    override init() {
        self.timings = SwiftyProfiler.sharedInstance.getTimings()
    }
    
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        return timings.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        let timing = timings[indexPath.row]
        if let cell = tableView.dequeueReusableCellWithIdentifier("logTableViewCell") as? SwiftyProfilerTableViewCell {
            cell.label.text = timing.label
            cell.elapsedMsLabel.text = String(format: "%.2f", timing.elapsedTime().toMillis())
            return cell
        }
        return UITableViewCell()
    }
    
}

extension UIWindow {
    func getTopViewController() -> UIViewController? {
        guard let root = UIApplication.sharedApplication().keyWindow?.rootViewController else {
            return nil
        }
        
        var top: UIViewController? = root
        while (top?.presentedViewController != nil && top?.presentedViewController != top) {
            top = top?.presentedViewController
        }
        
        if let navigationController = top as? UINavigationController {
            top = navigationController.visibleViewController
        }
        
        return top
    }
}
