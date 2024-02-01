//
//  BaseViewController.swift
//  MediaProject2
//
//  Created by 은서우 on 2024/01/31.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        
        configureHierarchy()
        configureView()
        configureLayout()
    }
    
    func configureHierarchy() { }
    func configureView() { }
    func configureLayout() { }

}
