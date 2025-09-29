module muxfour_one(input [3:0]D0,D1,D2,D3,input S1,S0,output reg [3:0]O);


always @(*) begin
if(S1==0 && S0==0) O = D0;
else if (S1==0 && S0==1) O = D1;
else if (S1==1 && S0==0) O = D2;
else O = D3;
end


endmodule

