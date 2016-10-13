//
//  ViewController.swift
//  StackViews
//
//  Created by Axel Colin de Verdiere on 13/10/16.
//  Copyright © 2016 Axelcdv. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var stackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        stackView.distribution = .fillEqually
        
        // Prepare stack view
        for day in 1..<7 {
            let view = createStackedElement("\(day)")
            
            view.addGestureRecognizer(
                UITapGestureRecognizer(target: self, action:#selector(hideStackedView(_:)))
            )
            
            view.addGestureRecognizer(
                UILongPressGestureRecognizer(target: self, action: #selector(hideCompleteView(_:)))
            )
            
            stackView.addArrangedSubview(view)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func hideCompleteView(_ sender: UITapGestureRecognizer) {
        guard let view = sender.view else {
            return
        }
        
        UIView.animate(withDuration: 1) {
            view.isHidden = !view.isHidden
        }
    }

    func hideStackedView(_ sender: UITapGestureRecognizer) {
        guard let subView = sender.view?.subviews.first else {
            return
        }
        
        UIView.animate(withDuration: 0.5) { [unowned self] in
            subView.isHidden = !subView.isHidden
            self.stackView.layoutIfNeeded()
        }
    }

    func createStackedElement(_ text: String) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        
        let label1 = UILabel()
        label1.text = text
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.backgroundColor = .green
        label1.isHidden = arc4random() % 2 == 0  // Randomly hide subtitle
        view.addSubview(label1)
        
        let label2 = UILabel()
        label2.text = "\(text) subtitle"
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.backgroundColor = .red
        view.addSubview(label2)
        
        let views = [
            "label1": label1,
            "label2": label2
        ]
        
        view.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "V:|[label1]-(5)-[label2]|",
                options: .directionLeadingToTrailing, metrics: nil , views: views))
        view.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "|[label1]|",
                options: .directionLeadingToTrailing, metrics: nil , views: views))
        view.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "|[label2]|",
                options: .directionLeadingToTrailing, metrics: nil , views: views))
        
        return view
    }
}

