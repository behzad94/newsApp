//
//  BaseViewController.swift
//  NewsApp
//
//  Created by DIAKO on 1/20/21.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    var tapGesture: UITapGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUIComponent()
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        self.view.addGestureRecognizer(tapGesture!)
        tapGesture?.cancelsTouchesInView = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
    }
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    func initUIComponent() {
        
    }
    
    func bindViewModel() {
        
    }
    
    func removeGesture(_ view: UIView) {
        self.view.removeGestureRecognizer(tapGesture!)
    }
}
