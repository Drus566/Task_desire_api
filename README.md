## Test api 
* Authenticate - аутентификация
```
POST http://localhost:3000/authenticate
```
* Index - все новости
```
GET http://localhost:3000/articles
```
* Show - запрашиваемая новость
```
GET http://localhost:3000/articles/:id
```
* Create - создание новости 
```
POST http://localhost:3000/articles
```
* Update - обновление новости
```
PATCH http://localhost:3000/articles/:id
```
* Destroy - удаление новости
```
DELETE http://localhost:3000/articles/:id
```
* Authors - все авторы новостей
```
GET http://localhost:3000/articles_authors
```
* Author - все новости автора
```
GET http://localhost:3000/users/:id/articles
```
* Unread - все непрочитанные новости пользователя
```
GET http://localhost:3000/articles_unread
```
* Add_to_favorites - добавление новости в избранный список пользователя
```
POST http://localhost:3000/articles/:id/add_article_to_favorites
```
* Read - отметка просмотра пользователем новости
```
POST http://localhost:3000/articles/:id/read
```
### Технологии:
* Ruby ~> 2.5
* Rails 5
* RSpec
* БД Postgres
