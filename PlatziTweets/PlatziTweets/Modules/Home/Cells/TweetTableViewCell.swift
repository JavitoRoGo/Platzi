//
//  TweetTableViewCell.swift
//  PlatziTweets
//
//  Created by Javier Rodríguez Gómez on 17/3/23.
//

import Kingfisher
import UIKit

class TweetTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var tweetImageView: UIImageView!
    @IBOutlet weak var videoButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBAction func openVideoAction(_ sender: Any) {
        // Las celdas NUNCA deben invocar un ViewController
        // Hay que decirle a la tabla que abra el ViewController del reproductor
        guard let videoUrl else { return }
        needsToShowVideo?(videoUrl)
    }
    
    private var videoUrl: URL?
    var needsToShowVideo: ((_ url: URL) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCellWith(post: Post) {
        videoButton.isHidden = !post.hasVideo
        nameLabel.text = post.author.names
        nicknameLabel.text = post.author.nickname
        messageLabel.text = post.text
        if post.hasImage {
            tweetImageView.isHidden = false
            tweetImageView.kf.setImage(with: URL(string: post.imageUrl))
        } else {
            tweetImageView.isHidden = true
        }
        
        videoUrl = URL(string: post.videoUrl)
    }
}
