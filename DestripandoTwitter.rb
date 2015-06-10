require 'nokogiri'



class TwitterScrapper
attr_reader :tweets_v, :following_v, :followers_v, :favorites_v, :content

  def initialize(url)
  	@page = Nokogiri::HTML(open("twitter_account.html"))

  end

  def extract_username
  	@profile_name = @page.search("h1.ProfileHeaderCard-name > a").text
  end

  def extract_tweets
  # @date = @page.search(".tweet-timestamp > span").text
  @content = @page.search(".content")
    @content.each do |i|
      p i.search(".tweet-text").inner_text
      p i.search(".tweet-timestamp").inner_text
      p i.search("button.js-actionRetweet .ProfileTweet-actionCountForPresentation").first.inner_text
      p i.search("button.js-actionFavorite .ProfileTweet-actionCountForPresentation").first.inner_text
    end
  end

  def extract_stats
    @tweets_v = @page.search(".ProfileNav-item--tweets > a > span:nth-child(2)").text
    @following_v = @page.search(".ProfileNav-item--following > a > span:nth-child(2)").text
    @followers_v = @page.search(".ProfileNav-item--followers > a > span:nth-child(2)").text
    @favorites_v = @page.search(".ProfileNav-item--favorites > a > span:nth-child(2)").text
  end

end


twitter = TwitterScrapper.new("twitter_account.html")
twitter.extract_stats
puts "Username: #{twitter.extract_username}"
puts "-" * 60
puts "Tweets: #{twitter.tweets_v} Following: #{twitter.following_v} Followers: #{twitter.followers_v} Favorites: #{twitter.favorites_v}"
puts "-" * 60
puts twitter.extract_tweets



