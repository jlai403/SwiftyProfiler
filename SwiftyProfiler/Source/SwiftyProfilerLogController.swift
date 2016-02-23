import Foundation
import UIKit

public class SwiftyProfilerLogController: UIViewController {
    
    public var onDismiss: (()->())!
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var logsTableView: UITableView!
    private var swiftyProfilerTableViewData: SwiftyProfilerTableViewData!
    
    public override func viewDidLoad() {
        styleView()
        swiftyProfilerTableViewData = SwiftyProfilerTableViewData()
        self.logsTableView.delegate = swiftyProfilerTableViewData
        self.logsTableView.dataSource = swiftyProfilerTableViewData
    }
    
    public override func viewWillAppear(animated: Bool) {
        self.logsTableView.reloadData()
    }
    
    private func styleView() {
    }
    
    @IBAction func dismiss(sender: AnyObject) {
        self.dismissViewControllerAnimated(true) {
            self.onDismiss()
        }
    }
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
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "logTableViewCell")
        cell.textLabel!.text = timing.label
        cell.detailTextLabel!.text = String(format: "%.4fms", timing.elapsedTime().toMillis())
        return cell
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
