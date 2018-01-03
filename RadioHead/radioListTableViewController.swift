//
//  radioListTableViewController.swift
//  RadioHead
//
//  Created by Mac on 01/01/2018.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit

class radioListTableViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    
    
    
    var myArtists : TopArtists = TopArtists()
    
    
    @IBOutlet var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        print("toto")
        
        self.tableView.register(UINib(nibName: "ArtistCell", bundle: Bundle.main), forCellReuseIdentifier: "myCell")
        
        getJson{ (resultats) in
            self.myArtists = TopArtists( listArtists: resultats)
            
            print(self.myArtists)
            
            DispatchQueue.main.async {
                self.tableView.reloadData() // MUST BE DONE on the main thread
            }
            
            
            
        }
        
        
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.myArtists.artists.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : ArtistCell = (tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as? ArtistCell)!
        cell.fill(name: myArtists.artists[indexPath.row].name! )
        
        return cell
    }
    
    func getJson(completion : @escaping (_ dictionaire : [Dictionary<String,Any>]) -> ()){
        
        
        let url = URL(string :"http://ws.audioscrobbler.com/2.0/?method=geo.gettopartists&country=israel&api_key=80f3e0409dc74d296659da20c093c421&format=json")!
        
        
        
        var urlRequest : URLRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
//        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        
        //        let task : URLSessionDataTask = session.dataTask(with: requete, completionHandler: { (data,response,error ) in
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error == nil{
                if let dataOK = data{
                    
                    if let jsonDictionnaire = try! JSONSerialization.jsonObject(with: dataOK, options: []) as? Dictionary<String, Any>{
                        let temp = jsonDictionnaire["topartists"] as? Dictionary<String,Any>
                        let resultats = temp!["artist"] as? [Dictionary<String,Any>]
                        completion(resultats!)
                    }
                }
            }
            
        }
        task.resume()
        //            let someDictionaryFromJSON = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
        //            let json4Swift_Base = Json4Swift_Base(someDictionaryFromJSON)
        //
        //        }
        //        task.resume()
        //
        
    }
    
}
