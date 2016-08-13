//
//  ViewController.swift
//  ImageLoader
//
//  Created by Rohit Pal on 10/08/16.
//  Copyright © 2016 Rohit Pal. All rights reserved.
//

import UIKit

class GetUrlViewController: UIViewController, NSURLSessionDownloadDelegate {
    
    @IBOutlet var progressView: ProgressView!
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet var statusLabel: UILabel!
    
    
    @IBOutlet weak var downloadButton: DownloadButton!
    private var downloadTask: NSURLSessionDownloadTask?
    
    @IBAction func downloadButtonPressed() {
        print("Donwload Button Pressed")
        if let downloadTask = downloadTask {
            downloadTask.cancel()
            statusLabel.text = ""
        } else {
            statusLabel.text = "Downloading file"
            downloadButton.setTitle("Stop download", forState: .Normal)
            createDownloadTask()
        }
    }
    
    func createDownloadTask() {
        if textField.text!.isEmpty == false {
            if validateUrl(textField.text) {
                let downloadRequest = NSMutableURLRequest(URL: NSURL(string: textField.text!)!)
                let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration(), delegate: self, delegateQueue: NSOperationQueue.mainQueue())
                
                downloadTask = session.downloadTaskWithRequest(downloadRequest)
                downloadTask!.resume()
            }else {
                showAlert("Invalid Url")
            }
            
        } else {
            showAlert("Please Enter the Url in Above TextField")
        }
        
    }
    
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        progressView.animateProgressViewToProgress(progress)
        progressView.updateProgressViewLabelWithProgress(progress * 100)
        progressView.updateProgressViewWith(Float(totalBytesWritten), totalFileSize: Float(totalBytesExpectedToWrite))
    }
    
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL) {
        statusLabel.text = "Download finished"
        print(downloadTask.response?.MIMEType)
        let mimeType = downloadTask.response?.MIMEType
        if mimeType == "image/jpeg" || mimeType == "image/png" || mimeType == "image/gif" {
            
            //Get documents directory URL
            let documentsDirectoryUrl =  NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first! as NSURL

            
            //Get the file name and create a destination URL
            let fileName = location.lastPathComponent!
            let destinationURL = documentsDirectoryUrl.URLByAppendingPathComponent(fileName)

            if let fileData = NSData(contentsOfURL: location) {
                fileData.writeToURL(destinationURL, atomically: false)   // true
                print(destinationURL.path!)
            }
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let imageViewController = storyboard.instantiateViewControllerWithIdentifier("ImageVC") as! ImageViewController
            imageViewController.imageUrl = destinationURL.path!
            navigationController?.pushViewController(imageViewController, animated: true)
        } else {
            showAlert("Download finished")
        }
        resetView()
    }
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        if error != nil {
            statusLabel.text = "Download failed"
        } else {
            statusLabel.text = "Download finished"
        }
        resetView()
    }
    
    func resetView() {
        downloadButton.setTitle("Start download", forState: .Normal)
        
        downloadTask!.cancel()
    }
    
    // MARK: view methods
    override func viewDidLoad() {
        super.viewDidLoad()
        statusLabel.text = ""
        addGradientBackgroundLayer()
    }
    
    func addGradientBackgroundLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.frame
        
        let colorTop: AnyObject = UIColor(red: 252/255, green: 72/255, blue: 49/255, alpha: 1).CGColor
        let colorBottom: AnyObject = UIColor(red: 36.0/255.0, green: 115.0/255.0, blue: 192.0/255.0, alpha: 1.0).CGColor
        gradientLayer.colors = [colorTop, colorBottom]
        
        gradientLayer.locations = [0.0, 1.0]
        view.layer.insertSublayer(gradientLayer, atIndex: 0)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    func validateUrl (urlString: String?) -> Bool {
        let urlRegEx = "(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+"
        return NSPredicate(format: "SELF MATCHES %@", urlRegEx).evaluateWithObject(urlString)
    }
    
    func showAlert(message: String) {
        let AlertView = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        AlertView.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler:nil))
        self.presentViewController(AlertView, animated: true, completion: nil)
        
    }
    
}
