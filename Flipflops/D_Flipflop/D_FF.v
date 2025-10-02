module d_ff(D,Clk,reset,Q,Q_bar);
input D;
input Clk,reset;
output reg Q;
output Q_bar;
always @(posedge Clk)
begin
if({reset})
Q <= 1'b0;
else 
Q <= D;
end
assign Q_bar = ~Q;
endmodule




/*
1.Why only positive or negative edge is in sensitivity list : In Verilog, for sequential circuits like flip-flops, we usually write:
posedge clk = triggered only on the rising edge (0 ? 1 transition)
negedge clk = triggered only on the falling edge (1 ? 0 transition)

Why not both?
i.Flip-flops in hardware are designed to capture input at a single moment, not continuously.
ii..If we used both edges (posedge clk or negedge clk), it would behave like two flip-flops in one, which is non-standard and can cause timing hazards.
iii..Real hardware D flip-flops are either positive-edge or negative-edge triggered, not both.
*/




/*
2. Why edge-triggered, not level-triggered ?
i.Edge-triggered:
Captures input at the moment of clock edge.
Output changes instantly at edge, then holds.
This is predictable for sequential circuits and avoids race conditions.

ii.Level-triggered (transparent latch):
Output follows input as long as clock is at 1 (or 0).
Can cause problems in larger circuits, because output keeps changing while clock is high ? timing hazards(race arround condition)
--So in digital design, flip-flops (edge-triggered) are preferred for synchronous circuits, while latches (level-triggered) are sometimes used for special cases.
*/




/*
3.
Delay: If you assert rst right after a clock edge, Q will not clear immediately. You must wait until the next clock edge. 
This can be several nanoseconds depending on your clock frequency.

Glitches: In some designs, circuits downstream of the flip-flop may expect Q to clear immediately. 
With a synchronous reset, they get the old value of Q for one clock cycle, which may temporarily cause wrong logic values ? that?s what people mean by glitches.

Analogy;
Think of synchronous reset like a train that only stops at stations (clock edges):
You press the stop button (assert reset) anywhere along the track. The train (Q) won?t stop immediately ? it waits until the next station (next clock edge).

Asynchronous reset, by contrast, is like a handbrake:
You pull it, and the train stops instantly, ignoring stations (clock).
*/




/*
4.Asynchronous Reset/Set vs Clock
i. Asynchronous reset/set means: the flip-flop output changes immediately when reset/set is asserted, no matter what the clock is doing.
ii. It does not mean there is no clock at all.
a.The flip-flop still has a clock input, because it?s fundamentally a clocked device.
b.The clock controls the normal D?Q behavior, i.e., when Q follows D.
c.But when asynchronous reset/set is active, it overrides that normal clocked behavior.

iii. Think of it like this:
Normal operation: Q changes with D only at clock edges
Asynchronous reset: Q = 0 immediately, ignoring D and clock
Asynchronous set:   Q = 1 immediately, ignoring D and clock

So the clock is still there, but the reset/set acts independently of the clock.


iv. Analogy
Imagine a light controlled by a switch (clock).
Normally, the light turns on/off only when you flip the switch.
Now, imagine a fire alarm (asynchronous reset): it immediately turns the light off no matter the switch position.
The switch (clock) still exists and controls the light normally, but the fire alarm overrides it instantly.


v. Example in Verilog
module D_flipflop_async(
    input D,
    input clk,
    input arst,  // asynchronous reset
    output reg Q
);

always @(posedge clk or posedge arst) begin
    if (arst)      // async reset
        Q <= 0;    // immediately clear
    else
        Q <= D;    // normal clocked behavior
end

endmodule


posedge clk ? normal D flip-flop operation
posedge arst ? output Q goes 0 immediately, ignoring clk


? Key Points
1.Clock is still present; the flip-flop is fundamentally edge-triggered.
2.Asynchronous reset/set acts outside the clock, it overrides the normal clocked operation.
3.Useful for power-on reset or urgent control signals where you don?t want to wait for a clock edge.
*/




/*
5. Set: and Preset are often used interchangeably and mean to force the output to a logical 1 (ON) state. 
Reset: and Clear are often used interchangeably and mean to force the output to a logical 0 (OFF) state. 
Load: typically means to input a specific value into the component. 
*/