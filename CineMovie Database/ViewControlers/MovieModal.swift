//
//  MovieModal.swift
//  CineMovie Database
//
//  Created by Luzenildo Junior on 25/10/18.
//  Copyright © 2018 Luzenildo Junior. All rights reserved.
//

import UIKit

class MovieModal: UIViewController, Storyboarded {
    
    // IBOutlets
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieGenres: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieOverview: UILabel! {
        didSet {
            if UIDevice.current.orientation.isLandscape {
                movieOverview.textColor = .white
                movieOverview.shadowColor = .black
            }
        }
    }
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
    
    // Check rotation to change text color
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
            movieOverview.textColor = .white
            movieOverview.shadowColor = .black
        } else {
            movieOverview.textColor = .black
            movieOverview.shadowColor = .white
        }
    }
    
    // View IBOutlets configuration
    func configureView() {
        headerImage.kf.indicatorType = .activity
        headerImage.kf.setImage(with: presenter?.movieHeaderURL)
        moviePoster.kf.indicatorType = .activity
        moviePoster.kf.setImage(with: presenter?.moviePosterURL) { (image, error, _, _) in
            if image == nil {
                self.moviePoster.image = UIImage(named: "default_poster")
            }
        }
        movieName.text = presenter?.movieTitle
        movieGenres.text = "Genres: " + (presenter?.movieGenre ?? "")
        movieReleaseDate.text = "Release Date: " + (presenter?.movieReleaseDate ?? "")
        movieOverview.text = presenter?.movieOverview
    }
    
    // On close button, call coordinator
    @IBAction func didTouchCloseButton(_ sender: Any) {
        coordinator?.didTouchCloseModal()
    }
}
