//
//  MockNavigationController.swift
//  MVP_MyToDosTests
//
//  Created by Raúl Ferrer on 31/5/22.
//

import UIKit

class MockNavigationController: UINavigationController {
    
    var vcIsPushed: Bool = false
    var vcIsPopped: Bool = false

    override func pushViewController(_ viewController: UIViewController,
                                     animated: Bool) {
        super.pushViewController(viewController,
                                 animated: animated)
        vcIsPushed = true
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        vcIsPopped = true
        return viewControllers.first
    }
}
