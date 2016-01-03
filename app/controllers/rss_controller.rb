class RssController < ApplicationController
  def all
    @articles = Article.where(published: (Time.now - 7.day)..Time.now)

    respond_to do |format|
      format.rss { render :layout => false }
    end
  end

  def top3
    @articles = Article.where(published: (Time.now - 7.day)..Time.now).where.not(achievement: 0)

    respond_to do |format|
      format.rss { render :layout => false }
    end
  end

  def topweek
    @articles = Article.where(published: (Time.now - 7.day)..Time.now).where(achievement: 2)

    respond_to do |format|
      format.rss { render :layout => false }
    end
  end
end
