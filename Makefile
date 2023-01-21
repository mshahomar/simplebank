postgres:
	docker run --name pgdb01 -p 0.0.0.0:5432:5432 -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=iptyTnCTxntdziSd -d postgres:13.7-alpine3.16

createdb:
	docker exec -it pgdb01 createdb --username=postgres --owner=postgres simple_bank

dropdb:
	docker exec -it pgdb01 dropdb --username=postgres simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://postgres:iptyTnCTxntdziSd@127.0.0.1:5432/simple_bank?sslmode=disable" --verbose up

migratedown:
	migrate -path db/migration -database "postgresql://postgres:iptyTnCTxntdziSd@127.0.0.1:5432/simple_bank?sslmode=disable" --verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

.PHONY: postgres createdb dropdb migrateup migratedown sqlc test
