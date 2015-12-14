class Comfy::Blog::Author < ActiveRecord::Base

  self.table_name = 'comfy_blog_authors'

  belongs_to :blog
  has_many :comfy_blog_post_authors,
    class_name: Comfy::Blog::PostAuthor
  has_many :posts,
    through: :comfy_blog_post_authors
  validates :first_name, :last_name, :blog_id,
    presence: true

  class << self
    def for_blog(blog)
      where(blog_id: blog.id)
    end
  end
end
