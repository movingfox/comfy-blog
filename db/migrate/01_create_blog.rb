class CreateBlog < ActiveRecord::Migration

  def self.up
    create_table :comfy_blogs do |t|
      t.integer :site_id,     null: false
      t.string  :label,       null: false
      t.string  :identifier,  null: false
      t.string  :app_layout,  null: false, default: 'application'
      t.string  :path
      t.text    :description
    end
    add_index :comfy_blogs, [:site_id, :path]
    add_index :comfy_blogs, :identifier

    create_table :comfy_blog_posts do |t|
      t.integer   :blog_id,       null: false
      t.string    :title,         null: false
      t.string    :slug,          null: false
      t.text      :content
      t.text      :excerpt        # used as preview text of a blog post
      t.string    :author
      t.integer   :year,          null: false, limit: 4
      t.integer   :month,         null: false, limit: 2
      t.boolean   :is_published,  null: false, default: true
      t.datetime  :published_at,  null: false
      t.timestamps
    end
    add_index :comfy_blog_posts, [:is_published, :year, :month, :slug],
      :name => 'index_blog_posts_on_published_year_month_slug'
    add_index :comfy_blog_posts, [:is_published, :created_at]
    add_index :comfy_blog_posts, :created_at

    create_table :comfy_blog_comments do |t|
      t.integer :post_id,       null: false
      t.string  :author,        null: false
      t.string  :email,         null: false
      t.text    :content
      t.boolean :is_published,  null: false, default: false
      t.timestamps
    end
    add_index :comfy_blog_comments, [:post_id, :created_at]
    add_index :comfy_blog_comments, [:post_id, :is_published, :created_at],
      :name => 'index_blog_comments_on_post_published_created'

    create_table :comfy_blog_categories do |t|
      t.string :name, index: true
      t.references :blog, references: :comfy_blogs, index: true, null: false

      t.timestamps null: false
    end
    add_foreign_key :comfy_blog_categories, :comfy_blogs, column: :blog_id, on_delete: :cascade

    # lookup table with index for performance
    create_table :comfy_blog_post_categories do |t|
      t.integer :post_id,       null: false
      t.string  :category_id,   null: false
    end
    add_index :comfy_blog_post_categories, [:post_id, :category_id]
  end

  def self.down
    drop_table :comfy_blogs
    drop_table :comfy_blog_posts
    drop_table :comfy_blog_comments
  end

end
