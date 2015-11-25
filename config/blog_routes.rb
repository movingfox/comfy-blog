ComfyBlog::Application.routes.draw do
  comfy_route :cms_admin
  comfy_route :blog_admin
  comfy_route :blog
  namespace :admin do
    namespace :sites do
      namespace :blog
        resources :categories
      end
    end
  end
  comfy_route :cms, :sitemap => true
end
