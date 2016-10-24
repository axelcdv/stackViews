//
//  LabelView.swift
//  StackViews
//
//  Created by Axel Colin de Verdiere on 24/10/16.
//  Copyright © 2016 Axelcdv. All rights reserved.
//

import Foundation
import UIKit


class LabelView: UIView {
    private var titleView: UILabel?
    private var subtitleView: UILabel?
    
    lazy private var titleConstraints: [NSLayoutConstraint] = {
        return NSLayoutConstraint.constraints(
            withVisualFormat: "V:[title]|",
            options: .directionLeadingToTrailing, metrics: nil , views: ["title": self.titleView!])
    }()
    
    var title: String? {
        didSet {
            if titleView == nil {
                createTitleView()
            }
            titleView?.text = title
            subtitleView?.text = "\(title) subtitle"
        }
    }
    
    var subtitleEnabled = false {
        didSet {
            if subtitleEnabled {
                createSubtitleView()
            } else {
                self.subtitleView?.removeFromSuperview()
                self.subtitleView = nil
                self.addConstraints(self.titleConstraints)
                self.layoutIfNeeded()
//                UIView.animate(withDuration: 0.5) { [unowned self] in
//                }
            }
        }
    }
    
    func createSubtitleView() {
        let label2 = UILabel()
        label2.text = "\(title) subtitle"
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.backgroundColor = .red
        label2.numberOfLines = 0
//        label2.isHidden = true
        subtitleView = label2
        self.addSubview(label2)
        
        let views = [
            "title": titleView!,
            "subtitle": label2
        ]
        self.removeConstraints(self.titleConstraints)
        
        label2.sizeToFit()
        let height = label2.frame.height
        sendSubview(toBack: label2)
        
        self.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "|[subtitle]|",
                options: .directionLeadingToTrailing, metrics: nil , views: views))
        
        let verticalConstraints =
            NSLayoutConstraint.constraints(
                withVisualFormat: "V:[title]-(height)-[subtitle]|",
                options: .directionLeadingToTrailing, metrics: ["height": -height], views: views)
        
        self.addConstraints(verticalConstraints)
        self.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.5) { [unowned self] in
//            self.subtitleView?.isHidden = false
            self.removeConstraints(verticalConstraints)
            self.addConstraints(
                NSLayoutConstraint.constraints(
                    withVisualFormat: "V:[title]-(5)-[subtitle]|",
                    options: .directionLeadingToTrailing, metrics: nil, views: views)
            )
            self.layoutIfNeeded()
        }
    }
    
    func createTitleView() {
        let label1 = UILabel()
        label1.text = title
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.backgroundColor = .green
        titleView = label1
        self.addSubview(label1)
        
        let views = [
            "title": label1
        ]
        
        addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "V:|[title]",
                options: .directionLeadingToTrailing, metrics: nil , views: views))
        addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "|[title]|",
                options: .directionLeadingToTrailing, metrics: nil , views: views))
        
        addConstraints(titleConstraints)
    }
}
