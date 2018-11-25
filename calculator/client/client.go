package main

import (
	"context"
	"fmt"
	"log"

	"github.com/humbertodias/go-grpc-course/calculator/proto"
	"google.golang.org/grpc"
)

func main() {
	fmt.Println("Hello I'm a client")
	cc, err := grpc.Dial("localhost:50051", grpc.WithInsecure())
	if err != nil {
		log.Fatalf("could not connect: %v", err)
	}
	defer cc.Close()

	ccalc := proto.NewCalculatorServiceClient(cc)
	doUnaryCalc(ccalc)
}

func doUnaryCalc(c proto.CalculatorServiceClient) {
	fmt.Println("Starting to do a Unary RPC")
	var a, b int32
	fmt.Printf("A:")
	fmt.Scanf("%d", &a)
	fmt.Printf("B:")
	fmt.Scanf("%d", &b)
	req := &proto.CalcRequest{
		Operators: &proto.Operators{
			A: a,
			B: b,
		},
	}
	res, err := c.Sum(context.Background(), req)
	if err != nil {
		log.Printf("error while calling Greet RPC: %v", err)
	}
	log.Printf("Result %v", res.Result)
}
