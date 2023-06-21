//
//  AuthenticationService.swift
//  ShopifyTeam4
//
//  Created by Youssef Mohamed on 09/06/2023.
//

import Foundation
import Firebase
class  AuthenticationService{
 //MARK:- Additional Methods
 func saveUserLocally(fUser: FUser) {
      //   print("saveUserLocally \n")
         let userDictionary = userDictionaryFrom(user: fUser)
         UserDefaults.standard.set(userDictionary, forKey: kCURRENTUSER)
       //  print("saved \n")
         UserDefaults.standard.synchronize()
      //   print(UserDefaults.standard.object(forKey: kCURRENTUSER))
     }
func userDictionaryFrom(user: FUser) -> NSDictionary {
  //  print("userDictionaryFrom \n")
        return NSDictionary(
            objects: [user.objectId,user.email,user.fullname,user.fullNumber,user.country,user.city,user.street],
            forKeys:
                [kOBJECTID as NSCopying, kEMAIL as NSCopying,kFULLNAME as NSCopying, kPHONE as NSCopying,
                 kCOUNTRY as NSCopying, kCITY as NSCopying, kSTREET as NSCopying])
}
    
func saveCurrentUser(uId: String,complitionHandler : @escaping(_ sucess:Bool) -> ()){
  //  print("saveCurrentUser \n")
         let usersDB = DBref.child("USERS").child(uId)
         usersDB.observeSingleEvent(of: .value) { (snapshot) in
         if snapshot.exists(){
             let usersDic = snapshot.value as! [String : Any]
             self.saveUserLocally(fUser: FUser(_dictionary: usersDic as NSDictionary))
             complitionHandler(true)
         }else{
             complitionHandler(false)
             }
         }
     }

     func saveUserInDB(uID:String,userObjForm: FUser, complitionHandler : @escaping(_ errorMessage:String?) -> ()) {
      //   print("saveUserInDB")
         let userDict = userDictionaryFrom(user: userObjForm)
         DBref.child("USERS").child(uID).setValue(userDict) { (error, ref) in
             if error != nil{
                 complitionHandler(error?.localizedDescription)
                 return
             }
         //    print("success")
             self.saveUserLocally(fUser: userObjForm)
             complitionHandler(nil)
         }
     }
    func userSignInActionWith(email:String , password: String,complitionHandler : @escaping(_ errorMessage:String?) -> ()){

        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil{
                complitionHandler(error?.localizedDescription)
                return
            }
       //     print(result?.user.uid ?? "")
            self.saveCurrentUser(uId: (result?.user.uid)!) { (isExisted) in
                if isExisted{
                    complitionHandler(nil)
              //      print("success \n")
                }else{
                    complitionHandler(error?.localizedDescription)
                    // ProgressHUD.showError("user not existed") (view action)
                }
            }
        }
    }
    func createNewUser(user:FUser,password:String,complitionHandler : @escaping(_ errorMessage:String?) -> ()){
     //   print("createNewUser")
        Auth.auth().createUser(withEmail: user.email, password: password) {  (result, error) in
            if error != nil{
                complitionHandler(error?.localizedDescription)
                return
            }
       //     print(result?.user.uid ?? "uid not created ..!")
            user.objectId = result?.user.uid ?? ""
            self.saveUserInDB(uID: user.objectId,userObjForm: user)  { (errorMsg) in
                if errorMsg != nil{
                    complitionHandler(errorMsg)
                    // ProgressHUD.showError("user not existed") (view action)
                }else{
                    complitionHandler(nil)
                  //  print("success \n")
                }
            }
        }
    }
    class func userLogout(){
        do {
            try Auth.auth().signOut()
        } catch let error {
            print("Error: ", error.localizedDescription)
        }
    }
    func getUsersPhoneNumbers(complitionHandler : @escaping(_ phoneNumbers:[String]) -> ()) {
        let userNode = DBref.child("USERS")
        var phoneNumbers:[String] = []
        userNode.observe(.value) { snapShot,arg  in
            if let userDict = snapShot.value as? [String:Any]{
                for (_,value) in userDict{
                    let user = FUser(_dictionary: value as! NSDictionary)
                    phoneNumbers.append(user.fullNumber)
                    print("appended \(phoneNumbers.count) item")
                }
                complitionHandler(phoneNumbers)
            }else{
                complitionHandler(phoneNumbers)
            }
        }
    }
    func forgetPasword(email:String,complitionHandler : @escaping(_ errorMessage:String?) -> ()){
          // Send a password reset email to the user.
          Auth.auth().sendPasswordReset(withEmail: email) { error in
            if error != nil {
                complitionHandler(error?.localizedDescription)
              return
            }else{
                complitionHandler(nil)
            }
            // Show a success message.
            print("Password reset email sent.")
          }
        }
}
