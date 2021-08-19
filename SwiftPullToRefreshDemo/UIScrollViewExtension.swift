//
//  UIScrollViewExtension.swift
//  Dealmoon
//
//  Created by matelin on 2021/8/19.
//  Copyright © 2021 Dealmoon. All rights reserved.
//

import UIKit

typealias Callback = () -> Void


class PullItem {
    
    // 触发回调
    var handler : Callback
    
    init(_ handler:@escaping Callback) {
        
        self.handler = handler
    }
}


extension UIScrollView {
    
    // 设置下拉样式
    func setPullDownItem(_ item:PullItem) {
        
        if let _ = item as? PullDownItem {
            
            var images = [UIImage]()
            for i in 1...13 {
                let name = String(format: "pull_load_loading_%d",i)
                if let image = UIImage(named: name) {
                    images.append(image)
                }
            }
            self.spr_setGIFHeader(images: images) {
                
                item.handler()
            }
        }
    }
    
    // 设置上拉样式
    func setPullUpItem(_ item:PullItem) {
        
        if let _ = item as? PullUpItem {
            
            self.spr_setIndicatorAutoFooter {
                
                item.handler()
            }
        }
    }
    
    // 触发下拉
    func beginPullDown() {
        
        self.spr_beginHeaderRefreshing()
    }
    
    // 结束下拉
    func endPullDown() {
        
        self.spr_endHeaderRefreshing()
    }
    
    // 触发上拉
    func beginPullUp() {
        
        self.spr_beginFooterRefreshing()
    }
    
    // 结束上拉
    func endPullUp() {
        
        self.spr_endFooterRefreshing()
    }
}


// 默认下拉样式，加载状态为转菊花动画，每一帧由图片组成
class PullDownItem : PullItem {
    
}

// 默认上拉样式，加载状态由IndicatorView实现，滑动到底部立即触发加载
class PullUpItem : PullItem {
    
}

// 还可以扩展
//class TextPullDownItem : PullItem {
//    var pullingText = ""
//    var loadingText = ""
//}
