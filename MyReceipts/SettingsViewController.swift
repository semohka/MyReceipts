//
//  SettingsViewController.swift
//  MyReceipts
//
//  Created by Кристина Семкова on 01.06.2020.
//  Copyright © 2020 Кристина Семкова. All rights reserved.
//

import UIKit
import SwiftUI

class SettingsViewController: UIHostingController<SettingsView> {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: SettingsView())
    }
    
}
