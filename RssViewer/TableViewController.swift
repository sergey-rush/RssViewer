//
//  TableViewController.swift
//  RssViewer
//
//  Created by Admin on 26/11/2017.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, XMLParserDelegate
{
    
    @IBOutlet var tbData: UITableView?
    
    var parser = XMLParser()
    var items : Array<Item> = Array()
    var elements = NSMutableDictionary()
    var element = String()
    var title1 = NSMutableString()
    var info1 = NSMutableString()
    var date = NSMutableString()
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        self.title = "Feed"
        self.beginParsing()    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func beginParsing()
    {
        parser = XMLParser(contentsOf:(URL(string:"http://k.img.com.ua/rss/ru/mainbyday.xml"))!)!
        parser.delegate = self
        parser.parse()
        tbData!.reloadData()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
        element = elementName
         if elementName == "item"
         {
            elements = NSMutableDictionary()
            elements = [:]
            title1 = NSMutableString()
            title1 = ""
            info1 = NSMutableString()
            info1 = ""
            date = NSMutableString()
            date = ""
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if (elementName == "item") {
            if !title1.isEqual(nil) {
                elements.setObject(title1, forKey: "title" as NSString)
            }
            if !info1.isEqual(nil) {
                elements.setObject(info1, forKey: "info" as NSString)
            }
            if !date.isEqual(nil) {
                elements.setObject(date, forKey: "date" as NSString)
            }
            
            
            let item = Item()
            item.title = title1 as String
            item.info = info1 as String
            item.date = date as String
            items.append(item)
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String)
    {
        if (element == "title") {
            title1.append(string)
        }
        if (element == "description") {
            info1.append(string)
        }
        if element == "pubDate" {
            date.append(string)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let ttl = items[indexPath.row]
        
        cell.textLabel?.text = ttl.title
        cell.detailTextLabel?.text = ttl.info
        
        return cell as UITableViewCell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        //if([sender isKindOfClass:[UITableViewCell class]])
        //{
//            if([segue.destinationViewController isKindOfClass:[ImageViewController class]])
//            {
//                ImageViewController *nextViewController = segue.destinationViewController;
//                NSIndexPath *path = [self.tableView indexPathForCell:sender];
//                Planet *selectedPlanet = [self.planets objectAtIndex:path.row];
//                //nextViewController.imageView.image=selectedPlanet.image;
//                nextViewController.planet = selectedPlanet;
//            }
            
            if segue.identifier == "TransferIdentifier" {
                var ti = "TransferIdentifier"
                //if let next = segue.destination as? ViewController {
                    //let item = items[indexPath.row]
                    //next.Item = item
                //}
            }
        
        if segue.identifier == "Interchange" {
            var ic = "Interchange"
            if let next = segue.destination as? ViewController {
                let index = tableView.indexPathForSelectedRow?.row
                let item = items[index!]
                next.item = item
            }
        }

        //}
        
    }
    

}
