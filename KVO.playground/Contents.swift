import UIKit


// KVO es muy dificil de implementar

class User: NSObject {
    @objc dynamic  var name: String?
    init(withUserName: String) {
        super.init()
        self.name = withUserName
    }
}

private var myContext = 0
class UserManager: NSObject {
    var user: User
    
    init(withUser: User) {
        self.user = withUser
        super.init()
        
        // Add an observer to our object:
        self.user.addObserver(self, forKeyPath: #keyPath(User.name), options: .new, context: &myContext)
    }
    
    // Observe changes:
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if context == &myContext {
            print("Thi value has changed")
        
            if let namedChanged = change?[.newKey] as? String {
                print(namedChanged)
            }
        }
    }
    
}

var newUser = User(withUserName: "Juan")
var manager = UserManager(withUser: newUser)
print(manager)

newUser.name = "Mrio"
