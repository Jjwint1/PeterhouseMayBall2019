//
//  EventTableViewCell.swift
//  Peterhouse May Ball 2019
//
//  Created by Joe Winterburn on 11/05/2019.
//  Copyright © 2019 Joe Winterburn. All rights reserved.
//

import UIKit
import CoreData

class EventTableViewCell: UITableViewCell {
    
    //MARK: properties
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventStartTimeLabel: UILabel!
    @IBOutlet weak var eventEndTimeLabel: UILabel!
    @IBOutlet weak var favouritedIcon: UIImageView!
    @IBOutlet weak var favouritedButton: UIButton!
    weak var delegate: EventTableViewCellDelegate?
    var event: NSManagedObject?;
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
  //      self.favouritedButton.addTarget(self, action: #selector(favouritedButtonPressed(_:)), for: .touchUpInside);
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
    func roundCorners(radius: Double) {
        self.layer.cornerRadius = CGFloat(radius);
        self.clipsToBounds = true;
    }
    
    @IBAction func favouritedButtonPressed(_ sender: UIButton) {
        if let event = event, let _ = delegate {
            self.delegate?.eventTableViewCell(self, favouritedButtonPressedFor: event);
        }
    }
    
}

protocol EventTableViewCellDelegate: AnyObject {
    func eventTableViewCell(_ eventTableViewCell: EventTableViewCell, favouritedButtonPressedFor event: NSManagedObject)
}
