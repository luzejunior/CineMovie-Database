//
//  ViewController.swift
//  CineMovie Database
//
//  Created by Luzenildo Junior on 25/10/18.
//  Copyright © 2018 Luzenildo Junior. All rights reserved.
//

import UIKit

class ViewController: BaseViewController, Storyboarded, UISearchResultsUpdating, UITableViewDelegate, UISearchBarDelegate {
    
    // IBOutlets
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.alpha = 0.0
            tableView.delegate = self
            tableView.rowHeight = UITableView.automaticDimension
            registerCells()
        }
    }
    @IBOutlet weak var internetConnectionLabel: UILabel! {
        didSet {
            internetConnectionLabel.alpha = 0.0
        }
    }
    
    var coordinator: MainCoordinator?
    var presenter: ViewControllerPresenter?
    
    let reachability = Reachability()!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.title = "Upcoming Movies"
        createSearchBar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInternetConnection()
        // Start activity indicator:
        activityIndicator.startAnimating()
        // Set presenter instance
        presenter = ViewControllerPresenter(view: self)
        // Set tableview datasource
        tableView.dataSource = presenter?.dataSource
    }
    
    // When finished fetching
    func viewDidFinishedLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
            self.loadingMoreContent = false
            self.tableView.FadeIn(0.7)
        }
    }
    
    // Show alert
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func setupInternetConnection() {
        reachability.whenReachable = { _ in
            if self.presenter!.currentMovieList.count == 0 {
                self.presenter!.fetchData()
            } else {
                self.tableView.FadeIn(0.7)
            }
            if self.internetConnectionLabel.alpha != 0.0 {
                self.internetConnectionLabel.FadeOut(0.7)
            }
            self.navigationItem.searchController?.searchBar.isUserInteractionEnabled = true
        }
        reachability.whenUnreachable = { _ in
            self.tableView.FadeOut(0.7)
            self.internetConnectionLabel.FadeIn(0.7)
            self.navigationItem.searchController?.searchBar.isUserInteractionEnabled = false
        }
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    // --------------- Search Bar ---------------
    
    var isSearching = false
    var canceledEditing = false
    var searchBarText = ""
    
    // Create search Bar
    func createSearchBar() {
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.searchBar.delegate = self
        search.dimsBackgroundDuringPresentation = false
        self.navigationItem.searchController = search
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    // Method to change results
    func updateSearchResults(for searchController: UISearchController) {
        if !canceledEditing {
            searchBarText = searchController.searchBar.text!
        }
        presenter?.searchBarResults(searchBarText)
    }
    
    // When begin edit search bar, set flag to true
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearching = true
    }
    
    // When finish editing, set flags to false
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        canceledEditing = false
        isSearching = false
    }
    
    // When cancel button clicked, reset every flag
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        canceledEditing = true
        isSearching = false
    }
    
    // --------------- Table View ---------------
    
    var loadingMoreContent = true
    
    // Register table view cells
    func registerCells() {
        tableView.register(MoviesCell.self)
    }
    
    // Method to listen when hit tableview bottom
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        if maximumOffset - currentOffset <= 10.0 && !loadingMoreContent && !isSearching {
            loadingMoreContent = true
            presenter?.loadMoreContent()
        }
    }
    
    // When select tableview row, call coordinator modal
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = presenter?.currentMovieList[indexPath.row]
        coordinator?.didTouchTableViewRow(movie: movie!)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

