
import UIKit
import CoreData
import IQKeyboardManager
import Reachability
import AlamofireNetworkActivityLogger
import Tamamushi
import MagicalRecord

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var navigationController = UINavigationController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
         window = UIWindow(frame: UIScreen.main.bounds)
        setupCoredata()
        TMGradientNavigationBar().setInitialBarGradientColor(direction: .horizontal, startColor: UIColor.init(red: 255.0/255.0, green: 128.0/255.0, blue: 117.0/255.0, alpha: 1.0), endColor: UIColor.init(red: 230.0/255.0, green: 199.0/255.0, blue: 122.0/255.0, alpha: 1.0))
        
        statusBarColor()
        NetworkActivityLogger.shared.startLogging()
        NetworkActivityLogger.shared.level = .debug
        
        if(AccountManager.instance().activeAccount != nil){
           userDidLogin()
        } else{
            showLogin()
        }
        return true
    }
    
    func setupCoredata(){
        MagicalRecord.setupCoreDataStack(withAutoMigratingSqliteStoreNamed: "WakalaRegi.sqlite")
        let paths: [Any] = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        print("path  = \(paths)")
    }
    
    func logout(){
        MagicalRecord.save(blockAndWait: { (localContext:NSManagedObjectContext) in
            WakalaList.mr_truncateAll(in: localContext)
            City.mr_truncateAll(in: localContext)
            Bank.mr_truncateAll(in: localContext)
            AccountManager.instance().activeAccount = nil
            self.showLogin()
        })
       
    }
    class func appDelegateShared() -> AppDelegate{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate
    }
    
    func userDidLogin(){
        let controller = HomeViewController.initViewController()
        self.navigationController = UINavigationController.init(rootViewController: controller)
        self.navigationController.isNavigationBarHidden = true
        self.navigationController.navigationBar.isTranslucent = false;
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func showLogin(){
        let controller = LoginViewController.initViewController()
        self.navigationController = UINavigationController.init(rootViewController: controller)
        self.navigationController.isNavigationBarHidden = true
        self.navigationController.navigationBar.isTranslucent = false;
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func statusBarColor() {
        let startColor = UIColor.init(red: 255.0/255.0, green: 128.0/255.0, blue: 117.0/255.0, alpha: 1.0)
        let endColor = UIColor.init(red: 230.0/255.0, green: 199.0/255.0, blue: 122.0/255.0, alpha: 1.0)
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        if statusBar.responds(to:#selector(setter: UIView.backgroundColor)) {
            
            let gradientLayer = CAGradientLayer()
            let sizeLength = UIScreen.main.bounds.size.height * 2
            let navBarFrame = CGRect(x: 0, y: 0, width: sizeLength, height: statusBar.frame.size.height)
            gradientLayer.frame = navBarFrame
            gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
            gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 0.3, y: 0.5)
            
            UIGraphicsBeginImageContext(gradientLayer.frame.size)
            gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
            let outputImage = UIGraphicsGetImageFromCurrentImageContext()
            statusBar.backgroundColor = UIColor(patternImage: outputImage!)
        }
    }
  

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "WakalaRegi")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

