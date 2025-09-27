module full_sub(input a,b,bin,output reg dif,bor);

always @(a or b or bin)
begin
dif = a^b^bin;
bor = (~a & b) | (~(a ^ b) & bin);
end

endmodule








 
//Gate-level/Structural	         Use logic gates (and, xor, or, not) and connect them with wires.	
//Data-flow	                 Use Boolean equations with assign.	
//Behavioral	                 Use always blocks with if/else, case, etc.	



/*Key Takeaways:
1.In Verilog, ?behavioral? just means:
You describe what the circuit does, not how it?s built from gates.
You do that using:
always blocks
procedural assignments (=, <=)
control-flow statements like if, else, case, for, etc.

But you don?t have to use all of these every time.
You choose the right tool depending on the logic you need.

2.The Full Subtractor equations are direct ? no need for if or loops.
Control flow (if, case, for) is used when:
There?s branching behavior (like multiplexing or FSMs), OR
You?re describing sequential circuits.


You?ll use if/case a LOT when you write finite state machines (FSMs) or ALUs.
For pure arithmetic or logic circuits that have straightforward Boolean formulas, you can just assign the equations directly.*/