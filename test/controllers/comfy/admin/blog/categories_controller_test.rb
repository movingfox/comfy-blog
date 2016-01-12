require_relative '../../../../test_helper'

class Comfy::Admin::Blog::CategoriesControllerTest < ActionController::TestCase

  def setup
    @site = comfy_cms_sites(:default)
    @blog = comfy_blog_blogs(:default)
    @category = comfy_blog_categories(:default)
  end

  def test_get_index
    get :index, :site_id => @site, :blog_id => @blog
    assert_response :success
    assert assigns(:categories)
    assert_template :index
  end

  def test_get_new
    get :new, :site_id => @site, :blog_id => @blog
    assert_response :success
    assert assigns(:category)
    assert_template :new
    assert_select "form[action='/admin/sites/#{@site.id}/blogs/#{@blog.id}/categories']"
  end

  def test_creation
    assert_difference 'Comfy::Blog::Category.count' do
      post :create, :site_id => @site, :blog_id => @blog, :category => {
        :name => 'Some Category'
      }
      assert_response :redirect
      assert_redirected_to :action => :edit, :id => assigns(:category)
      assert_equal 'Category created', flash[:success]
    end
  end

  def test_creation_failure
    assert_no_difference 'Comfy::Blog::Category.count' do
      post :create, :site_id => @site, :blog_id => @blog, :category => { }
      assert_response :success
      assert_template :new
      assert assigns(:category)
      assert_equal 'Failed to create category', flash[:error]
    end
  end

  def test_get_edit
    get :edit, :site_id => @site, :blog_id => @blog, :id => @category
    assert_response :success
    assert_template :edit
    assert assigns(:category)
    assert_select "form[action='/admin/sites/#{@site.id}/blogs/#{@blog.id}/categories/#{@category.id}']"
  end

  def test_get_edit_failure
    get :edit, :site_id => @site, :blog_id => @blog, :id => 'invalid'
    assert_response :redirect
    assert_redirected_to :action => :index
    assert_equal 'Category not found', flash[:error]
  end

  def test_update
    put :update, :site_id => @site, :blog_id => @blog, :id => @category, :category => {
      :name => 'Updated Category'
    }
    assert_response :redirect
    assert_redirected_to :action => :edit, :id => assigns(:category)
    assert_equal 'Category updated', flash[:success]

    @category.reload
    assert_equal 'Updated Category', @category.name
  end

  def test_update_failure
    put :update, :site_id => @site, :blog_id => @blog, :id => @category, :category => {
      :name => ''
    }
    assert_response :success
    assert_template :edit
    assert_equal 'Failed to update category', flash[:error]

    @category.reload
    assert_not_equal '', @category.name
  end

  def test_destroy
    assert_difference 'Comfy::Blog::Category.count', -1 do
      delete :destroy, :site_id => @site, :blog_id => @blog, :id => @category
      assert_response :redirect
      assert_redirected_to :action => :index
      assert_equal 'Category removed', flash[:success]
    end
  end

end
