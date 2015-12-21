# ComfyBlog engine for Comfortable Mexican Loveseat

ComfyBlog is a simple blog management engine for the [ComfortableMexicanLoveseat](https://github.com/HitFox/comfortable_mexican_loveseat) gem we use at Hitfox. The loveseat gem was inspired by and built on top of [ComfortableMexicanSofa](https://github.com/comfy/comfortable-mexican-sofa).

## **NOTE:**
* If you already have a project setup through `foxinator-generator`, please skip to [Installation](https://github.com/HitFox/comfy-blog#installation)

## Prerequesites
* The blogging engine depends on the CMS to be setup with foxinator and loveseat gems
* So if you don't already have these included in your project's Gemfile, add them as follows:
<pre>
gem 'comfortable_mexican_loveseat'
gem 'foxinator-generator', git: 'git@github.com:HitFox/foxinator-generator.git'
</pre>
* If you haven't run the foxinator setup command, run `rails g foxinator:setup` and follow all of the steps outlined [here](https://github.com/HitFox/foxinator-generator#usage).

## Blog Features

* Ability to set up one blog per site
* User defined layout per blog
* Ability to add categories and authors
* Filtering blog posts by category and author on the front end
* SEO optimization for each blog post

## Installation

Add gem definition to your Gemfile:

    gem 'comfy_blog',
      git: 'git@github.com:HitFox/comfy-blog.git',
      tag: 'v1.13.0'

As mentioned above, the blog depends on our loveseat gem, so if you don't have the loveseat and foxinator gems, please include them in your project's Gemfile:

Then from the Rails project's root run:

    bundle install
    rails generate comfy:blog
    rake db:migrate

Add these lines in your `config/routes.rb` file:

    comfy_route :blog_admin, :path => 'admin'
    comfy_route :blog, :path => 'blog'

**NOTE:** Depending on the setup of your app, you need to know where these routes should be placed. If you have a required `locale:` scope, it should go on the bottom of the scope. If you have one language for your site, but still have a locale scope, you have to make it optional and set a default like so: `scope '(:locale)', defaults: { locale: "en" } do ... end`. When you put the above two lines within the scope now, you can have the blog under `mysite.com/blog` instead of `mysite.com/en/blog`.

Add the following conditional within the `<head>` tag in your application layout file (written in haml, can be easily converted to regular erb):

    - if content_for?(:blog_seo_data)
      = content_for(:blog_seo_data)
    - elsif @cms_page.present?
      = comfy_seo_tags

* If you have any other meta or SEO tags, wrap them in a `unless content_for?(:blog_seo_data)` conditional, to make sure the SEO data added for blog posts takes precedence. Looking for better alternatives to this, all suggestions are welcome!

Finally, if you don't have an admin user set up already, run `rake admins:create && rake admins:permit`.

When you login into `localhost:3000/en/admin`, make sure to click the "Sync" button to see the 'Blogs' section within the admin panel.

**Important:** When creating a blog in the CMS admin panel, make sure to leave the 'Path' field blank.

## Views
You should also find view templates in `/app/views/comfy/blog` folder. Feel free to adjust them as you see fit.

If you want to use something other than our default comment form on the blog posts, you can remove the bottom part of the `/views/comfy/blog/posts/show.html.haml` that has to do with the comments. Also, you can delete the `views/comfy/blog/comments` directory.

## Other configuration

* You can adjust how many blogs posts show up on one page by editing the `config.posts_per_page` option, in the `config/intializers/comfy_blog.rb` file that's generated in your application.

## Known limitations

* The original gem doesn't support multilingual blogs. Also, multiple blogs per site won't work correctly. If you have multiple sites, more than one language or need more than one blog, it will take some hacking of the routes and comfy controllers (e.g. `Comfy::Cms::BaseController`) to get that working. AppLift could be used as an example.
* SEO data will not work for the blog home page, unless there is at least one page created under the Sites tab in the CMS. The SEO logic only works for the blog posts pages.
* It seems as though when you create more than one blog for a site, the blog lookup gets messed up. So if there is one blog per site, then everything works correctly (which has been the use case every time we've used the original verison of the gem).

## Changelog

### 1.13.0 / 21-12-2015

* Added the ability to manage blog categories in the backend. Can tie blog posts to multiple categories and added a category filter on the front end for blog posts.
* Added the ability to add authors to be used for blog posts in the back end. Added an author filter on the front end for blog posts as well.
* Ability to customize SEO tags for individual blog posts has been added. See SEO limitations above.

---

Copyright 2009-2014 Oleg Khabarov
