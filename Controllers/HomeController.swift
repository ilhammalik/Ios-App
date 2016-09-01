//
//  HomeController.swift
//  Pay4Date
//
//  Created by Ilham Malik Ibrahim on 7/22/16.
//  Copyright © 2016 kufed-ios. All rights reserved.
//


import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import Alamofire
import ObjectMapper
import AlamofireObjectMapper
import SwiftyJSON
import RealmSwift


class HomeController: UIViewController, FBSDKLoginButtonDelegate,UITableViewDataSource, UITableViewDelegate
{
    
    /* Variabel */
    let modelName = UIDevice.currentDevice().modelName
    @IBOutlet var usernameLabel : UILabel!
    @IBOutlet var homeView: UIView!
    @IBOutlet var PlusviewOpen: UIView!
    @IBOutlet var PlusviewHide: UIView!
    @IBOutlet var viewEdit: UIView!
    @IBOutlet var viewSearch: UIView!
    
    
    @IBOutlet var menuButtonOpen: UIButton!
    @IBOutlet var menuButtonHide: UIButton!
    @IBOutlet var tblMenuOptions : UITableView!
    
    //home Job
    @IBOutlet var dataHome : UITableView!
    @IBOutlet var titlePublish : UILabel!
    @IBOutlet var time : UILabel!
    @IBOutlet var userPhoto : UIImageView!
    @IBOutlet var userName : UILabel!
    @IBOutlet var userLocation : UILabel!
    @IBOutlet var userView : UIView!
    
    @IBOutlet var sortView : UIView!
    
    private let cellHeight: CGFloat = 210
    private let cellSpacing: CGFloat = 20
    private lazy var presentationAnimator = GuillotineTransitionAnimation()
    
    var actionButton: ActionButton!
    
    @IBOutlet var barButton: UIButton!
    
    var listOfFoodToPass = [String]()
    var timer: NSTimer!
    //end Job
    
    
    weak var transitionContext: UIViewControllerContextTransitioning?
    
    let numberRowOfTableView_1 = 4
    var arrayMenuOptions = [Dictionary<String,String>]()
    
    var arrRes = [[String:AnyObject]]() //Array of dictionary
    var arrDict :NSMutableArray=[];
    var data : [(HomeJob)]?
    
    @IBOutlet var menuviewOpen: UIView!
    /* End Variabel */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewEdit.layer.cornerRadius = self.viewEdit.frame.height/2
        
        let memoryCapacity = 500 * 1024 * 1024
        let diskCapacity = 500 * 1024 * 1024
        let urlCache = NSURLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "myDiskPath")
        NSURLCache.setSharedURLCache(urlCache)
        
        print("Controller HomeController\n\n")
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        // Do any additional setup after loading the view.
        self.navigationItem.title = "Cheers"
        // let navBar = self.navigationController!.navigationBar
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sorting", style: .Plain, target: self, action: #selector(menuRightOpen))
        
        
        CheckInternet()
        getData()
        
        timer = NSTimer.scheduledTimerWithTimeInterval(60.0, target: self, selector:"AutoUpdate", userInfo: nil, repeats: true)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        tabBar()
        
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func tabBar(){
        
        let twitterImage = UIImage(named: "twitter_icon.png")!
        let plusImage = UIImage(named: "googleplus_icon.png")!
        
        let createJob = ActionButtonItem(title: "Create Job", image: twitterImage)
        createJob.action = { item in
            
            print("Create Job...")
            let vc = createJobController(nibName: "createJob", bundle: nil)
            var navb = UINavigationController(rootViewController: vc)
            self.presentViewController(navb, animated:true, completion:nil)
        }
        
        let search = ActionButtonItem(title: "Search", image: plusImage)
        search.action = { item in
            print("search...")
            let vc = searchJobController(nibName: "searchJob", bundle: nil)
            var navb = UINavigationController(rootViewController: vc)
            self.presentViewController(navb, animated:true, completion:nil)
            
        }
        
        let chat = ActionButtonItem(title: "Chat", image: plusImage)
        chat.action = { item in
            
            print("chat...")
            let vc = ProfileController(nibName: "Profile", bundle: nil)
            var navb = UINavigationController(rootViewController: vc)
            self.presentViewController(navb, animated:true, completion:nil)
            
        }
        
        
        let photo = ActionButtonItem(title: "Photo", image: plusImage)
        photo.action = { item in
            print("photo...")
            
            let vc = ProfileController(nibName: "Profile", bundle: nil)
            var navb = UINavigationController(rootViewController: vc)
            self.presentViewController(navb, animated:true, completion:nil)
            
            
        }
        
        
        let profile = ActionButtonItem(title: "Profile", image: plusImage)
        profile.action = { item in
            print("profile")
            let vc = ProfileController(nibName: "Profile", bundle: nil)
            var navb = UINavigationController(rootViewController: vc)
            self.presentViewController(navb, animated:true, completion:nil)
            
            
        }
        
        
        actionButton = ActionButton(attachedToView: self.view, items: [createJob, search,chat,photo,profile])
        actionButton.action = { button in button.toggleMenu() }
        actionButton.setTitle("+", forState: .Normal)
        
        actionButton.backgroundColor = UIColor(red: 238.0/255.0, green: 130.0/255.0, blue: 34.0/255.0, alpha:1.0)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        
    }
    
    func AutoUpdate(){
        CheckInternet()
    }
    

    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated);
        super.viewWillDisappear(animated)
        CheckInternet()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        
    }
    
    
    @IBAction func logoutTapped(sender : UIButton) {
        print("Function Logout\n\n")
        
        let appDomain = NSBundle.mainBundle().bundleIdentifier
        NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain!)
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
        
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("Fcontroller") as! FirstController
        self.presentViewController(vc, animated: true, completion: nil)
        
    }
    
    
    @IBAction func showMenuAction(sender: UIButton) {
        let menuVC = storyboard!.instantiateViewControllerWithIdentifier("MenuViewController")
        menuVC.modalPresentationStyle = .Custom
        menuVC.transitioningDelegate = self
        if menuVC is GuillotineAnimationDelegate {
            presentationAnimator.animationDelegate = menuVC as? GuillotineAnimationDelegate
        }
        presentationAnimator.supportView = self.navigationController?.navigationBar
        presentationAnimator.presentButton = sender
        presentationAnimator.duration = 0.02
        self.presentViewController(menuVC, animated: true, completion: nil)
    }
    
    
    func menuRightOpen(){
        self.sortView.hidden = true
        print("Function MenuRightOpen")
        self.sortView.hidden = false
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sorting", style: .Plain, target: self, action: #selector(menuRightClose))
    }
    
    func menuRightClose(){
        print("Function MenuRightclose")
        self.sortView.hidden = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sorting", style: .Plain, target: self, action: #selector(menuRightOpen))
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print("User Logged In")
        if ((error) != nil)
        {
        }
        else if result.isCancelled {
            
        }
        else {
            if result.grantedPermissions.contains("email")
            {
            }
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("browseJob", forIndexPath: indexPath) as! BrowseJobCell
        
        var dict = arrRes[indexPath.row]
        //let dict = data![indexPath.row]
        
        
        var NCity = dict["city"] as? String
        var Adrs = dict["address"] as? String
        var City  = String(NCity!)
        var adRes  = String(Adrs!)
        
        
        //    cell.id?.text = dict.id
        cell.name?.text = dict["creator_detail"]!["name"] as? String
        cell.time?.text = dict["end_date"] as? String
        cell.title?.text = dict["title"] as? String
        //
        //Cirle Photo
        cell.photo.layer.borderWidth = 1
        cell.photo.layer.masksToBounds = false
        cell.photo.layer.borderColor = UIColor.blackColor().CGColor
        cell.photo.layer.cornerRadius = cell.photo.frame.height/2
        cell.photo.clipsToBounds = true
        // End Circle Photo
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.address?.text = "\(City) \(adRes)"
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.arrRes.count
    }
    
    func getData(){
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let Token = prefs.valueForKey("token") as? String
        
        
        let headersToken = [
            "appid": "4201620",
            "secretkey": SecretKey,
            "cache-control": CacheControl,
            "content-type": ContentType,
            "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
            "Accept": "application/json",
            "authtoken":String(Token!),
            ]
        guard let realm = try? Realm() else {
            // FIXME: you need to handle errors.
            return
        }
        Alamofire.request(.GET, "http://128.199.114.161:128/job/browse/forme/limit/100", headers:headersToken)
            
            .responseJSON { (response) -> Void in
                if (response.response!.statusCode == 200 || response.response!.statusCode == 201 ) {
                    if((response.result.value) != nil) {
                        let swiftyJsonVar = JSON(response.result.value!)
                        //debugPrint(swiftyJsonVar["data"]["records"])
                        
                        
                        if let resData = swiftyJsonVar["data"]["records"].arrayObject {
                            self.arrRes = resData as! [[String:AnyObject]]
                            print("cetak")
                            
                        }
                        
                        if self.arrRes.count > 0 {
                            self.dataHome.reloadData()
                        }
                        
                        
                        let json = JSON(response.result.value!)
                        let entries = json["data"]["records"]
                        realm.beginWrite()
                        for (_, subJson) : (String, JSON) in entries {
                            let entry : HomeJob = Mapper<HomeJob>().map(subJson.dictionaryObject)!
                            realm.add(entry, update: true)
                        }
                        
                        do {
                            try realm.commitWrite()
                        } catch {
                            
                        }
                        print(self.data)
                        self.updateTableView()
                        
                    }
                }else{
                    
                    let result = response.result.value as? [String : AnyObject ]
                    print(result!["response"]!["message"]!)
                    //                    let alertView:UIAlertView = UIAlertView()
                    //                    alertView.title = "\(result!["response"]!["description"]!)"
                    //                    alertView.message = "\(result!["response"]!["message"]!)"
                    //                    alertView.delegate = self
                    //                    alertView.addButtonWithTitle("OK")
                    //                    alertView.show()
                    
                }
        }
        
        
    }
    
    
    func updateTableView() {
        
        do {
            self.data = try Realm().objects(HomeJob).sort({ (entry1, entry2) -> Bool in
                let res = entry1.endDate.compare(entry2.endDate)
                return (res == .OrderedAscending || res == .OrderedSame)
            })
        }catch {}
        
        self.dataHome.reloadData()
    }
    
    
    //send data from home controller to other
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        self.sortView.hidden = true
        if segue.identifier == "detailJob"  {
            if let indexPath = self.dataHome.indexPathForCell(sender as! BrowseJobCell){
                var controller = segue.destinationViewController as! JobsDetailController
                let dataToPass = self.arrRes[indexPath.row]
                let result = dataToPass as? [String : AnyObject]
                controller.readName = result!["creator_detail"]!["name"]! as! String
                controller.readTitle = result!["title"]! as! String
                controller.readMonth = result!["end_date"]! as! String
                controller.readDate = result!["title"]! as! String
                controller.readAddress = result!["address"]! as! String
                controller.readPrice = result!["price"]! as! String
                controller.readDesc = result!["description"]! as! String
                
                print(dataToPass)
                
            }
        }
    }
    
    
    //function for check device connection
    func CheckInternet(){
        if Reachability.isConnectedToNetwork() == true {
            print("Internet connection OK")
            let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
            let Token = prefs.valueForKey("token") as? String
            if(Token != nil){
                getData()
            }
        } else {
            print("Internet connection FAILED")
            // Initialize Alert Controller
            var alert = UIAlertController(title: "Cannot connect  to network", message: "Please check connection internet ", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Go to Setting", style: .Default, handler: { (action: UIAlertAction!) in
                print("Go to Setting")
                UIApplication.sharedApplication().openURL(NSURL(string:"prefs:root=Setting")!)
            }))
            // Present Alert Controller
            presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func AddJob(sender: UIButton) {
        let vc = createJobController(nibName: "createJob", bundle: nil)
        var navb = UINavigationController(rootViewController: vc)
        self.presentViewController(navb, animated:true, completion:nil)
        
    }
    
    @IBAction func SearchJob(sender: UIButton) {
        let vc = searchJobController(nibName: "searchJob", bundle: nil)
        var navb = UINavigationController(rootViewController: vc)
        self.presentViewController(navb, animated:true, completion:nil)
        
    }
    
    
}

//extension transition
extension HomeController: UIViewControllerTransitioningDelegate {
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presentationAnimator.mode = .Presentation
        presentationAnimator.duration = 0.02
        return presentationAnimator
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presentationAnimator.mode = .Dismissal
        presentationAnimator.supportView = self.navigationController?.navigationBar
        
        presentationAnimator.duration = 0.2
        return presentationAnimator
    }
}


