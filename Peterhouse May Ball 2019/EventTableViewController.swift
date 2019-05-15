//
//  EventTableViewController.swift
//  Peterhouse May Ball 2019
//
//  Created by Joe Winterburn on 11/05/2019.
//  Copyright © 2019 Joe Winterburn. All rights reserved.
//

import UIKit
import CoreData

class EventTableViewController: UITableViewController {
    
    // MARK: Properties
    
    var mEvents = [NSManagedObject]();
    let mBackgroundImage = UIImage(named: "BGImage");
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        instantiateEventData();
        
        mEvents = retrieveEventData();
    }
    
    func retrieveEventData() -> [NSManagedObject]{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        let context = appDelegate.persistentContainer.viewContext;
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Events");
        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "startTime", ascending: true)]
        
        do {
            let result = try context.fetch(fetchRequest)
            return result as! [NSManagedObject];
        } catch {
            fatalError("Could not instantiate from core data stack");
        }
    }
    
    func instantiateEventData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        let context = appDelegate.persistentContainer.viewContext;
        
        if retrieveEventData().count == 0 {
        
            let entity = NSEntityDescription.entity(forEntityName: "Events", in: context);
        
            let dateString21 = "21/06/19";
            let dateString22 = "22/06/19";
        
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yy HH:mm";
            
            let Event1 = NSManagedObject(entity: entity!, insertInto: context);
            Event1.setValue("Name1", forKey: "name");
        
        
            let startTimeEvent1 = dateFormatter.date(from: (dateString21 + " 19:00"));
            let endTimeEvent1 = dateFormatter.date(from: (dateString22 + " 20:00"));
            Event1.setValue(startTimeEvent1, forKey: "startTime");
            Event1.setValue(endTimeEvent1, forKey: "endTime");
        
            do {
                try context.save();
            } catch {
                fatalError("Could not save");
            }
        } else {
            return;
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated);
        
        let BGImageView = UIImageView(image: mBackgroundImage);
        BGImageView.contentMode = .scaleAspectFit;
        self.tableView.backgroundView = BGImageView;
        tableView.tableFooterView = UIView(frame: CGRect.zero);
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark);
        let blurView = UIVisualEffectView(effect: blurEffect);
        blurView.frame = BGImageView.bounds;
        BGImageView.addSubview(blurView);
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1;
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return mEvents.count;
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "EventTableViewCell";
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm";
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? EventTableViewCell else {
            fatalError("The dequeued cell is not an instance of EventTableViewCell");
        }
        
        let event = mEvents[indexPath.row];
        
        if (event.value(forKey: "favourited") as! Bool) {
            cell.backgroundColor = UIColor(white: 1, alpha: 0.7);
            cell.favouritedIcon.image = UIImage(named: "favourited");
        } else {
            cell.backgroundColor = UIColor(white: 1, alpha: 0.3);
            cell.favouritedIcon.image = UIImage(named: "unfavourited");
        }
        
        cell.event = event;
        cell.eventNameLabel.text = (event.value(forKey: "name") as! String);
        let startTime = event.value(forKey: "startTime") as! Date;
        let endTime = event.value(forKey: "endTime") as! Date;
        cell.eventStartTimeLabel.text = dateFormatter.string(from: startTime);
        cell.eventEndTimeLabel.text = dateFormatter.string(from: endTime);
        cell.roundCorners(radius: 10);
        cell.delegate = self;
        
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView {
        let tableWidth = self.view.frame.width;
        let returnView = UIView(frame: CGRect(x: 0, y: 0, width: tableWidth, height: 40));
        let returnLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20));
        returnLabel.text = "Events";
        returnLabel.font = UIFont(name: "Avenir Next", size: 25.0);
        returnLabel.textColor = UIColor(white: 1, alpha: 1);
        returnLabel.textAlignment = .center;
        returnLabel.center.x = returnView.center.x;
        returnView.addSubview(returnLabel);
        
        return returnView;
    }
    

    

    
    // MARK: - Navigation

   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepared");
        if segue.identifier == "ShowEventDetails" {
            print("success");
            if var indexpath:IndexPath = self.tableView.indexPathForSelectedRow {
                let destVC:EventDetailViewController = segue.destination as! EventDetailViewController;
                destVC.mEventName = mEvents[indexpath.row].value(forKey: "name") as! String;
                print(destVC.mEventName);
            }
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}

extension EventTableViewController: EventTableViewCellDelegate {
    func eventTableViewCell(_ eventTableViewCell: EventTableViewCell, favouritedButtonPressedFor event: NSManagedObject) {
    //    event.pressedFavourited();
        
        let delegate = UIApplication.shared.delegate as! AppDelegate;
        let context = delegate.persistentContainer.viewContext;
        
        if event.value(forKey: "favourited") as! Bool {
            event.setValue(false, forKey: "favourited");
        } else {
            event.setValue(true, forKey: "favourited");
        }
        
        do {
            try context.save();
        } catch {
            fatalError("Could not save context");
        }
        
        self.tableView.reloadData();
    }
}
