## Test api 
__Authenticate__ - аутентификация
```
POST http://localhost:3000/authenticate
```

__Index__ - все новости
```
GET http://localhost:3000/articles
```

__Show__ - запрашиваемая новость
```
GET http://localhost:3000/articles/:id
```

__Create__ - создание новости 
```
POST http://localhost:3000/articles
```

__Update__ - обновление новости
```
PATCH http://localhost:3000/articles/:id
```

__Destroy__ - удаление новости
```
DELETE http://localhost:3000/articles/:id
```

__Authors__ - все авторы новостей
```
GET http://localhost:3000/articles_authors
```

__Author__ - все новости автора
```
GET http://localhost:3000/users/:id/articles
```

__Unread__ - все непрочитанные новости пользователя
```
GET http://localhost:3000/articles_unread
```

__Add_to_favorites__ - добавление новости в избранный список пользователя
```
POST http://localhost:3000/articles/:id/add_article_to_favorites
```

__Read__ - отметка просмотра пользователем новости
```
POST http://localhost:3000/articles/:id/read
```

### Технологии:
* Ruby ~> 2.5
* Rails 5
* RSpec
* БД Postgres
