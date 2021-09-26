//
//  ViewController.swift
//  VideoPlayerWebView
//
//  Created by Manish Kumar on 25/09/21.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    var currentItemIndex : Int = 1
    var videoArray = ["Video1", "Video2", "Video3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        webView = WKWebView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height), configuration: getWebConfigurations())
        self.view.addSubview(webView)
        
        //Load the first Video
        playNextVideo(index: currentItemIndex)
    }
    
    func playerDidFinishPlaying(note: NSNotification) {
        print("Video Finished")
        
        playNextVideo(index: currentItemIndex + 1)
    }
    
    //MARK: Initialization Methods
    
    func getWebConfigurations() ->  WKWebViewConfiguration {
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.allowsInlineMediaPlayback = true
        webConfiguration.mediaTypesRequiringUserActionForPlayback = [.all]
        
        //Can be used if needed
        webConfiguration.allowsPictureInPictureMediaPlayback = true
        webConfiguration.allowsAirPlayForMediaPlayback = true
        
        return webConfiguration
    }
    
    func getVideoURLRequest(index: Int) -> URLRequest {
        let urlVideo = Bundle.main.url(forResource: videoArray[index], withExtension: "mp4")
        let request:URLRequest = URLRequest(url: urlVideo!)
        
        return request
    }
    
    //MARK: Video Play Methods
    func playNextVideo(index: Int) {
        
        if index <= videoArray.count {
            webView.load(getVideoURLRequest(index: index))
            
        } else {
            //Resetting the current Index
            currentItemIndex = 1
            
            let alert = UIAlertController(title: "VideoPlayerWebView", message: "You have reached Last video", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}


