class CommentsController < ApplicationController
	before_filter :require_user, :except => [:index, :show]

  def index
    @article = Article.find(params[:article_id])
    @comments = @article.comments
  end
  
  def show
    @article = Article.find(params[:article_id])
    @comment = Comment.find(params[:id])
  end
  
  def new
	@article = Article.find(params[:article_id])
    @comment = Comment.new
	@comment.article = @article
  end
  
  def create
    @article = Article.find(params[:article_id])
    @comment = Comment.new(params[:comment])
	@comment.article = @article
    if @comment.save
      flash[:notice] = "Successfully created comment."
      redirect_to article_path(@article)
    else
      render :action => 'new'
    end
  end
  
  def edit
    @article = Article.find(params[:article_id])
    @comment = Comment.find(params[:id])
  end
  
  def update
    @comment = Comment.find(params[:id])
    if @comment.update_attributes(params[:comment])
      flash[:notice] = "Successfully updated comment."
      redirect_to article_url(@comment.article_id)
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:notice] = "Successfully destroyed comment."
    redirect_to article_url(@comment.article_id)
  end
end
