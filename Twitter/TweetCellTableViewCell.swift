//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Yunior Sanchez on 9/30/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var reTweetBtn: UIButton!
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var tweetContent: UILabel!
   
    var favorited:Bool = false
    var tweetId:Int = -1
    
    
    @IBAction func retweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetID: tweetId, success: {
            self.setRetweeted(true)
        }, failure: { (error) in
            print("Error is retweeting: \(error)")
        })
    }
    
    func setRetweeted(_ isRetweeted:Bool) {
        if (isRetweeted) {
            reTweetBtn.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            reTweetBtn.isEnabled = false
        } else {
            reTweetBtn.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            reTweetBtn.isEnabled = true
        }
    }
    
    @IBAction func favoriteTweet(_ sender: Any) {
        let tobeFavorited = !favorited
        if (tobeFavorited){
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(true)
            }, failure: { (error) in
                print("Favorite did not succeed: \(error)")
            })
        } else {
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(false)
            }, failure: {
                (error) in
                print("unfavorite did not succeed: \(error)")
            })
        }
    }
    
 
    func setFavorite(_ isFavorited: Bool) {
        favorited = isFavorited
        if (favorited) {
            favBtn.setImage(UIImage(named: "favor-icon 1"), for: UIControl.State.normal)
        }
        else {
            favBtn.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
