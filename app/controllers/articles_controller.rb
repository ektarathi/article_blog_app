class ArticlesController < ApplicationController

  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
  	@articles = Article.all.order('created_at DESC')
  end
  
  def new
  	@article = Article.new
  end

  def edit
  end

  def create
  	@article = Article.new(allowed_params)
  	if @article.save
  		redirect_to articles_path, flash: { notice: 'Article was successfully created.' }
  	else
  		render 'new'
  	end
  	#@article.save
  	#redirect_to @article
  end

  def show
  end

  def update
  	if @article.update(allowed_params)
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  def destroy
  	#@article.destroy
  	#redirect_to articles_path
  	if @article.destroy
      flash[:notice] = "Article was successfully destroyed."
    else
      flash[:error] = "There was an error completing the item."
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def allowed_params
  	params.require(:article).permit(:title, :body)
  end
end
