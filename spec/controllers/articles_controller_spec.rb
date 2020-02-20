require 'rails_helper'
require 'json'

RSpec.describe ArticlesController, type: :controller do

  describe '#index' do 

    it 'status 200' do 
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'all articles' do
      articles = create_list(:article, 5)

      get :index
      expect(response.body).to match(articles.to_s)
    end
  end

  describe '#show' do 

    let(:article) { create(:article) }

    it 'status 200' do
      get :show, :params => { id: article.id } 
      expect(response).to have_http_status(:success)
    end

    it 'article' do
      get :show, :params => { id: article.id }
      expect(response.body).to match(article.head.to_s)
    end
  end

  describe '#create' do 

    let(:article) { create(:article) }
    let(:user) { create(:user) }
    let(:token) do 
      AuthenticateUser.call(user.login, user.password).result
    end
    let(:params) do 
      { 
        article: {
         id: article.id, 
         head: article.head, 
         content: article.content, 
         announcement: article.announcement,
         status: article.status } 
      }
    end
  
    it 'status 401' do
      post :create, :params => params
      expect(response.status).to eq(401)
    end

    it 'status 201' do 
      @request.headers["Authorization"] = token
      post :create, :params => params
      expect(response.status).to eq(201)
    end

    it 'created article' do 
      @request.headers["Authorization"] = token
      post :create, :params => params
      expect(response.body).to match(article.head.to_s)
    end
  end

  describe '#update' do 

    let(:article) { create(:article) }
    let(:user) { create(:user) }
    let(:token) do 
      AuthenticateUser.call(user.login, user.password).result
    end
    let(:params) do 
      { 
        id: article.id,
        article: {
         id: article.id, 
         head: "heador", 
         content: "contont", 
         announcement: "annon",
         status: article.status } 
      }
    end

    it 'status 401' do
      patch :update, :params => params
      expect(response.status).to eq(401)
    end

    it 'status 202' do 
      @request.headers["Authorization"] = token
      patch :update, :params => params
      expect(response.status).to eq(200)
    end

    it 'created article' do 
      @request.headers["Authorization"] = token
      patch :update, :params => params
      expect(response.body).to match(params[:article][:content])
    end
  end

  describe '#destroy' do 

    let(:article) { create(:article) }
    let(:user) { create(:user) }
    let(:token) do 
      AuthenticateUser.call(user.login, user.password).result
    end
    let(:params) { { id: article.id } }

    it 'status 401' do
      delete :destroy, :params => params
      expect(response.status).to eq(401)
    end

    it 'status 204' do 
      @request.headers["Authorization"] = token
      delete :destroy, :params => params
      expect(response.status).to eq(204)
    end
  end

  describe '#authors' do 

    let(:user) { create(:user) }
      
    it 'status 200' do 
      get :authors
      expect(response.status).to eq(200)
    end 

    it 'authors' do 
      author = create(:user_with_articles)
      get :authors
      expect(response.body).to match(author.id.to_s)
    end

  end

  describe '#author' do 

    let(:user) { create(:user_with_articles) }

    it 'status 200' do 
      get :author, :params => { id: user.id }  
      expect(response.status).to eq(200)
    end

    it 'articles of author' do 
      get :author, :params => { id: user.id }  
      expect(response.body).to match(user.articles.first.content.to_s)
    end
  end

  describe '#unread' do 

    let(:user) { create(:user) }
    let(:article_read) { create(:article) }
    let(:token) do 
      AuthenticateUser.call(user.login, user.password).result
    end

    it 'status 401' do
      get :unread
      expect(response.status).to eq(401)
    end

    it 'status 200' do 
      @request.headers["Authorization"] = token
      get :unread
      expect(response.status).to eq(200)
    end

    it 'unread articles of current user' do 
      @request.headers["Authorization"] = token
      user.looks.create(article_id: article_read.id)
      article = create(:article)

      get :unread
      expect(response.body).to match(article.content)
    end
  end

  describe '#add_to_favorites' do 
    let(:user) { create(:user) }
    let(:article) { create(:article) }
    let(:token) do 
      AuthenticateUser.call(user.login, user.password).result
    end

    it 'status 401' do
      get :add_to_favorites, :params => { id: article.id }
      expect(response.status).to eq(401)
    end

    it 'status 201' do 
      @request.headers["Authorization"] = token
      get :add_to_favorites, :params => { id: article.id }
      expect(response.status).to eq(201)
    end

    it 'favorite record' do 
      @request.headers["Authorization"] = token
      get :add_to_favorites, :params => { id: article.id }
      expect(response.body).to match(article.id.to_s)
    end
  end

  describe '#read' do 
    let(:user) { create(:user) }
    let(:article) { create(:article) }
    let(:token) do 
      AuthenticateUser.call(user.login, user.password).result
    end

    it 'status 401' do
      get :read, :params => { id: article.id }
      expect(response.status).to eq(401)
    end

    it 'status 200' do 
      @request.headers["Authorization"] = token
      get :read, :params => { id: article.id }
      expect(response.status).to eq(200)
    end

    it 'look record' do 
      @request.headers["Authorization"] = token
      get :read, :params => { id: article.id }
      expect(response.body).to match(article.id.to_s)
    end
  end
end
