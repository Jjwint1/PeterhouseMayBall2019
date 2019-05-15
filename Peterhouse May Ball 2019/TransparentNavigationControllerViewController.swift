//
//  TransparentNavigationControllerViewController.swift
//  Peterhouse May Ball 2019
//
//  Created by Joe Winterburn on 13/05/2019.
//  Copyright © 2019 Joe Winterburn. All rights reserved.
//

import UIKit

class TransparentNavigationControllerViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.setBackgroundImage(UIImage(), for: .default);
        self.navigationBar.shadowImage = UIImage();
    }


}
