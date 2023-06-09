//
//  AuthenticationService.swift
//  ShopifyTeam4
//
//  Created by Youssef Mohamed on 09/06/2023.
//

import Foundation

class  AuthenticationService{
    /*
     //MARK:- Additional Methods
 func saveUserLocally(fUser: FUser) {
         let userDictionary = userDictionaryFrom(user: fUser)
         UserDefaults.standard.set(userDictionary, forKey: kCURRENTUSER)
         print("saved")
         UserDefaults.standard.synchronize()
     }
 func saveCurrentUser(uId: String,complitionHandler : @escaping(_ sucess:Bool) -> ()){
         let usersDB = DBref.child(reference(.User)).child(uId)
         usersDB.observeSingleEvent(of: .value) { (snapshot) in
         if snapshot.exists(){
             let usersDic = snapshot.value as! [String : Any]
             saveUserLocally(fUser: FUser(_dictionary: usersDic as NSDictionary))
             complitionHandler(true)
         }else{
             complitionHandler(false)
             }
         }
     }
 func userDictionaryFrom(user: FUser) -> NSDictionary {
         let createdAt = dateFormatter().string(from: user.createdAt)
         let updatedAt = dateFormatter().string(from: user.updatedAt)
         return NSDictionary(objects: [user.objectId,  createdAt, updatedAt, user.email, user.fullname, user.avatar], forKeys: [kOBJECTID as NSCopying, kCREATEDAT as NSCopying, kUPDATEDAT as NSCopying, kEMAIL as NSCopying, kFULLNAME as NSCopying, kAVATAR as NSCopying])
 }

     */
    /*
     func saveUserInDB(uID:String) {
         let userObjForm = FUser(_objectId: uID, _createdAt: Date(), _updatedAt: Date(), _email: emailTF.text!, _fullname: nameTF.text!, _avatar:getStringFromImage(image: profileImage!))
         print("object created")
         let userDict = userDictionaryFrom(user: userObjForm)
         print("dictionary created")
         DBref.child(reference(.User)).child(uID).setValue(userDict) { (error, ref) in
             if error != nil{
                 ProgressHUD.showError(error?.localizedDescription)
                 return
             }
             self.screenDefaultForm()
             print("success")
             saveUserLocally(fUser: userObjForm)
             self.goToHome()
         }
     }
     */
    /*
     Auth.auth().signIn(withEmail: emailTF.text!, password: passwordTF.text!) { (result, error) in
         if error != nil{
             ProgressHUD.showError(error?.localizedDescription)
             return
         }
         print(result?.user.uid ?? "")
         saveCurrentUser(uId: (result?.user.uid)!) { (isExisted) in
             if isExisted{
                 self.goToHome()
             }else{
                 ProgressHUD.showError("user not existed")
             }
         }
         self.nameTF.text = ""
         self.emailTF.text = ""
         self.passwordTF.text = ""
     }
     */
    /*
     Auth.auth().createUser(withEmail: emailTF.text!, password: passwordTF.text!) {  (result, error) in
         if error != nil{
             ProgressHUD.showError(error?.localizedDescription)
             return
         }
         print(result?.user.uid ?? "")
         self.saveUserInDB(uID: (result?.user.uid)!)
     }
     */
}
