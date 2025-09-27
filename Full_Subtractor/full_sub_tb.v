module full_sub_tb;

reg a1,b1,bin;
wire dif1,bor1;

full_sub dut(.a(a1),.b(b1),.bin(bin),.dif(dif1),.bor(bor1));

initial 
begin
$display("Time a b bin | dif bor");
$monitor("%0t %b %b %b | %b %b",$time,a1,b1,bin,dif1,bor1);
a1=0;b1= 0;bin= 0;#10;
a1= 0;b1= 0;bin=1 ;#10;
a1= 0;b1= 1;bin= 0;#10;
a1= 0;b1=1 ;bin= 1;#10;
a1=1 ;b1= 0;bin= 0;#10;
a1=1 ;b1= 0;bin=1 ;#10;
a1=1 ;b1= 1;bin=0 ;#10;
a1=1 ;b1=1 ;bin=1 ;#10;
a1= 1;b1=1;bin=0 ;#10;
$finish;
end

endmodule
