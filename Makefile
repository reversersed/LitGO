run: checkout prod

i:
	@git submodule update --init
	@cd ./frontend && npm i
	@cd ./server && git submodule update --init && make i clean

clean:
	@cd ./server && make clean
	@cd ./frontend && npm run gen

checkout:
	@cd ./frontend && npm run test
	@cd ./server && make i clean gen test-verbose check

test:
	@cd ./frontend && npm run test
	@cd ./server && make i clean gen test check

start:
	@docker compose -f ./server/docker-compose.yml -f ./frontend/docker-compose.prod.yml up  --build --timestamps --wait --wait-timeout 1800 --remove-orphans -d

stop:
	@docker compose -f ./server/docker-compose.yml -f ./frontend/docker-compose.prod.yml stop

down:
	@docker compose -f ./server/docker-compose.yml -f ./frontend/docker-compose.prod.yml down

dev: clean
	@make start
	@cd ./frontend && npm run dev

prod: clean
	@make start

tuna:
	@tuna http 80