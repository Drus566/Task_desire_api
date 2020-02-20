class ArticlesController < ApplicationController

  skip_before_action :authenticate_request, only: [:index, :show, :authors, :author]
  before_action :set_article, only: [:show, :update, :destroy, :add_to_favorites, :read]

  # GET /articles
  def index 
    @articles = Article.all
    render json: @articles
  end

  # POST /articles
  def create
    @article = @current_user.articles.build(article_params)
    if @article.save
      render json: @article, status: :created      
    else
      render json: @article.errors, status: 400
    end
  end

  # GET /articles/:id
  def show
    render json: @article
  end

  # PATCH/PUT /articles/:id
  def update
    if @article.update(article_params)
      render json: @article, statis: 202
    else
      render json: @article.errors, status: 400
    end
  end 

  # DELETE /articles/:id
  def destroy
    @article.destroy
    render status: 204
  end

  # GET /articles_authors
  def authors
    @users = User.joins(:articles).distinct
    render json: @users
  end

  # GET /users/:id/articles
  def author    
    @user = User.find(params[:id])
    render status: 404 unless @user
    
    @articles = @user.articles 
    render json: @articles
  end

  # GET /articles_unread
  def unread 
    @unread_ids = @current_user.looks.pluck(:article_id)
    @articles = Article.all.where.not(id: @unread_ids)

    render json: @articles
  end

  # POST /articles/:id/add_article_to_favorites
  def add_to_favorites
    @favorite = @current_user.favorites.build(article_id: @article.id)

    if @favorite.save
      render json: @favorite, status: :created
    else
      render json: @favorite.errors, status: 400
    end
  end

  # POST /articles/:id/read
  def read 
    @look = @current_user.looks.build(article_id: @article.id)

    if @look.save 
      render json: @look
    else
      render json: @look.errors, status: 400 unless @look.save
    end
  end 

  private 

    def article_params
      params.require(:article).permit(:head, :announcement, :content, :status)
    end

    def set_article 
      @article = Article.find(params[:id])
      render status: 404 unless @article
    end
end
