run: checkout prod

i:
	@git submodule update --init
	@cd ./frontend && npm i
	@cd ./server && git submodule update --init && make i

checkout:
	@cd ./frontend && npm run test
	@cd ./server && make i gen test-verbose check

test:
	@cd ./frontend && npm run test
	@cd ./server && make i gen test check

start:
	@docker compose -f ./server/docker-compose.yml -f ./frontend/docker-compose.prod.yml up  --build --timestamps --wait --wait-timeout 1800 --remove-orphans -d

stop:
	@docker compose -f ./server/docker-compose.yml -f ./frontend/docker-compose.prod.yml stop

down:
	@docker compose -f ./server/docker-compose.yml -f ./frontend/docker-compose.prod.yml down

dev:
	@make start
	@cd ./frontend && npm run dev

prod: 
	@cd ./server && make gen && cd .. && make start

ngrok:
	@cd ../ngrok && ngrok http 80