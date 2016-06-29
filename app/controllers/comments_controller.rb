class CommentsController < ApplicationController
  
  before_action :set_comment, only: [:destroy]

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(params[:comment].permit(:name, :body))

    redirect_to article_path(@article)
  end

  def destroy
    @comment.destroy
    redirect_to article_path(@article), flash: { notice: 'Comment was successfully destroyed.' }
  end

  private

  def set_comment
    @article = Article.find(params[:id])
    @comment = @article.comments.find(params[:id])
  end
end
