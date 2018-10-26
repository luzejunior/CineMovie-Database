//
//  MovieModal.swift
//  CineMovie Database
//
//  Created by Luzenildo Junior on 25/10/18.
//  Copyright © 2018 Luzenildo Junior. All rights reserved.
//

import UIKit

class MovieModal: UIViewController, Storyboarded {
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieGenres: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet var mainView: UIView! {
        didSet {
            mainView.layer.cornerRadius = 30
            mainView.clipsToBounds = true
        }
    }
    
    var presenter: MovieModalPresenter?
    weak var coordinator: MainCoordinator?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        configureView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func configureView() {
        moviePoster.kf.indicatorType = .activity
        moviePoster.kf.setImage(with: presenter?.moviePosterURL)
        movieName.text = presenter?.movieTitle
        movieGenres.text = "Genres: " + (presenter?.movieGenre ?? "")
        movieReleaseDate.text = "Release Date: " + (presenter?.movieReleaseDate ?? "")
        movieOverview.text = presenter?.movieOverview
    }
    
    @IBAction func didTouchCloseButton(_ sender: Any) {
        coordinator?.didTouchCloseModal()
    }
}
