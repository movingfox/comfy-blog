module PostHelper
  def comfy_blog_post_seo_tags post, request
    tags = []
    title = post.seo_title || post.title
    tags << tag('meta', name: 'robots', content: "index,follow,noodp")
    tags << content_tag(:title, post.seo_title || post.title)
    tags << tag('meta', name: 'description', content: post.meta_description) if post.meta_description.present?
    tags << tag('link', rel: 'canonical', href: request.original_url.split('?').first)

    ### Facebook
    tags << tag('meta', property: 'og:locale', content: "en_US")
    tags << tag('meta', property: 'og:type', content: "article")
    tags << tag('meta', property: 'og:title', content: post.facebook_title) if post.facebook_title.present?
    tags << tag('meta', property: 'og:description', content: post.facebook_description) if post.facebook_description.present?
    tags << tag('meta', property: 'og:url', content: request.original_url)
    if post.blog.site.label.present?
      tags << tag('meta', property: 'og:site_name', content: post.blog.site.label)
    end
    tags << tag('meta', property: 'article:section', content: post.categories.first.name)
    tags << tag('meta', property: 'article:published_time', content: post.published_at.to_datetime.to_s)
    tags << tag('meta', property: 'article:modified_time', content: post.updated_at.to_datetime.to_s) if post.updated_at.present?
    tags << tag('meta', property: 'og:updated_time', content: post.updated_at.to_datetime.to_s) if post.updated_at.present?
    og_image_url = post.facebook_image.present? ? post.facebook_image.url : ''
    tags << tag('meta', property: 'og:image', content: og_image_url)

    ### Google plus: use meta_description and page title as defaults
    tags << tag('meta', itemprop: "name", content: post.gplus_name) if post.gplus_name.present?
    tags << tag('meta', itemprop: "description", content: post.gplus_description) if post.gplus_description.present?
    tags << tag('meta', itemprop: "image", content: post.gplus_image) if post.gplus_image.present?

    ### Twitter Card
    tags << tag('meta', name: 'twitter:card', content: 'summary_large_image')
    tags << tag('meta', name: 'twitter:site', content: post.twitter_site) if post.twitter_site.present?
    tags << tag('meta', name: 'twitter:creator', content: post.twitter_creator) if post.twitter_creator.present?
    tags << tag('meta', name: 'twitter:image', content: post.twitter_image) if post.twitter_image.present?
    tags << tag('meta', name: 'twitter:title', content: post.twitter_title) if post.twitter_title.present?
    tags << tag('meta', name: 'twitter:description', content: post.twitter_description) if post.twitter_description.present?

    return (tags.join("\n")).html_safe
  end
end
