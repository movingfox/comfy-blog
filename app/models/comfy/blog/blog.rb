class Comfy::Blog::Blog < ActiveRecord::Base

  self.table_name = 'comfy_blogs'

  # -- Relationhips ---------------------------------------------------------
  belongs_to :site, :class_name => 'Comfy::Cms::Site'

  has_many :posts,
    :dependent  => :destroy
  has_many :comments,
    :through    => :posts
  has_many :categories,
    dependent: :destroy

  # -- Validations ----------------------------------------------------------
  validates :site_id, :label, :identifier,
    :presence   => true
  validates :identifier,
    :format     => { :with => /\A\w[a-z0-9_-]*\z/i }
  validates :path,
    :uniqueness => { :scope => :site_id },
    :format     => { :with => /\A\w[a-z0-9_-]*\z/i },
    :presence   => true,
    :if         => 'restricted_path?' # only validates presence on first blog

  before_save :clean_blog_path

private

  def clean_blog_path
    # If we eventually want to support blogs at root level, we will have to store
    # the path as NULL to have the lookup work correctly.
    self.update_attribute(:path, nil) if self.path.eql?('')
  end

protected

  def restricted_path?
    (self.class.count > 1 && self.persisted?) ||
    (self.class.count >= 1 && self.new_record?)
  end

end
