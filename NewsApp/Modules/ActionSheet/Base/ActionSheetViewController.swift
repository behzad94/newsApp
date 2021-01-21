//
//  ActionSheetViewController.swift
//  NewsApp
//
//  Created by DIAKO on 1/21/21.
//

import UIKit

protocol CategoryDelegate: class {
    func CategorySelected(category: String)
}

class ActionSheetViewController: UIViewController {
    
    var delegate: CategoryDelegate? = nil
    
    @IBOutlet weak var labelGuide: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func dismissTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func businessTapped(_ sender: Any) {
        delegate?.CategorySelected(category: "business")
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func generalTapped(_ sender: Any) {
        delegate?.CategorySelected(category: "general")
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func entertainmentTapped(_ sender: Any) {
        delegate?.CategorySelected(category: "entertainment")
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func healthTapped(_ sender: Any) {
        delegate?.CategorySelected(category: "health")
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func scienceTapped(_ sender: Any) {
        delegate?.CategorySelected(category: "science")
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sportsTapped(_ sender: Any) {
        delegate?.CategorySelected(category: "sports")
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func technologyTapped(_ sender: Any) {
        delegate?.CategorySelected(category: "technology")
        dismiss(animated: true, completion: nil)
    }
}
