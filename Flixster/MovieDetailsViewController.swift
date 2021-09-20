//
//  MovieDetailsViewController.swift
//  Flixster
//
//  Created by Jarod Wellinghoff on 9/13/21.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {
	@IBOutlet weak var backdropView: UIImageView!
	@IBOutlet weak var posterView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var synopsisLabel: UILabel!
	@IBOutlet var posterTapGesture: UITapGestureRecognizer!
	
	var movie: [String:Any]!
	var results = [[String:Any]]()
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
	titleLabel.text = movie["title"] as? String
	synopsisLabel.text = movie["overview"] as? String
	synopsisLabel.sizeToFit()
	
	
	let baseURL = "https://image.tmdb.org/t/p/w185"
	let posterPath = movie["poster_path"] as! String
	let posterURL = URL(string: baseURL + posterPath)!
	
	posterView.af.setImage(withURL: posterURL)
	
	let backdropPath = movie["backdrop_path"] as! String
	let backdropURL = URL(string: "https://image.tmdb.org/t/p/w780" + backdropPath)!
	
	backdropView.af.setImage(withURL: backdropURL)
	
	let id = movie["id"] as? Int
	print(id!)
	let url = URL(string: "https://api.themoviedb.org/3/movie/\(id!)/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
	let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
	let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
	let task = session.dataTask(with: request) { (data, response, error) in
	// This will run when the network request returns
	if let error = error {
		print(error.localizedDescription)

	} else if let data = data {
		// TODO: Get the array of movies
		let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

		// TODO: Store the movies in a property to use elsewhere
		self.results = dataDictionary["results"] as! [[String:Any]]
		print(self.results)


	 }

}
task.resume()
	
    }
	
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let trailerViewController = segue.destination as! TrailerViewController

		trailerViewController.key = results[0]["key"] as! String

    
	}

}
