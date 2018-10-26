//
//  MoviesCell.swift
//  CineMovie Database
//
//  Created by Luzenildo Junior on 25/10/18.
//  Copyright © 2018 Luzenildo Junior. All rights reserved.
//

import UIKit
import Kingfisher

class MoviesCell: UITableViewCell, UITableViewContent {
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieGenreLabel: UILabel!
    @IBOutlet weak var movieReleaseDateLabel: UILabel!
    
    weak var presenter: MoviesCellPresenter?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func load(presenter: MoviesCellPresenter) {
        self.presenter = presenter
        configureView()
    }
    
    func configureView() {
        moviePoster.kf.indicatorType = .activity
        moviePoster.kf.setImage(with: presenter?.moviePosterURL)
        movieNameLabel.text = presenter?.movieTitle
        movieGenreLabel.text = "Genres: " + (presenter?.movieGenre ?? "")
        movieReleaseDateLabel.text = "Release Date: " + (presenter?.movieReleaseDate ?? "")
    }
}

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
