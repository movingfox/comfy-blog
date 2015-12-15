class Comfy::Blog::PostCategory < ActiveRecord::Base

  self.table_name = 'comfy_blog_post_categories'

  belongs_to :category,
    class_name: Comfy::Blog::Category
  belongs_to :post,
    class_name: Comfy::Blog::Post
end
