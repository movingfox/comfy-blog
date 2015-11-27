class Comfy::Blog::PostCategory < ActiveRecord::Base
  belongs_to :category,
    class_name: Comfy::Blog::Category
  belongs_to :post,
    class_name: Comfy::Blog::Post
end
