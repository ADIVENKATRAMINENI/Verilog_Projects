module testbenchfour_one;

reg [3:0]D00,D11,D22,D33;
reg S00,S11;
wire [3:0]O1;
muxfour_one dut(.D3(D33),.D2(D22),.D1(D11),.D0(D00),.S1(S11),.S0(S00),.O(O1));

initial
begin

$display("Time D33 D22 D11 D00 S11 S00 | O1");
$monitor("%0t %b  %b %b %b %b %b | %b ", $time,D33, D22,D11,D00,S11,S00,O1);
D33=4'b0010;D22=4'b1011;D11=4'b1010;D00=4'b1110;S00=0;S11=0;#10;
D33=4'b1110;D22=4'b1010;D11=4'b0110;D00=4'b0111;S00=0;S11=1;#10;
D33=4'b0110;D22=4'b1000;D11=4'b1010;D00=4'b0111;S00=1;S11=0;#10;
D33=4'b1110;D22=4'b1010;D11=4'b1010;D00=4'b0000;S00=0;S11=0;#10;
D33=4'b0110;D22=4'b1001;D11=4'b1010;D00=4'b0111;S00=0;S11=1;#10;
D33=4'b1011;D22=4'b1011;D11=4'b1010;D00=4'b1100;S00=1;S11=1;#10;
D33=4'b1010;D22=4'b1011;D11=4'b1010;D00=4'b1000;S00=1;S11=1;#10;
D33=4'b0110;D22=4'b1011;D11=4'b1010;D00=4'b0010;S00=1;S11=0;#10;
$display("testbench tested successfully");
$finish;
end

endmodule


