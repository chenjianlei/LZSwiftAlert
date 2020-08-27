//
//  Alert.swift
//  LZSwiftAlert
//
//  Created by 陈建蕾 on 2020/8/27.
//

//Copyright (c) 2020 chenjianlei <woshixiaolei@qq.com>
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.

import Foundation
import UIKit
import MBProgressHUD

public typealias LZAlertBlock = () -> Void
public let delayTime: TimeInterval = 0.75

let alertSuperView = UIApplication.shared.delegate?.window!

extension UIView {
    public func alertText(msg text: String) {
        alertText(msg: text) { }
    }
    
    public func alertStartLoading() {
        alertStartLoading(msg: "")
    }
    
    public func alertStartLoading(msg text: String) {
        alertStartLoading(msg: text) { }
    }
    
    public func alertStopLoading() {
        alertStopLoading(msg: "")
    }
    
    public func alertStopLoading(msg text: String) {
        alertStopLoading(msg: text) { }
    }
    
    public func alertStopLoading(msg text: String? = "", block: @escaping LZAlertBlock) {
        main {
            if let hub = MBProgressHUD.forView(alertSuperView!) {
                hub.label.text = text
                hub.completionBlock = block
                hub.hide(animated: true, afterDelay: delayTime)
            } else {
                self.clean()
            }
        }
    }
    
    public func alertText(msg text: String? = "", block: @escaping LZAlertBlock) {
        main {
            self.clean()
            self.createHub(msg: text, mode: .text, block: block)
        }
    }
    
    public func alertStartLoading(msg text: String? = "", block: @escaping LZAlertBlock) {
        main {
            self.clean()
            self.createHub(msg: text, mode: .indeterminate, block: block)
        }
    }
    
    public func createHub(msg text: String? = "", mode: MBProgressHUDMode, block: @escaping LZAlertBlock) {
        let hub = MBProgressHUD.showAdded(to: alertSuperView!, animated: true)
        hub.label.text = text
        hub.backgroundView.blurEffectStyle = .light
        hub.completionBlock = block
        hub.backgroundView.color = .clear
        hub.mode = mode
        hub.removeFromSuperViewOnHide = true
        if mode == .text {
            hub.hide(animated: true, afterDelay: delayTime)
        } else {
            hub.show(animated: true)
        }
    }
    
    public func clean() {
        MBProgressHUD.hide(for: alertSuperView!, animated: true)
    }
    
    fileprivate func main(block: @escaping LZAlertBlock) {
        DispatchQueue.main.async {
            block()
        }
    }
}

extension UIViewController {
    public func alertText(msg text: String) {
        view.alertText(msg: text) { }
    }
    
    public func alertStartLoading() {
        alertStartLoading(msg: "")
    }
    
    public func alertStartLoading(msg text: String) {
        view.alertStartLoading(msg: text) { }
    }
    
    public func alertStopLoading() {
        alertStopLoading(msg: "")
    }
    
    public func alertStopLoading(msg text: String) {
        view.alertStopLoading(msg: text) { }
    }
    
    public func clean() {
        view.main {
            self.view.clean()
        }
    }
}
