module half_sub(input a,b,output dif,bor);

//wire dif,bor;

assign dif = a^b;
assign bor = (~a)&b;


endmodule




//net - wire always in continous assignments(combination circuits) for outputs, inputs(default inputs already declared and even for outputs also no need to declare)
//reg - this is for ALWAYS OR INITIAL BLOCKS ONLY(Sequential circuits outputs, inputs default wire declared);
//In test bench if you see we declare reg a,b; and wire diff,bow; because in initial we are not using wire outputs diff or borr only a and b stimuli we are writing.
//Stimulus means these are the inputs you give it (buttons you press) to see how it behaves.