//
//  UIStoryboard+Instantiate.swift
//  SignUpFirebase
//
//  Created by 矢守叡 on 2019/12/15.
//  Copyright © 2019 yamolean. All rights reserved.
//

import UIKit

protocol StoryBoardInstantiatable {}
extension UIViewController: StoryBoardInstantiatable {}

extension StoryBoardInstantiatable where Self: UIViewController {

    static func instantiate() -> Self {
        let storyboard = UIStoryboard(name: self.className, bundle: nil)
        return storyboard.instantiateInitialViewController() as! Self
    }

    static func instantiate(withStoryboard storyboard: String) -> Self {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: self.className) as! Self
    }
}

protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}

extension ClassNameProtocol {

    static var className: String {
        return String(describing: self)
    }

    var className: String {
        return type(of: self).className
    }
}

extension NSObject: ClassNameProtocol {}

