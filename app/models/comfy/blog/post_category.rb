class Comfy::Blog::PostCategory < ActiveRecord::Base
  belongs_to :category,
    class: Comfy::Blog::Category
  belongs_to :post,
    class: Comfy::Blog::Post
end
