//
//  ListViewController.swift
//  SwiftPullToRefreshDemo
//
//  Created by matelin on 2021/8/19.
//  Copyright © 2021 Wiredcraft. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    private lazy var scrollView : UIScrollView = {
        
        let view = UIScrollView(frame: .zero)
        view.backgroundColor = .orange
        view.alwaysBounceVertical = true
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(self.scrollView)
        self.scrollView.setPullDownItem(PullDownItem({
            
            self.loadData()
        }))
        
        self.scrollView.setPullUpItem(PullUpItem({
            
            self.loadMoreData()
        }))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.scrollView.frame = self.view.bounds
        self.scrollView.contentSize = CGSize(width: self.view.bounds.size.width, height: 1000)
    }

    func loadData() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            
            self.scrollView.endPullDown()
        }
    }
    
    func loadMoreData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            
            self.scrollView.endPullUp()
        }
    }
}
