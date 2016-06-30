class ArticlesController < ApplicationController

  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
  	#@articles = Article.search(params[:search])

    @articles = Article.all
      if params[:search]
        @articles = Article.search(params[:search]).order("created_at DESC")
      else
        @articles = Article.all.order('created_at DESC')
      end
  end

  def show
  end
  
  def new
  	@article = Article.new
  end

  def edit
  end

  def create
  	@article = Article.new(allowed_params)
    
  	if @article.save

      articleName = @article
      User.all.each do |user|
        if user.active
          # Sends email to all the user when article is created.
          UserMailer.sample_email(user, articleName).deliver
        end
      end

  		redirect_to articles_path, flash: { notice: 'Article was successfully created.' }
  	else
  		render 'new'
  	end
  	#@article.save
  	#redirect_to @article
  end

  def update
  	if @article.update_attributes(allowed_params)
      redirect_to articles_path, flash: { notice: 'Article was successfully updated.' }
    else
      render 'edit'
    end
  end

  def destroy
  	@article.destroy

  	redirect_to articles_path, flash: { notice: 'Article was successfully destroyed.' }
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def allowed_params
  	params.require(:article).permit(:title, :body)
  end
end
