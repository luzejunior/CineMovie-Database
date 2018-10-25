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
    
    init(view: ViewController) {
        self.view = view
    }
    
    func fetchData() {
        RequestUpcoming.PerformRequest(page: 1, completion: (printResults))
    }
    
    func printResults(data: UpcomingResponse) {
        for movie in data.results {
            print("Movie name: " + movie.title)
        }
        view?.viewDidFinishedLoading()
    }
}
