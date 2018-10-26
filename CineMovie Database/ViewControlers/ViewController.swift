//
//  ViewController.swift
//  CineMovie Database
//
//  Created by Luzenildo Junior on 25/10/18.
//  Copyright © 2018 Luzenildo Junior. All rights reserved.
//

import UIKit

class ViewController: BaseViewController, Storyboarded, UISearchResultsUpdating, UITableViewDelegate {
    
    // IBOutlets:
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.rowHeight = UITableView.automaticDimension
            registerCells()
        }
    }
    
    var coordinator: MainCoordinator?
    var presenter: ViewControllerPresenter?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.title = "Upcoming Movies"
        createSearchBar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Start activity indicator:
        activityIndicator.startAnimating()
        // Set presenter instance
        presenter = ViewControllerPresenter(view: self)
        presenter!.fetchData()
        // Set tableview datasource
        tableView.dataSource = presenter?.dataSource
    }
    
    func viewDidFinishedLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
            self.loadingMoreContent = false
        }
    }
    
    // --------------- Search Bar ---------------
    
    var isSearching = false
    
    // Create search Bar
    func createSearchBar() {
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        self.navigationItem.searchController = search
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    // Method to change results
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    // --------------- Table View ---------------
    
    var loadingMoreContent = false
    
    // Register table view cells
    func registerCells() {
        tableView.register(MoviesCell.self)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        // Change 10.0 to adjust the distance from bottom
        if maximumOffset - currentOffset <= 10.0 && !loadingMoreContent {
            print("Time to load more content")
            loadingMoreContent = true
            presenter?.loadMoreContent()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = presenter?.dataSource.items[indexPath.row].selectedRow() as? MovieData
        coordinator?.didTouchTableViewRow(movie: movie!)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

