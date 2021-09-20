//
//  TrailerViewController.swift
//  Flixster
//
//  Created by Jarod Wellinghoff on 9/19/21.
//

import UIKit
import WebKit

class TrailerViewController: UIViewController, WKUIDelegate {
	@IBOutlet var trailerWebView: WKWebView!
	
	var key = String()
	
	override func loadView() {
		let webConfiguration = WKWebViewConfiguration()
		trailerWebView = WKWebView(frame: .zero, configuration: webConfiguration)
		trailerWebView.uiDelegate = self
		view = trailerWebView
	}
	
    override func viewDidLoad() {
		super.viewDidLoad()

	let myURL = URL(string:"https://www.youtube.com/watch?v=\(key)?playsinline=1")
	let myRequest = URLRequest(url: myURL!)
	trailerWebView.load(myRequest)
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
}
