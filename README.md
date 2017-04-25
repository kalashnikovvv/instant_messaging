Да, я прочитал о том, что не нужно было делать интеграцию с мессенджерами, но не смог устоять и добавил интеграцию для телеграмма:)
Я использовал готовое решение, которое отняло минимум времени, зато приложение более приблеженно к боевому.

Я выбрал sidekiq, потому что он имеет высокую производительность, потребляет мало ресурсов и хорошо маштабируется. Это все достигается благодаря многопоточной архитектуре, поэтому код должен потокобезопасным.

### Развертывание и запуск

Уставливаем гемы
```
bundle install
```

Создаем конфигурационный файл для переменных окружения
```
cp .env.sample .env
```

Создаем конфигурационный файл для БД
```
cp config/database.yml.sample config/database.yml
```

Создаем и заполняем БД
```
bin/rake db:create db:migrate db:seed
```

Запускаем web-сервер
```
bin/rails s
```

Запускаем сервер для очередей
```
bundle exec sidekiq
```

Запускаем сервер для telegram бота
```
bundle exec ./bin/telegram_bot
```

### API

##### POST /messages

Headers:

```javascript
{
  'Authorization': 'Token token="bA8Xn-s16mruPRiskoX-gA2z0cFsGjSMxb2Xub_Zd95wyGWI90-ycDEHGdp9TM81vAGeBjS5Cu97h6coJXQ9KTGQ"'
}
```
Body:

```javascript
{
  text: 'Hello',
  user_ids: [1, 2, 3],
  messanger_types: ['telegram', 'viber'],
  send_at: '2017-04-25 14:21:39 +0300'
}
```
sent_at - необязательный параметр

### Примеры использования API

###### Сначала нужно привязать telegram аккаунта к пользователю системы

Выполняем в rails консоли
```ruby
user = User.first
puts user.registration_code
```
Ищем в telegram бота ```kalashnikovvv_bot```

Отсылаем боту ```registration_code``` из предыдущего шага


###### Мгновенная отправка
Выполняем в rails консоли
```ruby
app.post '/messages', params: { messenger_types: [:telegram], user_ids: [user.id], text: 'hello' }, headers: { 'Authorization': 'Token token="bA8Xn-s16mruPRiskoX-gA2z0cFsGjSMxb2Xub_Zd95wyGWI90-ycDEHGdp9TM81vAGeBjS5Cu97h6coJXQ9KTGQ"' }
```

###### Отложенная отправка
Выполняем в rails консоли
```ruby
app.post '/messages', params: { messenger_types: [:telegram], user_ids: [user.id], text: 'delayed', send_at:  2.minutes.since.to_s }, headers: { 'Authorization': 'Token token="bA8Xn-s16mruPRiskoX-gA2z0cFsGjSMxb2Xub_Zd95wyGWI90-ycDEHGdp9TM81vAGeBjS5Cu97h6coJXQ9KTGQ"' }
```
