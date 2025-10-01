
module encoder(input [7:0]I,output reg [2:0]E);

always @(*)
begin
if (I[7]) E=3'b111;
else if (I[6]) E=3'b110;
else if (I[5]) E=3'b101;
else if (I[4]) E=3'b100;
else if (I[3]) E=3'b011;
else if (I[2]) E=3'b010;
else if (I[1]) E=3'b001;
else if (I[0]) E=3'b000;
else E=3'bxxx;
end


endmodule