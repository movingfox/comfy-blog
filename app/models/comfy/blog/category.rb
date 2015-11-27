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

  def self.for_this_site(blog)
    where(blog_id: blog.id)
  end
end
