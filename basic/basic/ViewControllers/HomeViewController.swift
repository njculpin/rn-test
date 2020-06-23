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
    
    var cellId = "listCell"
    var albums = [Album]()
    
    private var searchBar: UISearchBar = UISearchBar()
    private var refreshControl = UIRefreshControl()
    lazy var tapRecognizer: UITapGestureRecognizer = {
      var recognizer = UITapGestureRecognizer(target:self, action: #selector(dismissKeyboard))
      return recognizer
    }()
    
    let api = API()
    
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
    }
    
    func loadSearchBar(){
        view.addSubview(searchBar)
        searchBar.searchBarStyle = UISearchBar.Style.minimal
        searchBar.backgroundColor = UIColor.white
        searchBar.placeholder = "Search"
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.delegate = self
        searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchBar.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor).isActive = true
        searchBar.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor).isActive = true
    }
       
    func loadTableView(){
        view.addSubview(listTableView)
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.register(HomeTableViewCell.self, forCellReuseIdentifier: cellId)
        listTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        listTableView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor).isActive = true
        listTableView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor).isActive = true
        listTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        listTableView.allowsMultipleSelection = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.listTableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
      dismissKeyboard()

      guard let searchText = searchBar.text, !searchText.isEmpty else {
        return
      }

      api.download(searchTerm: searchText) { [weak self] results, errorMessage in

        if let results = results {
          self?.albums = results
          self?.listTableView.reloadData()
          self?.listTableView.setContentOffset(CGPoint.zero, animated: false)
        }

        if !errorMessage.isEmpty {
          print("Search error: " + errorMessage)
        }
      }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
      view.addGestureRecognizer(tapRecognizer)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
      view.removeGestureRecognizer(tapRecognizer)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let album = albums[indexPath.row] as Album
        let cell = listTableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! HomeTableViewCell
        cell.album = album
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let album = albums[indexPath.row] as Album
        print(album)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    @objc func dismissKeyboard() {
      searchBar.resignFirstResponder()
    }

}

