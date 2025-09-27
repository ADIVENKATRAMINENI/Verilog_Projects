module half_sub_tb;

reg a1,b1;
wire dif1,bor1;

half_sub dut(.a(a1),.b(b1),.dif(dif1),.bor(bor1));    //half_sub(main file module name)
//DUT = the module you want to verify in the testbench.


initial begin
$display($time,"a1=%b, b1=%b, dif1=%b,bor1=%b",a1,b1,dif1,bor1);
$monitor("%0t %b %b | %b %b", $time, a1, b1, dif1, bor1);
a1=0;b1=0;#10;
a1=0;b1=1;#10;
a1=1;b1=0;#10;
a1=1;b1=1;#10;
$finish;
end

endmodule
