//
//  MovieCell.swift
//  TMDB-test
//
//  Created by Andres Diaz  on 11/05/23.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var descriptionMovieLabel: UILabel!
    @IBOutlet weak var titleMovieLabel: UILabel!
    let aIndicator = UIActivityIndicatorView(style: .large)

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        aIndicator.center = center
        addSubview(aIndicator)
//        aIndicator.startAnimating()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
