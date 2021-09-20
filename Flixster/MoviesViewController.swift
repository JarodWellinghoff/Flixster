//
//  MoviesViewController.swift
//  Flixster
//
//  Created by Jarod Wellinghoff on 9/12/21.
//

import UIKit
import AlamofireImage

class MoviesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	@IBOutlet weak var tableView: UITableView!
	
	var results = [[String:Any]]()

	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.delegate = self
		tableView.dataSource = self
		
		let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
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
				// print(self.results)
				
				// TODO: Reload your table view data
				self.tableView.reloadData()

			 }
			
		}
		task.resume()
	

        // Do any additional setup after loading the view.
    }
    
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return results.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
		let row = indexPath.row
		
		let movie = results[row]
		let title = movie["title"] as? String
		let syopsis = movie["overview"] as? String
		
		cell.titleLabel!.text = title
		cell.synopsisLabel!.text = syopsis
		
		let baseURL = "https://image.tmdb.org/t/p/w185"
		let posterPath = movie["poster_path"] as! String
		let posterURL = URL(string: baseURL + posterPath)!
		
		cell.posterView.af.setImage(withURL: posterURL)
		
		return cell
	}

	
 // MARK: - Navigation

 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	// Find selected movie
	let cell = sender as! UITableViewCell
	let indexPath = tableView.indexPath(for: cell)!
	let movie = results[indexPath.row]
	
	// Pass selected movie to the details veiw controller
	let detailsViewController = segue.destination as! MovieDetailsViewController
	detailsViewController.movie = movie
	
	// Deselect row after segue
	tableView.deselectRow(at: indexPath, animated: true)
 }

}
