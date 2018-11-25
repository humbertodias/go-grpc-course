package main

import (
	"context"
	"fmt"
	"log"
	"net"

	"github.com/humbertodias/go-grpc-course/calculator/proto"
	"google.golang.org/grpc"
)

type server struct{}

func (*server) Sum(ctx context.Context, req *proto.CalcRequest) (*proto.CalcResponse, error) {
	fmt.Printf("Sum function was involked with %v", req)
	a := req.GetOperators().GetA()
	b := req.GetOperators().GetB()
	result := a + b
	res := &proto.CalcResponse{
		Result: result,
	}
	return res, nil
}

func main() {
	fmt.Println("Hello")

	lis, err := net.Listen("tcp", "0.0.0.0:50051")
	if err != nil {
		log.Fatalf("Failed to listen %v", err)
	}

	s := grpc.NewServer()
	proto.RegisterCalculatorServiceServer(s, &server{})

	if err := s.Serve(lis); err != nil {
		log.Fatalf("failed to server: %v", err)
	}

}
