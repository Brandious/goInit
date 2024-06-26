postgres: 
	docker run --name postgres12 -p 5435:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres

createdb: 
	docker exec -it postgres12 createdb --username=root --owner=root simple_bank

dropdb: 
	docker exec -it postgres12 dropdb simple_bank

migrateup: 
	migrate -path db/migration -database "postgresql://root:secret@localhost:5435/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5435/simple_bank?sslmode=disable" -verbose down

migratereset:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5435/simple_bank?sslmode=disable" -verbose force 1

test: 
	go test -v -cover ./...

sqlc: 
	sqlc generate

.PHONY: postgres createdb