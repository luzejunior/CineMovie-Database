//
//  ViewControllerPresenter.swift
//  CineMovie Database
//
//  Created by Luzenildo Junior on 25/10/18.
//  Copyright © 2018 Luzenildo Junior. All rights reserved.
//

import UIKit

final class ViewControllerPresenter {
    
    weak var view: ViewController?
    var dataSource = GenericDataSource()
    
    var totalMoviesList = [MovieData]()
    var currentMovieList = [MovieData]()
    
    var currentPage: Int = 1
    var maxPages: Int = 0
    
    init(view: ViewController) {
        self.view = view
    }
    
    // Fetch data
    func fetchData() {
        RequestUpcoming.getUpcomingMovies(page: currentPage, completion: (createTableElements), error: (handleError))
    }
    
    // Create all tableview rows
    func createTableElements(data: UpcomingResponse) {
        maxPages = data.total_pages
        totalMoviesList.append(contentsOf: data.results)
        currentMovieList.append(contentsOf: data.results)
        createTableViewData()
    }
    
    func createTableViewData() {
        dataSource.items.removeAll()
        for movie in currentMovieList {
            let tableViewContent = MoviesCellPresenter(movie: movie)
            dataSource.items.append(tableViewContent)
        }
        view?.viewDidFinishedLoading()
    }
    
    // Load more content if needed
    func loadMoreContent() {
        currentPage += 1
        if currentPage < maxPages {
            fetchData()
        }
    }
    
    func searchBarResults(_ searchBarText: String) {
        guard !searchBarText.isEmpty else {
            currentMovieList = totalMoviesList
            createTableViewData()
            return
        }
        currentMovieList = totalMoviesList.filter({($0.title?.contains(searchBarText))!})
        createTableViewData()
    }
    
    func handleError(error: NetworkError) {
        
    }
}
