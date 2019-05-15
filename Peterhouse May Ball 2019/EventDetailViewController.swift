//
//  EventDetailViewController.swift
//  Peterhouse May Ball 2019
//
//  Created by Joe Winterburn on 13/05/2019.
//  Copyright © 2019 Joe Winterburn. All rights reserved.
//

import UIKit
import CoreData

class EventDetailViewController: UIViewController {
    @IBOutlet weak var EventTitle: UILabel!
    
    var mEventName: String = "";
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let EventData = retreiveEventData()[0];
        EventTitle.text = (EventData.value(forKey: "name") as! String);
        
    }
    
    
    func retreiveEventData() -> [NSManagedObject] {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        let context = appDelegate.persistentContainer.viewContext;
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Events");
      //  fetchRequest.predicate = NSPredicate(format: "name == %@", mEventName);
        
        do {
            let result = try context.fetch(fetchRequest)
            if (result.count > 1) {
                EventTitle.text = "Couldn't load event details.";
            }
            if (result.count == 0) {
                print("empty array");
            }
            return result as! [NSManagedObject];
        } catch {
            fatalError("Could not instantiate from core data stack");
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
