//
//  UIScrollView+Pull.swift
//  Dealmoon
//
//  Created by matelin on 2021/8/19.
//  Copyright © 2021 Dealmoon. All rights reserved.
//

import UIKit
import SwiftPullToRefresh

@objcMembers class PullItem: NSObject {
    
    // 触发回调
    weak var target: AnyObject?
    var selector: Selector?
    
    init(target:AnyObject?, selector:Selector?) {
        
        self.target = target
        self.selector = selector
    }
}

// 默认下拉样式，加载状态为转菊花动画，每一帧由图片组成
class HeaderPullItem : PullItem {
    
}

// 默认上拉样式，加载状态由IndicatorView实现，滑动到底部立即触发加载
class FooterPullItem : PullItem {
    
}

// 还可以扩展
//class TextHeaderPullItem : PullItem {
//    var pullingText = ""
//    var loadingText = ""
//}


extension UIScrollView {
    
    // 设置下拉刷新的触发函数
    @objc func setHeaderPull(target:AnyObject?, selector:Selector?) {
        let item = HeaderPullItem(target: target, selector: selector)
        setHeaderPullItem(item)
    }
    
    // 设置上拉加载更多的触发函数
    @objc func setFooterPull(target:AnyObject?, selector:Selector?) {
        let item = FooterPullItem(target: target, selector: selector)
        setFooterPullItem(item)
    }
    
    // 设置下拉样式
    @objc func setHeaderPullItem(_ item:PullItem) {
        
        if let _ = item as? HeaderPullItem {
            
            var images = [UIImage]()
            for i in 1...12 {
                let name = String(format: "pull_load_loading_%d",i)
                if let image = UIImage(named: name) {
                    images.append(image)
                }
            }
            self.spr_setGIFHeader(images: images) { //[weak self] in
                
                if let target = item.target, let selector = item.selector {
                    let _ = target.perform(selector, with: item)
                }
                
            }
        }
    }
    
    // 设置上拉样式
    @objc func setFooterPullItem(_ item:PullItem) {
        
        if let _ = item as? FooterPullItem {
            
            self.spr_setIndicatorAutoFooter { //[weak self] in
                
                if let target = item.target, let selector = item.selector {
                    let _ = target.perform(selector, with: item)
                }
            }
        }
    }
    
    // 触发下拉
    @objc func beginHeaderPull() {
        
        self.spr_beginHeaderRefreshing()
    }
    
    // 结束下拉
    @objc func endHeaderPull() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { // 参考动画时间0.3秒，不要随意改变
            self.spr_endHeaderRefreshing()
        }
    }
    
    // 触发上拉
    @objc func beginFooterPull() {
        
        self.spr_beginFooterRefreshing()
    }
    
    // 结束上拉
    @objc func endFooterPull() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { // 参考动画时间0.3秒，不要随意改变
            self.spr_endFooterRefreshing()
        }
    }
    
    // 下拉是否可用（加载更多数据时，下拉一般要禁用）
    @objc func disableHeaderPull(_ disable: Bool) {
        
        DispatchQueue.main.async {
            if !disable {
                // 还能加载更多
                self.spr_enableHeader()
            } else {
                // 不能加载更多了（没有更多数据）
                self.spr_endHeaderRefreshing() // 先停止
                self.spr_disableHeader()
            }
        }
    }
    
    // 上拉是否可用（没有更多数据时，不显示底部更多）
    @objc func disableFooterPull(_ disable: Bool) {
        
        DispatchQueue.main.async {
            if !disable {
                // 还能加载更多
                self.spr_enableFooter()
            } else {
                // 不能加载更多了（没有更多数据）
                self.spr_endFooterRefreshing() // 先停止
                self.spr_disableFooter()
            }
        }
    }
}

