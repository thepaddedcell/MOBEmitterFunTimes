//
//  MenuTableViewController.swift
//  MOBEmitterFunTimes
//
//  Created by Craig Stanford on 1/07/2014.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var emitterTypes :Array<String>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emitterTypes = ["Bubbles", "Rain", "Ink"];
    }

    // #pragma mark - Table view data source

    func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if var emitterTypes = emitterTypes {
            return emitterTypes.count
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView?, cellForRowAtIndexPath indexPath: NSIndexPath?) -> UITableViewCell? {
        if var tableView = tableView {
            let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath) as UITableViewCell
            
            if var emitterTypes = emitterTypes {
                if var indexPath = indexPath {
                    cell.textLabel.text = emitterTypes[indexPath.row]
                }
            }
            return cell
        } else {
            return nil
        }
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!)
    {
        let emitterViewController = EmitterViewController();
        emitterViewController.emitterType = EmitterType.Bubbles
        self.splitViewController.showDetailViewController(nil, sender: self);
    }    

    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }

}
