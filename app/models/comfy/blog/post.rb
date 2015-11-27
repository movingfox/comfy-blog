class Comfy::Blog::Post < ActiveRecord::Base

  self.table_name = 'comfy_blog_posts'

  # -- Relationships --------------------------------------------------------
  belongs_to :blog

  has_many :comments,
    :dependent => :destroy
  has_many :post_categories,
    class_name: Comfy::Blog::PostCategory
  has_many :categories,
    through: :post_categories,
    dependent: :nullify

  # -- Validations ----------------------------------------------------------
  validates :blog_id, :title, :slug, :year, :month, :content, :author,
    :presence   => true
  validates :slug,
    :uniqueness => { :scope => [:blog_id, :year, :month] },
    :format => { :with => /\A%*\w[a-z0-9_\-\%]*\z/i }
  validate :at_least_one_category

  # -- Scopes ---------------------------------------------------------------
  default_scope -> {
    order('published_at DESC')
  }
  scope :published, -> {
    where(:is_published => true)
  }
  scope :for_year, -> year {
    where(:year => year)
  }
  scope :for_month, -> month {
    where(:month => month)
  }

  # -- Callbacks ------------------------------------------------------------
  before_validation :set_slug,
                    :set_published_at,
                    :set_date

  # -- Instance Methods -----------------------------------------------------
  def at_least_one_category
    errors.add(:category_ids, 'Please choose at least one category.') if category_ids.empty?
  end

  def related_posts
    blog.posts.select do |post|
      post != self && post.categories.any? { |category| categories.include?(category) }
    end.last(3).sort_by(&:published_at).reverse
  end

protected

  def set_slug
    self.slug ||= self.title.to_s.downcase.slugify
  end

  def set_date
    self.year   = self.published_at.year
    self.month  = self.published_at.month
  end

  def set_published_at
    self.published_at ||= Time.zone.now
  end

end
