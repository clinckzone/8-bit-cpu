`timescale 1ns / 1ps

module cpu_tb();
    reg clk;
    reg reset;
    reg [7:0] expected_out;
    reg [3:0] expected_status;

    wire [7:0] out;
    wire [3:0] status;

    cpu dut(
        .clk(clk),
        .reset(reset),
        .out(out),
        .status(status)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("cpu.vcd");
        $dumpvars(0, cpu_tb);

        clk = 1'b0;
        reset = 1'b1;

        repeat (2) #5;
        reset = 1'b0;        
        
        repeat (200) #5; 
        $finish;
    end

endmodule
