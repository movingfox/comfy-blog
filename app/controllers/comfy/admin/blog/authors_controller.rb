class Comfy::Admin::Blog::AuthorsController < Comfy::Admin::Blog::BaseController
  before_action :load_blog
  before_action :build_author, :only => [:new, :create]
  before_action :load_author,  :only => [:edit, :update, :destroy]

  def index
    @authors = comfy_paginate(@blog.authors)
  end

  def new
    render
  end

  def create
    @author.save!
    flash[:success] = t('comfy.admin.blog.authors.created')
    redirect_to :action => :edit, :id => @author

  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = t('comfy.admin.blog.authors.create_failure')
    render :action => :new
  end

  def edit
    render
  end

  def update
    @author.update_attributes!(author_params)
    flash[:success] = t('comfy.admin.blog.authors.updated')
    redirect_to :action => :edit, :id => @author

  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = t('comfy.admin.blog.authors.update_failure')
    render :action => :edit
  end

  def destroy
    if @author.destroy
      flash[:success] = t('comfy.admin.blog.authors.deleted')
    else
      flash[:error] = t('comfy.admin.blog.authors.delete_failure')
    end
    redirect_to :action => :index
  end

protected

  def load_author
    @author = @blog.authors.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = t('comfy.admin.blog.authors.not_found')
    redirect_to :action => :index
  end

  def build_author
    @author = @blog.authors.new(author_params)
  end

  def author_params
    params.fetch(:author, {}).permit!
  end

end

