/**
 * Copyright (c) 2016 Ivan Magda
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit

// MARK: Constants

private let kReuseIdentifier = "CategoryCell"

// MARK: - Types

private enum SegueIdentifier: String {
    case EditCategory
}

// MARK: - CategoriesTableViewController: UITableViewController

class CategoriesTableViewController: UITableViewController {
    
    // MARK: Properties
    
    var persistenceCentral: PersistenceCentral!

    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assert(persistenceCentral != nil)
        navigationItem.rightBarButtonItem = editButtonItem()
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == SegueIdentifier.EditCategory.rawValue {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! ManageCategoryTableViewController
            controller.persistenceCentral = persistenceCentral
            controller.title = "Edit Category"
            
            let indexPath = tableView.indexPathForSelectedRow!
            let category = persistenceCentral.categories[indexPath.row]
            controller.category = category
        }
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persistenceCentral.categories.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kReuseIdentifier)!
        
        let category = persistenceCentral.categories[indexPath.row]
        cell.textLabel?.text = category.name
        
        return cell
    }

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

}
