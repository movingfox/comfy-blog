# ComfyBlog engine for Comfortable Mexican Loveseat

ComfyBlog is a simple blog management engine for the [ComfortableMexicanLoveseat](https://github.com/HitFox/comfortable_mexican_loveseat) gem we use at Hitfox. The loveseat gem was inspired by and built on top of [ComfortableMexicanSofa](https://github.com/comfy/comfortable-mexican-sofa).

## **NOTE:**
* If you already have a project setup through `foxinator-generator`, please skip to [Blog Installation](https://github.com/HitFox/comfy-blog#blog-installation)

## Pre-requesites
* The blogging engine depends on the CMS to be setup with foxinator and loveseat gems
* So if you don't already have these included in your project's Gemfile, add them as follows:
<pre>
gem 'comfortable_mexican_loveseat'
gem 'foxinator-generator',
  git: 'git@github.com:HitFox/foxinator-generator.git'
</pre>
* If you haven't run the foxinator setup command, run `rails g foxinator:setup` and follow all of the steps outlined [here](https://github.com/HitFox/foxinator-generator#usage).

## Blog Features

* Ability to set up multiple blogs per site
* User defined layout per blog

## Blog Installation

Add gem definition to your Gemfile:

<pre>
gem 'comfy_blog', '0.0.1' git: 'git@github.com:HitFox/comfy-blog.git'
</pre>

As mentioned above, the blog depends on our loveseat gem, so if you don't have the loveseat and foxinator gems, please include them in your project's Gemfile:

Then from the Rails project's root run:

    bundle install
    rails generate comfy:blog
    rake db:migrate

<h3>Routes</h3>
Make sure these lines in your `config/routes.rb` are at the bottom of the `scope ':locale' do` block (add them if they're not automatically added):


    comfy_route :blog_admin, :path => 'admin'
    comfy_route :blog, :path => 'blog'


**Important:** When creating a blog in the CMS admin panel, make sure to leave the 'Path' field blank. By default, the blog is under `localhost:3000/blog`. The path field can be used for other blogs in the future. However, it would be yet another parameter after `/blog`, so for example, a second blog for a site would be under `localhost:3000/blog/second-blog`.

<h3>Views</h3>
You should also find view templates in `/app/views/blog` folder. Feel free to adjust them as you see fit.

---

Copyright 2009-2014 Oleg Khabarov
