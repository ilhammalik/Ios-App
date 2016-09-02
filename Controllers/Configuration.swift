//
//  Configuration.swift
//  Pay4Date
//
//  Created by Ilham Malik Ibrahim on 7/22/16.
//  Copyright © 2016 kufed-ios. All rights reserved.
//


import Foundation
import UIKit
import SystemConfiguration


let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
let Token = prefs.valueForKey("token") as? String
let Username = prefs.valueForKey("username") as? String
let Key = prefs.valueForKey("key") as? String

/* Header */
var APP_NAME = "Pay4date"
var AppId="4201620";
var SecretKey="5ednm6T7m32EVCLekXWExOVJPdhh8HSEqeMUeuhYo6j43kKPyU5jm";
var CacheControl = "no-cache"
var ContentType = "application/x-www-form-urlencoded"

var username="ilham";
var password="ilham123";
/* End Header */

var ApiSite="www.example.com";
var EmailServer=1234;

/* Api */
//var IP = "http://128.199.114.161:128/";
var IP = "http://192.168.2.202:128/";
var ApiLogin=IP+"/login/";
var ApiLoginFacebook=IP+"/login/facebook";
var ApiRegister=IP+"/signup";
var ApiCheckUsername=IP+"/checkingvalue/username/{{username}}";
var ApiForgetPassword=IP+"/needhelp/recovery/password";
var ApiSetPassword=IP+"/needhelp/confirmation/recovery/password";
var ContactUs=IP;
var FAQ=IP;
var ApiBrowseJob=IP+"/job/browse/forme/limit/100";
var ApiProfile = IP+"/profile/my";
var ApiProfileupdate = IP+"/profile/my/update";
var ApiTerm = IP+"/terms";
var ApiFaq = IP+"/faq";
var ApiReferralMy = IP+"/referral/code/my";
var ApiUploadPhoto = IP+"/beforeactivation/photo_profile/upload";
var ApiConfirmGet = IP+"/activation/confirm/"+Key!
var ApiConfirm = IP+"/activation/confirm/"
/* End Api */

/* function Detect Device Version Iphone */
public extension UIDevice {
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8 where value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,3", "iPad6,4", "iPad6,7", "iPad6,8":return "iPad Pro"
        case "AppleTV5,3":                              return "Apple TV"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
    
    
}
/* End Detect Device Version */


/* Header Login */
let headers = [
    "appid": AppId,
    "secretkey": SecretKey,
    "cache-control": CacheControl,
    "content-type": ContentType,
    "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
    "Accept": "application/json",
]


/* End Header Login */

/* Check Connection  */

public class Reachability {
    
    class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
            SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, UnsafePointer($0))
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        let isReachable = flags == .Reachable
        let needsConnection = flags == .ConnectionRequired
        
        return isReachable && !needsConnection
        
    }
    
    
}



/*===============================================*/

