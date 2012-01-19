# ComfyBlog [![Build Status](https://secure.travis-ci.org/comfy/comfy-blog.png)](http://travis-ci.org/comfy/comfy-blog) [![Dependency Status](https://gemnasium.com/comfy/comfy-blog.png)](https://gemnasium.com/comfy/comfy-blog)

ComfyBlog is an simple blog management engine for Rails 3.1 apps. It also integrates with [ComfortableMexicanSofa](https://github.com/comfy/comfortable-mexican-sofa) CMS Engine

## Installation

Add gem definition to your Gemfile:
    
    gem 'comfy_blog'
    
Then from the Rails project's root run:
    
    bundle install
    rails g blog
    rake db:migrate
    
Now you should be able to go to `/admin/blog/posts` and add new blog posts.

## Configuration

You'll notice that you can access blog's admin area without any type of authentication.
This is because ComfyBlog doesn't deal with users, it only knows how to save and show 
blog posts. You probably want to put blog's admin controllers behind your controller
that handles authentication. For that you need to adjust `comfy_blog` initializer.
    
    config.admin_controller = 'YourAdminBaseController'
    
If you want blog's controller paths to match your admin path, like `cms-admin`. Change
the following configuration.
    
    config.admin_route_prefix = 'cms-admin'
    
By default blog posts are served from the root. If you want to section off blog content
to a `/blog` path. Adjust this configuration:
    
    config.public_route_prefix = 'blog'
    
Provided views to display blog posts are pretty basic and you'll probably want to change
them right away. You can change the layout from the default `application` to something else.
    
    config.public_layout = 'blog'
    
Since ComfyBlog is an engine, it allows you to completely overwrite views. It's enough to
create `app/views/blog/posts/index.html.erb` (could be HAML or whatever you want) and structure
it in any way you want. There's also `show.html.erb` and `_post.html.erb` available.
    
You can control number of posts per page by adjusting this config:
    
    config.posts_per_page = 10
    
Posted comments will be sitting in the queue waiting to be published. You can auto publish them
by setting this to `true`:

    config.auto_publish_comments = true


ComfyBlog is released under the [MIT license](https://github.com/comfy/comfy-blog/raw/master/LICENSE) 

Copyright 2012 Oleg Khabarov, [The Working Group Inc](http://www.twg.ca)