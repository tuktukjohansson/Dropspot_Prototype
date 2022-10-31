//
//  ViewController.swift
//  Dropspot
//
//  Created by Marcus Johansson on 2022-09-12.
//

import UIKit

class FlowViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var testBox = [comment(title: "Awesome stuff!", image: "person")]

    var itemleft = UIBarButtonItem()
    var valueToCheck = 0
    var btnProfile = UIButton()
    @IBOutlet var tableView: UITableView!






    var header: StretchyTableViewHeader?

    func prepareForSegue(segue: UIStoryboardSegue, sender: [Annonce]?) {
        if segue.identifier == "showRecentAnnonce"{
            let destinationVC = segue.destination as! CompanyFlowViewController


            destinationVC.list2 = sender as [Annonce]?

        }

        // Create a variable that you want to send

        }



    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self


       tableViewAndDesignDetails()
    }

    func tableViewAndDesignDetails() {

        btnProfile = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 25))
        btnProfile.setTitle("Following", for: .normal)
        btnProfile.backgroundColor = UIColor.label.withAlphaComponent(0.7)
        btnProfile.layer.cornerRadius = 12.5
        btnProfile.layer.masksToBounds = true
        btnProfile.addTarget(self, action: #selector(followOrForYouPress), for: .touchUpInside)
        itemleft = UIBarButtonItem(customView: btnProfile)
        self.navigationItem.setLeftBarButton(itemleft, animated: true)


    }

    
    
    @objc func followOrForYouPress() {
        if valueToCheck == 0 {
            btnProfile.setTitle("For You", for: .normal)
            itemleft = UIBarButtonItem(customView: btnProfile)
            valueToCheck = 1
            animateFollowOrForYouPress()
        } else {
            btnProfile.setTitle("Following", for: .normal)
            itemleft = UIBarButtonItem(customView: btnProfile)
            valueToCheck = 0
            animateFollowOrForYouPress()

        }
        tableView.reloadData()
        print("Working")
    }

    @IBAction func btnCommentsPress(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "commentsflowvc") as?FlowCommentsViewController else{return}
        if let sheet = vc.sheetPresentationController{
            sheet.prefersGrabberVisible = true
            sheet.detents = [.medium()]

        }

        vc.boxTry=testBox
        present(vc,animated: true)



    }

    @IBAction func barButtonOptionsPress(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "optionsflowvc") as? FlowOptionsViewController else {return}
        if let sheet = vc.sheetPresentationController {
            sheet.prefersGrabberVisible = true
            sheet.detents = [.medium()]
        }
        present(vc, animated: true)
    }


    func animateFollowOrForYouPress() {
        UIView.animate(withDuration: 0.0, animations:{
            self.btnProfile.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }, completion: { _ in
            UIView.animate(withDuration: 0.2, animations:{
                self.btnProfile.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: { _ in
                UIView.animate(withDuration: 0.2, animations: {
                    self.btnProfile.transform = .identity
                })
            })
        })
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){

        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "companyProfile") as? CompanyProfile{
            vc.companyName = MainList.annonces[indexPath.row].companyName
            self.navigationController?.pushViewController(vc, animated: true)}


            /*
             let storyboard = UIStoryboard(name: "CompanyFlowViewController", bundle: nil)
             let vc = storyboard.instantiateInitialViewController()!
             self.present(vc, animated: true, completion: nil)
             */
            // performSegue(withIdentifier: "showRecentAnnonce", sender: self)
            // your code ...
            print (indexPath)


  }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.isPagingEnabled = true
       let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for : indexPath) as! FlowTableViewCell
        
        
        cell.favoriteButton.tag = indexPath.row
        
        
        if (valueToCheck == 0){
            //Toggle fav with tag
            cell.favoriteButton.addTarget(self, action:#selector(setFav(_:)), for: .touchUpInside)
            let annonce = MainList.annonces[indexPath.row]
            let image = UIImage(named: "favoriteOn")
            let image2 = UIImage(named: "favorite5")

            

            
            
           cell.companyImageView.image = UIImage(named: annonce.image)

            
           //cell.commentButton.setImage(UIImage(named: "commentButton"), for: UIControl.State())
            if (annonce.favorite){

               cell.favoriteButton.setImage(image, for: UIControl.State.normal)
                //cell.favoriteButton.imageEdgeInsets = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)

               // cell.favoriteButton.contentMode = UIView.ContentMode.center

            } else {
                cell.favoriteButton.setImage(image2, for: UIControl.State.normal)
               // cell.favoriteButton.contentMode = UIView.ContentMode.center
            }

           //cell.favoriteButton.setImage(UIImage(named: "favoriteButton"), for: UIControl.State())
           //cell.shareButton.setImage(UIImage(named: "shareButton"), for: UIControl.State())
           //cell.followButton.setImage(UIImage(named: "followButton"), for: UIControl.State())




           return cell

        } else {
            //Toggle fav following with tag
            cell.favoriteButton.addTarget(self, action:#selector(setFollowingFav(_:)), for: .touchUpInside)
            let annonce = FollowingList.annonces[indexPath.row]
            let image = UIImage(named: "favoriteOn")
            let image2 = UIImage(named: "favorite5")

            


           cell.companyImageView.image = UIImage(named: annonce.image)

           //cell.commentButton.setImage(UIImage(named: "commentButton"), for: UIControl.State())
            if (annonce.favorite){

               cell.favoriteButton.setImage(image, for: UIControl.State.normal)
                //cell.favoriteButton.imageEdgeInsets = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)

               // cell.favoriteButton.contentMode = UIView.ContentMode.center

            } else {
                cell.favoriteButton.setImage(image2, for: UIControl.State.normal)
               // cell.favoriteButton.contentMode = UIView.ContentMode.center
            }

           //cell.favoriteButton.setImage(UIImage(named: "favoriteButton"), for: UIControl.State())
           //cell.shareButton.setImage(UIImage(named: "shareButton"), for: UIControl.State())
           //cell.followButton.setImage(UIImage(named: "followButton"), for: UIControl.State())




           return cell

        }
        

   }
   //Toggle fav!
     @objc func setFav(_ sender:UIButton){
         if(MainList.annonces[sender.tag].favorite==false){
             MainList.annonces[sender.tag].favorite=true}else{
                 MainList.annonces[sender.tag].favorite=false
             }
       
         tableView.reloadData()
         
       
   }
    
    @objc func setFollowingFav(_ sender:UIButton){
        tableView.reloadData()
        if(FollowingList.annonces[sender.tag].favorite==false){
            FollowingList.annonces[sender.tag].favorite=true
        }else{FollowingList.annonces[sender.tag].favorite=false}
        tableView.reloadData()
        
    }


   func tableView(_ tableView : UITableView, numberOfRowsInSection section: Int) -> Int {
       if (valueToCheck == 0){
           return MainList.annonces.count
       } else {
           return FollowingList.annonces.count
       }

   }
   func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
       let navigate = UIContextualAction(style: .normal, title: "") {
           (action , view , competionHandler) in
           if let vc = self.storyboard?.instantiateViewController(withIdentifier: "CompanyFlowViewController") as? CompanyFlowViewController{
               vc.list2 = MainList.annonces.filter{annonse in
                   return (annonse.companyName == MainList.annonces[indexPath.row].companyName)}
               self.navigationController?.pushViewController(vc, animated: true)}
           competionHandler(true)
       }
       navigate.backgroundColor = UIColor.systemBlue


       let swipe = UISwipeActionsConfiguration(actions: [navigate])
       return swipe
   }
   func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
       let navigate = UIContextualAction(style: .normal, title: "") {
           (action , view , competionHandler) in
           if let vc = self.storyboard?.instantiateViewController(withIdentifier: "companyProfile") as? CompanyProfile{
               vc.companyName = MainList.annonces[indexPath.row].companyName
               self.navigationController?.pushViewController(vc, animated: true)}
           competionHandler(true)
       }
       navigate.backgroundColor = UIColor.black

       let swipe = UISwipeActionsConfiguration(actions: [navigate])
       return swipe
   }


}


class FlowTableViewCell: UITableViewCell{
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!

    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var companyImageView: UIImageView!


}



struct Annonce : Identifiable{
    let id = UUID()
    var title : String
    var image : String
    var companyName : String
    var favorite : Bool
    var discounts : Bool
    var release : Bool
    var event : Bool
    var NearBy : Bool




}
struct MainList {
    static var annonces = [

        Annonce( title: "flower" ,image: "image.jpg", companyName: "Flower", favorite: true, discounts: true, release: false, event: false, NearBy: true),
        Annonce( title: "rabat" ,image: "mcRabat", companyName: "McDonalds", favorite: true, discounts: true, release: false, event: false, NearBy: true),
        Annonce( title: "elektronik" ,image: "media5", companyName: "Mediamarkt", favorite: true, discounts: true, release: false, event: false, NearBy: true),
        Annonce( title: "kläder" ,image: "image1", companyName: "H&M", favorite: false, discounts: true, release: false, event: false, NearBy: true),
        Annonce( title: "Food" ,image: "McDonalds", companyName: "McDonalds", favorite: true, discounts: true, release: false, event: false, NearBy: true),
        Annonce( title: "kläder" ,image: "lager4", companyName: "Lager157", favorite: true, discounts: true, release: false, event: false, NearBy: true),
        Annonce( title: "elektronik" ,image: "media4", companyName: "Mediamarkt", favorite: true, discounts: true, release: false, event: false, NearBy: true),
        Annonce( title: "rabat" ,image: "discount", companyName: "McDonalds", favorite: false, discounts: true, release: false, event: false, NearBy: true),
        Annonce( title: "kläder" ,image: "sale50%", companyName: "H&M", favorite: false, discounts: true, release: false, event: false, NearBy: true),
        Annonce( title: "kläder" ,image: "lager3", companyName: "Lager157", favorite: true, discounts: true, release: false, event: false, NearBy: true),
        Annonce( title: "event" ,image: "mcEvent", companyName: "McDonalds", favorite: true, discounts: true, release: false, event: false, NearBy: true),
        Annonce( title: "kläder" ,image: "sale50%2", companyName: "H&M", favorite: true, discounts: true, release: false, event: false, NearBy: true),
        Annonce( title: "elektronik" ,image: "media2", companyName: "Mediamarkt", favorite: true, discounts: true, release: false, event: false, NearBy: true),
        Annonce( title: "rabat" ,image: "discount", companyName: "McDonalds", favorite: false, discounts: true, release: false, event: false, NearBy: true),
        Annonce( title: "kläder" ,image: "lager1", companyName: "Lager157", favorite: false, discounts: true, release: false, event: false, NearBy: true),
        Annonce( title: "rabat" ,image: "mcEvent1", companyName: "McDonalds", favorite: false, discounts: true, release: false, event: false, NearBy: true),

        Annonce( title: "kläder" ,image: "lager2", companyName: "Lager157", favorite: false, discounts: true, release: false, event: false, NearBy: true),



        Annonce( title: "elektronik" ,image: "media1", companyName: "Mediamarkt", favorite: true, discounts: true, release: false, event: false, NearBy: true),
        Annonce( title: "kläder" ,image: "event1", companyName: "H&M", favorite: true, discounts: true, release: false, event: false, NearBy: true),







    ]

}
struct FollowingList{
    static var annonces = [


        Annonce( title: "rabat" ,image: "mcRabat", companyName: "McDonalds", favorite: true, discounts: true, release: false, event: false, NearBy: true),


        Annonce( title: "kläder" ,image: "lager2", companyName: "Lager157", favorite: false, discounts: true, release: false, event: false, NearBy: true),



        Annonce( title: "elektronik" ,image: "media1", companyName: "Mediamarkt", favorite: true, discounts: true, release: false, event: false, NearBy: true),
        Annonce( title: "kläder" ,image: "event1", companyName: "H&M", favorite: true, discounts: true, release: false, event: false, NearBy: true),







    ]

}
