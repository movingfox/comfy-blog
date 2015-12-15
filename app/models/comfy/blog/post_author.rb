class Comfy::Blog::PostAuthor < ActiveRecord::Base

  self.table_name = 'comfy_blog_post_authors'

  belongs_to :author,
    class_name: Comfy::Blog::Author
  belongs_to :post,
    class_name: Comfy::Blog::Post
end
