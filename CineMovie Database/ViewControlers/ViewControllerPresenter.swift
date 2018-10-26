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
    
    var currentPage: Int = 1
    var maxPages: Int = 0
    
    init(view: ViewController) {
        self.view = view
    }
    
    func fetchData() {
        RequestUpcoming.PerformRequest(page: currentPage, completion: (createTableElements))
    }
    
    func createTableElements(data: UpcomingResponse) {
        if !(view?.loadingMoreContent ?? false) {
            dataSource.items.removeAll()
        }
        maxPages = data.total_pages
        for movie in data.results {
            let tableViewContent = MoviesCellPresenter(movie: movie)
            dataSource.items.append(tableViewContent)
        }
        view?.viewDidFinishedLoading()
    }
    
    func loadMoreContent() {
        currentPage += 1
        if currentPage < maxPages {
            fetchData()
        }
    }
}
