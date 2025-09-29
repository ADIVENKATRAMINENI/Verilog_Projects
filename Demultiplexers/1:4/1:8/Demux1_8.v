module demux_eighttoone(input D00,input [2:0]s,output reg [7:0]y);


always @(*)
begin
y=4'b0000;
case(s)
3'b000 :y[0]=D00;
3'b001 :y[1]=D00;
3'b010 :y[2]=D00;
3'b011 :y[3]=D00;
3'b100 :y[4]=D00;
3'b101 :y[5]=D00;
3'b110 :y[6]=D00;
3'b111 :y[7]=D00;
default: y=4'b0000;
endcase

end


endmodule
