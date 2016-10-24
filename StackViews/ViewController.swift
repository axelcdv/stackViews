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
//        stackView.distribution = .fillProportionally
        
        // Prepare stack view
        for day in 1..<7 {
            let view = createStackedElement("\(day)")
            
            view.addGestureRecognizer(
                UITapGestureRecognizer(target: self, action:#selector(hideStackedView(_:)))
            )
            
//            view.addGestureRecognizer(
//                UILongPressGestureRecognizer(target: self, action: #selector(hideCompleteView(_:)))
//            )
            
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
        guard let labelView = sender.view as? LabelView else {
            return
        }
        
        labelView.subtitleEnabled = !labelView.subtitleEnabled
        
//        UIView.animate(withDuration: 1, delay: 0,
//                       options: UIViewAnimationOptions.transitionCurlDown,
//                       animations: { [unowned self] in
//                        labelView.subtitleEnabled = !labelView.subtitleEnabled
//                        self.stackView.layoutIfNeeded()
//                        
//            }, completion: nil)
//        UIView.animate(withDuration: 0.5) { [unowned self] in
////            subView.isHidden = !subView.isHidden
//            labelView.subtitleEnabled = !labelView.subtitleEnabled
////            labelView.layoutIfNeeded()
//////            sender.view?.layoutSubviews()
//            self.stackView.layoutIfNeeded()
//        }
    }

    func createStackedElement(_ text: String) -> LabelView {
        let view = LabelView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        view.title = text
        
        return view
    }
    
    func _createStackedElement(_ text: String) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        
        let label1 = UILabel()
        label1.text = text
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.backgroundColor = .green
//        label1.isHidden = arc4random() % 2 == 0  // Randomly hide subtitle
        label1.isHidden = true
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
                withVisualFormat: "|[label1]-(0@100)-|",
                options: .directionLeadingToTrailing, metrics: nil , views: views))
        view.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "|[label2]|",
                options: .directionLeadingToTrailing, metrics: nil , views: views))
        
        return view
    }
}

