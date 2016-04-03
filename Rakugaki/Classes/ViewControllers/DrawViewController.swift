//
//  DrawViewController.swift
//  Rakugaki
//
//  Created by Shun Kuroda on 2016/04/01.
//  Copyright © 2016年 kuroyam. All rights reserved.
//

import UIKit

class DrawViewController: UIViewController {
    
    override func loadView() {
        if let view = UINib(nibName: "DrawViewController", bundle: nil).instantiateWithOwner(self, options: nil).first as? UIView {
            self.view = view
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let drawableView = DrawableView(frame: view.frame)
        drawableView.backgroundColor = UIColor.whiteColor()
        view.addSubview(drawableView)
    }
    
}
