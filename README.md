Este é um mvp de uma marketplace/catálogo para lojas.

Primeiro, é necessário criar um arquivo .env na raiz da aplicação. Adicione as senguintes chaves privadas:

AWS_FOG_DIRECTORY

AWS_KEY_ID

AWS_SECRET_KEY

REDIS_URL

Após isso:

rails db:create db:migrate db:seed

