class Comfy::Blog::Category < ActiveRecord::Base

  self.table_name = 'comfy_blog_categories'

  belongs_to :blog
  has_many :comfy_blog_post_categories,
    class_name: Comfy::Blog::PostCategory
  has_many :posts,
    through: :comfy_blog_post_categories,
    class_name: Comfy::Blog::Post
  validates :name, :blog,
    presence: true
  validates :name,
    uniqueness: true

  # Class methods
  class << self
    def for_this_blog(blog)
      where(blog_id: blog.id)
    end
  end
end
