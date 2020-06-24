//
//  ViewController.swift
//  basic
//
//  Created by Nick Culpin on 6/22/20.
//  Copyright © 2020 basic. All rights reserved.
//

import UIKit

class HomeViewController:
    UIViewController,
    UISearchBarDelegate,
    UITableViewDelegate,
    UITableViewDataSource {
    
    let api = API()
    
    var cellId = "listCell"
    var albums = [Album]()
    
    var searchBar: UISearchBar = UISearchBar()
    
    // register a tap recognizer to help the user dismiss
    // the keyboard
    lazy var tapRecognizer: UITapGestureRecognizer = {
      var recognizer = UITapGestureRecognizer(target:self, action: #selector(dismissKeyboard))
      return recognizer
    }()
    
    private var listTableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = UIColor.white
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadSearchBar()
        loadTableView()
        self.title = "Apple Music Search"
    }
    
    func loadSearchBar(){
        view.addSubview(searchBar)
        
        // styles
        searchBar.searchBarStyle = UISearchBar.Style.minimal
        searchBar.backgroundColor = UIColor.white
        searchBar.placeholder = "Search"
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        
        // accessibilty label is required for testing
        searchBar.isAccessibilityElement = true
        searchBar.accessibilityIdentifier = "search-bar"

        // delegate
        searchBar.delegate = self
        
        // Constraints.swift is a helper file to quickly bind constraints for an element
        searchBar.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, left: self.view.leftAnchor, bottom: nil, right: self.view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
    }
       
    func loadTableView(){
        view.addSubview(listTableView)
        
        // accessibilty label is required for testing
        listTableView.isAccessibilityElement = true
        listTableView.accessibilityIdentifier = "list-table"
        
        // register delegate / datasource
        listTableView.delegate = self
        listTableView.dataSource = self
        
        // register cells
        listTableView.register(HomeTableViewCell.self, forCellReuseIdentifier: cellId)
        
        // Constraints.swift is a helper file to quickly bind constraints for an element
        listTableView.anchor(top:self.searchBar.bottomAnchor, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        // since we are moving into a detail view, we dont neeed to allow multiple selections
        listTableView.allowsMultipleSelection = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // insets for the tableview
        self.listTableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // when user presses search or / enter in sim
        // dimiss the keyboard
      dismissKeyboard()
        
        // confirm there is a value to search on
      guard let searchText = searchBar.text, !searchText.isEmpty else {
        return
      }

        // call api searvice to retrieve data
      api.download(searchTerm: searchText) { [weak self] results, errorMessage in

        if let results = results {
          self?.albums = results
            // reload the table content when the results are recieved
          self?.listTableView.reloadData()
            // reset position of the list
          self?.listTableView.setContentOffset(CGPoint.zero, animated: false)
            
            // if there are no results, show user
            if results.count <= 0 {
                self?.showAlert(title: "Oops!", message: "No results, try again")
            }
        }

        if !errorMessage.isEmpty {
          // if the error message has a value
          // pop an alert to the user
            self?.showAlert(title: "Error", message: errorMessage)
        }
        
      }
    }
    
    // basic alert with a message, could be more creative and less instrusive with no result
    func showAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // if the user taps the screen we assume they have finished editing the search bar in some way
    // remove the keyboard with the gesture recognizer
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
      view.addGestureRecognizer(tapRecognizer)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
      view.removeGestureRecognizer(tapRecognizer)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar){
        DispatchQueue.main.async {
            self.clearAndReload()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        // when a user clicks 'x' in the search bar
        // clear the details since it will only clear the search bar itself
        if searchText.count == 0 {
            DispatchQueue.main.async {
                self.clearAndReload()
            }
        }
    }
    
    func clearAndReload(){
        // remove all the items from the albums array
        self.albums.removeAll()
        // reload the table
        self.listTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let album = albums[indexPath.row] as Album
        let cell = listTableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! HomeTableViewCell
        cell.album = album
        // prevent the style highlighting of the cell
        cell.selectionStyle = .none
        
        // accessibility
        cell.isAccessibilityElement = true
        cell.accessibilityIdentifier = ("\(indexPath.row)")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let album = albums[indexPath.row] as Album
        let DetailView = DetailViewController()
        DetailView.album = album
        navigationController?.pushViewController(DetailView, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // height of the cell allows for an 8pt buffer on y
        return 116
    }

    @objc func dismissKeyboard() {
      searchBar.resignFirstResponder()
    }
    

}

