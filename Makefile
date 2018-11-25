# GO
GO_VERSION := 1.11.2
GO_PLATFORM := darwin-amd64
GO_TAR_GZ := go$(GO_VERSION).$(GO_PLATFORM).tar.gz
GO_URL := https://dl.google.com/go/$(GO_TAR_GZ)

# GRPC
GRPC_BUILD_YEAR := 2018
GRPC_BUILD_MONTH := 11
GRPC_BUILD_COMMIT := e0d9692fa30cf3a7a8410a722693d5d3d68fb0fd-6619311d-4470-4a1a-b68e-b84bacb2e22c
GRPC_BUILD_VERSION := 1.18.0-dev

# PROTOC
PLATFORM := macos_x64
GRPC_PROTOC_DIR := grpc-protoc
GRPC_PROTOC_PLUGINS := https://packages.grpc.io/archive/$(GRPC_BUILD_YEAR)/$(GRPC_BUILD_MONTH)/$(GRPC_BUILD_COMMIT)/protoc/grpc-protoc_$(PLATFORM)-$(GRPC_BUILD_VERSION).tar.gz

init-grpc-protoc-plugins:
	mkdir -p $(GRPC_PROTOC_DIR)

go-install:
	wget $(GO_URL)
	sudo tar -C /usr/local -xvzf $(GO_TAR_GZ)
	rm $(GO_TAR_GZ)

grpc-protoc-plugins:	init-grpc-protoc-plugins
	wget -O grpc-protoc.tar.gz $(GRPC_PROTOC_PLUGINS)
	tar xvfz grpc-protoc.tar.gz -C $(GRPC_PROTOC_DIR)
	chmod +x $(GRPC_PROTOC_DIR)/protoc
	rm grpc-protoc.tar.gz

dep:	go-install	grpc-protoc-plugins
	go get -u google.golang.org/grpc
	go get -u github.com/golang/protobuf/protoc-get-go

protoc:
	$(GRPC_PROTOC_DIR)/protoc greet/greetpb/*.proto --go_out=plugins=grpc:.
	$(GRPC_PROTOC_DIR)/protoc calculator/proto/*.proto --go_out=plugins=grpc:.

server_greet:
	go run greet/greet_server/server.go

client_greet:
	go run greet/greet_client/client.go

server_calc:
	go run calculator/server/server.go

client_calc:
	go run calculator/client/client.go

clean_pb:
	find . -name "*.pb.go" -type f -exec rm {} +

clean: clean_pb