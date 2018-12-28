//
//  MoviesCell.swift
//  CineMovie Database
//
//  Created by Luzenildo Junior on 25/10/18.
//  Copyright © 2018 Luzenildo Junior. All rights reserved.
//

import UIKit
import Kingfisher

// Movies cell controller
class MoviesCell: UITableViewCell, UITableViewContent {
    
    // IBOutlets
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieGenreLabel: UILabel!
    @IBOutlet weak var movieReleaseDateLabel: UILabel!
    
    // Presenter
    weak var presenter: MoviesCellPresenter?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // Load cell content
    func load(presenter: MoviesCellPresenter) {
        self.presenter = presenter
        configureView()
    }
    
    // Configure cell content
    func configureView() {
        moviePoster.kf.indicatorType = .activity
        moviePoster.kf.setImage(with: presenter?.moviePosterURL) { (image, _, _, _) in
            if image == nil {
                self.moviePoster.image = UIImage(named: "default_poster")
            }
        }
        movieNameLabel.text = presenter?.movieTitle
        movieGenreLabel.text = "Genres: " + (presenter?.movieGenre ?? "")
        movieReleaseDateLabel.text = "Release Date: " + (presenter?.movieReleaseDate ?? "")
    }
}

// Movie cell presenter
class MoviesCellPresenter: UITableViewModels {
    var representable: UITableViewRepresentable {
        return UITableViewContentAssembler<MoviesCell>(presenter: self)
    }
    
    var movie: MovieData?
    var movieTitle: String {
        return movie?.title ?? ""
    }
    var movieGenre: String {
        var string = ""
        for id in movie?.genre_ids ?? [0] {
            string += "\(retrieveGenre(id)). "
        }
        return string
    }
    var movieReleaseDate: String {
        return movie?.release_date ?? ""
    }    
    var moviePosterURL: URL {
        return URL(string: RequestUpcoming.imageDownloadURL + (movie?.poster_path ?? ""))!
    }
    
    init(movie: MovieData) {
        self.movie = movie
    }
}
