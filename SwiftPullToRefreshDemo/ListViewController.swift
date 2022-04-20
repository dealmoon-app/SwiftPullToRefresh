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
        
        self.scrollView.setHeaderPull(target: self, selector: #selector(handleHeaderPull(item:)))
        self.scrollView.setFooterPull(target: self, selector: #selector(handleFooterPull(item:)))
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.scrollView.frame = self.view.bounds
        self.scrollView.contentSize = CGSize(width: self.view.bounds.size.width, height: 1000)
    }
    
    @objc func handleHeaderPull(item: PullItem) {
        // 下拉刷新
        self.scrollView.disableFooterPull(true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            self.scrollView.endHeaderPull()
            self.scrollView.disableFooterPull(false)
        }
    }

    @objc func handleFooterPull(item: PullItem) {
        // 上拉加载更多
        self.scrollView.disableHeaderPull(true)
      
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            self.scrollView.endFooterPull()
            self.scrollView.disableHeaderPull(false)
        }
    }
}
