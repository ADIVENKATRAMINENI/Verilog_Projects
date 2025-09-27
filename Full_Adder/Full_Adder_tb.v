module Full_Adder_tb;

reg a1,b1,c1;
wire sum1,carry1;

Full_Adder dut(.a(a1),.b(b1),.c(c1),.sum(sum1),.carry(carry1));

initial begin
$display("Time a b c | Sum Carry ");
$monitor("%0t %b %b %b | %b %b",$time,a1,b1,c1,sum1,carry1);
a1=0;b1=0;c1=0;#10
a1=0;b1=0;c1=1;#10
a1=0;b1=1;c1=0;#10
a1=0;b1=1;c1=1;#10
a1=1;b1=0;c1=0;#10
a1=1;b1=0;c1=1;#10
a1=1;b1=1;c1=0;#10
a1=1;b1=1;c1=1;#10
a1=1;b1=0;c1=0;#10
a1=1;b1=1;c1=1;#10
$finish;
end

endmodule
