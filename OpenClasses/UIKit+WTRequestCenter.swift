//
//  UIKit+WTRequestCenter.swift
//  OpenClasses
//
//  Created by mike on 15/6/5.
//  Copyright (c) 2015年 mike. All rights reserved.
//

import Foundation
import UIKit


extension UIApplication{

}

extension UIAlertView {
    static func showWithTitle(title:String?,message:String?){
        let alert:UIAlertView? = UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: nil);
        alert?.show();
        
        
        WTRequestCenter.performBlock({ () -> Void in
            alert?.dismissWithClickedButtonIndex(0, animated: true)
        }, afterDelay: 0)
        
    }
}


var uiimageStoreKey:String? = "uiimage Store Key"
extension UIImageView{
    
    
    
//    setImage
    func setImageWithURL(url:URLStringConvertible?){
        
        if((url) != nil){
            WTRequestCenter.sharedInstance.GETUsingCache(url!, parameters: nil, encoding: ParameterEncoding.URL, finished: { (response, data) -> Void in
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), { () -> Void in
                    let image:UIImage? = UIImage(data: data)
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.image = image
                    });
                })
                }) { (error) -> Void in
                    
            }
        }
        
        
        
        
    }
    
    
    
//    highlightedImage
    func sethighlightedImageWithURL(url:URLStringConvertible){
        
        
        
        WTRequestCenter.sharedInstance.GETUsingCache(url, parameters: nil, encoding: ParameterEncoding.URL, finished: { (response, data) -> Void in
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), { () -> Void in
                let image:UIImage? = UIImage(data: data)
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.highlightedImage = image
                })
            })
            }) { (error) -> Void in
                
        }
        
    }
}

extension UIButton{
//    set image
    func setImageWithURL(url:URLStringConvertible, forState state: UIControlState){
        WTRequestCenter.sharedInstance.GETUsingCache(url, parameters: nil, encoding: ParameterEncoding.URL, finished: { (response, data) -> Void in
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), { () -> Void in
                let image:UIImage? = UIImage(data: data)
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.setImage(image, forState: state)
                });
            })
            }) { (error) -> Void in
                
        }
    }
    
//    set bg image
    func setBackgroundImageWithURL(url:URLStringConvertible, forState state: UIControlState){
        WTRequestCenter.sharedInstance.GETUsingCache(url, parameters: nil, encoding: ParameterEncoding.URL, finished: { (response, data) -> Void in
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), { () -> Void in
                let image:UIImage? = UIImage(data: data);
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.setBackgroundImage(image, forState: state)
                });
            })
            }) { (error) -> Void in
                
        }
    }
}

extension UIScrollView{
    
}

extension UIColor
{
    
    static func wtColorWithRed(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor{
        return self.wtColorWithRed(red, green: green, blue: blue, alpha: 1.0);
    }
    
    static func wtColorWithRed(red: CGFloat, green: CGFloat, blue: CGFloat, alpha:CGFloat) -> UIColor{
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha);
    }
    
    static func wtColorWithHexString(hexString:String?)->UIColor?{
        var trimString:String! = hexString
        var length = trimString?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
        
        if (trimString?.hasPrefix("#") == true){
            trimString = trimString.substringFromIndex(trimString.startIndex)
        }
        length = trimString?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
        if(length == 2){
            trimString = trimString + trimString + trimString + trimString + trimString + trimString
        }
        
        if(length == 3){
            
        }
        
        return self.wtColorWithRed(1, green: 1, blue: 1)
    }
    
    static func intervalueFromhexString(hexString:String)->UInt32{
        var scanner = NSScanner(string: hexString)
        var a:UInt32 = 0
        scanner.scanHexInt(&a);
        return a;
    }
    
    
}


class WTNetworkActivityIndicatorManager:NSObject{
    var enable:Bool?
    var isNetworkActivityIndicatorVisible:Bool?
    
    
    var activityCount:Int!
    var activityIndicatorVisibilityTimer:NSTimer?
    
    

    static let sharedNetworkActivityIndicatorManager:WTNetworkActivityIndicatorManager? = {
        let obj:WTNetworkActivityIndicatorManager = WTNetworkActivityIndicatorManager()
        return obj
    }()
    
    override init(){
        super.init()
        
        
        activityCount!=0
        
        
        
    }
    

    
    let startNotification = "WTNetworking Operation Did Start Notification"
    let endNotification = "WTNetworking Operation Did Finish Notification"
    func handleNofitications(){
        
        NSNotificationCenter.defaultCenter().addObserverForName(startNotification, object: nil, queue: NSOperationQueue.mainQueue()) { (note) -> Void in
            
        }
        
        NSNotificationCenter.defaultCenter().addObserverForName(endNotification, object: nil, queue: NSOperationQueue.mainQueue()) { (note) -> Void in
            
        }
        
    
    }
    
    func incrementActivityCount(){
        activityCount!++

    }
    
    
    func decrementActivityCount(){
        activityCount!--
    }
    
    
    func updateNetworkActivityIndicatorVisibilityDelayed(){
        if (self.enable != nil){
            if((self.isNetworkActivityIndicatorVisible) != nil){
                self.activityIndicatorVisibilityTimer?.invalidate();
                self.activityIndicatorVisibilityTimer = NSTimer(timeInterval: 0.1, target: self, selector: Selector("updateNetworkActivityIndicatorVisibilityDelayed"), userInfo: nil, repeats: false)
                NSRunLoop.mainRunLoop().addTimer(activityIndicatorVisibilityTimer!, forMode: NSRunLoopCommonModes)
                
                
            }else{
                WTNetworkActivityIndicatorManager.performSelector(Selector(updateNetworkActivityIndicatorVisibilityDelayed()), onThread: NSThread.mainThread(), withObject: nil, waitUntilDone: false, modes: [NSRunLoopCommonModes])
                
            }
        }
    }
    
    
}











