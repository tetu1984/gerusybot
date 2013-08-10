class WelcomeController < ApplicationController
  def index
  end

  def tweet
    tweet = "@gerusy Coffee please. (#{Time.now})"
    begin
      Twitter.update(tweet.chomp)
      flash[:info] = "Sent a message to @gerusy."
    rescue => e
      flash[:error] = e.message
    end

    redirect_to :controller => 'welcome', :action => "index"
  end
end

