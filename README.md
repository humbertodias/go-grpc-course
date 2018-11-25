# Go-grpc course

Following the course at https://www.udemy.com/grpc-golang

## Requirements

1. Git
2. Go 1.11+
6. Makefile (Optional)

## Clone

```sh
mkdir -p ~/go/src/github.com/humbertodias && cd $_
git clone https://github.com/humbertodias/go-grpc-source
cd go-grpc-source
```

Resolve dependencies

```
make dep
```

## Run

```
make protoc
make server_greet
make client_greet
```

# References

[GoLang](https://golang.org)

[Udemy GoLang GRPC Course](https://www.udemy.com/grpc-golang)