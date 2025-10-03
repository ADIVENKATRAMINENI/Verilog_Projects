`timescale 1ns/1ps
module threebit_async_downrst(input rst,Clk,output [2:0]Count);// primary clock (drives LSB) // asynchronous active-high reset
//reg q0,q1,q2;
reg q2=1'b0,q1=1'b0, q0=1'b0;

 // LSB: toggle on main clock; asynchronous reset clears it instantly
always @(posedge Clk or posedge rst) begin
if(rst)
q0 <= 1'b0;
else 
q0<= ~q0;
end

// MSB: toggle on rising edge of q0; asynchronous reset also clears it
// NOTE: posedge q0 is an asynchronous clock for this FF: it creates the ripple.
always @(posedge q0 or posedge rst) begin
if({rst})
q1 <= 1'b0;
else 
q1<= ~q1;
end

always @(posedge q1 or posedge rst) begin
if({rst})
q1 <= 1'b0;
else 
q2<= ~q2;
end


assign Count ={q2,q1,q0};

endmodule


