Rails.application.routes.draw do

  # Articles controller

  get    'articles',      to: 'articles#index'
  post   'articles',      to: 'articles#create'
  get    'articles/:id',  to: 'articles#show'
  patch  'articles/:id',  to: 'articles#update'
  delete 'articles/:id',  to: 'articles#destroy'

  ## Additional

  get    'articles_authors',                      to: 'articles#authors'
  get    'users/:id/articles',                    to: 'articles#author'
  get    'articles_unread',                       to: 'articles#unread'
  post   'articles/:id/add_article_to_favorites', to: 'articles#add_to_favorites'
  post   'articles/:id/read',                     to: 'articles#read'
  
  # Authectication controller

  post   'authenticate', to: 'authentication#authenticate'

end
