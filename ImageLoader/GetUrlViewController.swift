//
//  ViewController.swift
//  ImageLoader
//
//  Created by Rohit Pal on 10/08/16.
//  Copyright © 2016 Rohit Pal. All rights reserved.
//

import UIKit

class GetUrlViewController: UIViewController {
    
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var downloadImageButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func downloadImage(sender: AnyObject) {
        if urlTextField.text!.isEmpty == false {
            if validateUrl(urlTextField.text) {
//                print("Entered Url is : " + urlTextField.text!)
//                self.performSegueWithIdentifier("DownloadImage", sender: <#T##AnyObject?#>)
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let imageViewController = storyboard.instantiateViewControllerWithIdentifier("ImageVC") as! ImageViewController
                imageViewController.imageUrl = urlTextField.text
                navigationController?.pushViewController(imageViewController, animated: true)
//                presentViewController(imageViewController, animated: true, completion: nil)
            } else {
                print("Invalid Url")
                
            }
            
        } else {
            print("Please Enter the URL")
        }
    }
    
    func validateUrl (urlString: String?) -> Bool {
        let urlRegEx = "(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+"
        return NSPredicate(format: "SELF MATCHES %@", urlRegEx).evaluateWithObject(urlString)
    }
    
    

}

