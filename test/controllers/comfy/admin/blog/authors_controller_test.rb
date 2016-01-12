require_relative '../../../../test_helper'

class Comfy::Admin::Blog::AuthorsControllerTest < ActionController::TestCase

  def setup
    @site = comfy_cms_sites(:default)
    @blog = comfy_blog_blogs(:default)
    @author = comfy_blog_authors(:default)
  end

  def test_get_index
    get :index, :site_id => @site, :blog_id => @blog
    assert_response :success
    assert assigns(:authors)
    assert_template :index
  end

  def test_get_new
    get :new, :site_id => @site, :blog_id => @blog
    assert_response :success
    assert assigns(:author)
    assert_template :new
    assert_select "form[action='/admin/sites/#{@site.id}/blogs/#{@blog.id}/authors']"
  end

  def test_creation
    assert_difference 'Comfy::Blog::Author.count' do
      post :create, :site_id => @site, :blog_id => @blog, :author => {
        :first_name       => 'John Smith',
        :last_name        => 'Smith',
        :description      => 'Test Content'
      }
      assert_response :redirect
      assert_redirected_to :action => :edit, :id => assigns(:author)
      assert_equal 'Author created', flash[:success]
    end
  end

  def test_creation_failure
    assert_no_difference 'Comfy::Blog::Author.count' do
      post :create, :site_id => @site, :blog_id => @blog, :author => { }
      assert_response :success
      assert_template :new
      assert assigns(:author)
      assert_equal 'Failed to create author', flash[:error]
    end
  end

  def test_get_edit
    get :edit, :site_id => @site, :blog_id => @blog, :id => @author
    assert_response :success
    assert_template :edit
    assert assigns(:author)
    assert_select "form[action='/admin/sites/#{@site.id}/blogs/#{@blog.id}/authors/#{@author.id}']"
  end

  def test_get_edit_failure
    get :edit, :site_id => @site, :blog_id => @blog, :id => 'invalid'
    assert_response :redirect
    assert_redirected_to :action => :index
    assert_equal 'Author not found', flash[:error]
  end

  def test_update
    put :update, :site_id => @site, :blog_id => @blog, :id => @author, :author => {
      :first_name => 'Updated Author'
    }
    assert_response :redirect
    assert_redirected_to :action => :edit, :id => assigns(:author)
    assert_equal 'Author updated', flash[:success]

    @author.reload
    assert_equal 'Updated Author', @author.first_name
  end

  def test_update_failure
    put :update, :site_id => @site, :blog_id => @blog, :id => @author, :author => {
      :first_name => ''
    }
    assert_response :success
    assert_template :edit
    assert_equal 'Failed to update author', flash[:error]

    @author.reload
    assert_not_equal '', @author.first_name
  end

  def test_destroy
    assert_difference 'Comfy::Blog::Author.count', -1 do
      delete :destroy, :site_id => @site, :blog_id => @blog, :id => @author
      assert_response :redirect
      assert_redirected_to :action => :index
      assert_equal 'Author removed', flash[:success]
    end
  end

end
