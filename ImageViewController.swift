//
//  ImageViewController.swift
//  ImageLoader
//
//  Created by Rohit Pal on 11/08/16.
//  Copyright © 2016 Rohit Pal. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    var imageUrl: String?
    
    @IBOutlet var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

//        print("Got this URL" + imageUrl!)
        if imageUrl != nil {
            let networkService = NetworkService(url: NSURL(string: self.imageUrl!)!)
            networkService.fetchImage({(data) in
                let image = UIImage(data: data)
                dispatch_async(dispatch_get_main_queue(), {
                    self.imageView.image = image
                })
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
