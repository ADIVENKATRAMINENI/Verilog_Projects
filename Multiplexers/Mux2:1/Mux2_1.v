module muxtwo_one(input D0,D1,S,output wire O);

assign O=(~S & D0) | (S & D1);

endmodule
