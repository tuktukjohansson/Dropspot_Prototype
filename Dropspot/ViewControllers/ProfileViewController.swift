//
//  ProfileViewController.swift
//  Dropspot
//
//  Created by Kevin Zetterlind on 2022-09-12.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var scrollViewDesign: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollViewDesign.layer.cornerRadius = 20

        // Do any additional setup after loading the view.
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
