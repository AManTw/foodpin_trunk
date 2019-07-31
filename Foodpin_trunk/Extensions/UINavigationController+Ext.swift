//
//  UINavigationController+Ext.swift
//  Foodpin_trunk
//
//  Created by Aman on 2019/7/31.
//  Copyright © 2019 Aman. All rights reserved.
//

import UIKit

extension UINavigationController {
    open override var childForStatusBarStyle: UIViewController? {
        return topViewController
    }
}
