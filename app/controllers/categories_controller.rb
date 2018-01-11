class CategoriesController < ApplicationController
  
  before_action :require_admin, except: [:index, :show]
  
  def index
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end
  
  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Category was created successfully"
      redirect_to categories_path
    else
      render 'new'
    end
  end
  
  # Input edit and update function for editing category. ref: Section 7, Lecture 151
  def edit
    @category = Category.find(params[:id])
  end
  
  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:success] = "Name was successfully updated"
      redirect_to category_path(@category)
    else
      render 'edit'
    end
  end
  
  def show
    # Link data to category/show file. ref: Section 7, Lecture 149
    @category = Category.find(params[:id])
    @category_articles = @category.articles.paginate(page: params[:page], per_page: 5)
  end
  
  private
  
  def category_params
    params.require(:category).permit(:name)
  end
  
  def require_admin
    if !logged_in? || (logged_in? and !current_user.admin?)
      flash[:danger] = "Only admin can perform that action"
      redirect_to categories_path
    end
  end
  
end