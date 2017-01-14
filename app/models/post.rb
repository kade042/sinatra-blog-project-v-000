class Post < ActiveRecord::Base

  belongs_to :user
  belongs_to :category

  def slug
    self.name.gsub(/\s/, "-").downcase
  end

  def self.find_by_slug(slug)
    Post.all.find{|post| post.slug == slug}
  end

  def self.find_by_category(id)
    #Post.where()
  end

  def self.valid_params?(params)
    return !params[:post][:title].empty? && !params[:post][:content].empty?
  end
end
