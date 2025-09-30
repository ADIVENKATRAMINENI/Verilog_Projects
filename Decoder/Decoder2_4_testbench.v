module decodertwo_four_tb;
reg [1:0]in1;
reg en1;
wire [3:0]o1;

decodertwo_four dut(.in(in1),.en(en1),.o(o1));

initial begin
$display("Time   in1   en1   |   o1");
$monitor("%0t  %b   %b   |  %b",$time,in1,en1,o1);
in1=2'b01;en1=1'b1;#10;
in1=2'b00;en1=1'b1;#10;
in1=2'b10;en1=1'b1;#10;
in1=2'b11;en1=1'b0;#10;
in1=2'b10;en1=1'b1;#10;
in1=2'b01;en1=1'b0;#10;
in1=2'b00;en1=1'b1;#10;
$display("Tested succesfully");
$finish;


end
endmodule

