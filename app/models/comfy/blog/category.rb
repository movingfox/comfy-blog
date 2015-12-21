class Comfy::Blog::Category < ActiveRecord::Base

  self.table_name = 'comfy_blog_categories'

  belongs_to :blog
  has_many :comfy_blog_post_categories,
    class_name: Comfy::Blog::PostCategory
  has_many :posts,
    through: :comfy_blog_post_categories
  validates :name, :blog_id,
    presence: true
  validates :name,
    uniqueness: {
      scope: :blog,
      message: "This blog already has a category with this name"
    }
end
