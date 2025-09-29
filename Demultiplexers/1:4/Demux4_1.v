module demux_fourtoone(input D00,input [1:0]s,output reg [3:0]y);


always @(*)
begin
y=4'b0000;
case(s)
2'b00 :y[0]=D00;
2'b01 :y[1]=D00;
2'b10 :y[2]=D00;
2'b11 :y[3]=D00;
default: y=4'b0000;
endcase

end


endmodule
