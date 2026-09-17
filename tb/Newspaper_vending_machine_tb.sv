`timescale 1ns/1ps

module newspaper_vending_machine_tb;

    // Inputs
    logic clk;
    logic reset;
    logic nickel;
    logic dime;

    // Outputs
    logic release;
    logic [4:0] current_amount;

    // DUT
    newspaper_vending_machine dut (
        .clk(clk),
        .reset(reset),
        .nickel(nickel),
        .dime(dime),
        .release(release),
        .current_amount(current_amount)
    );

    // Clock generation: 10 ns period
    always #5 clk = ~clk;

    // Test sequence
    initial begin

        // Initial values
        clk    = 1'b0;
        reset  = 1'b1;
        nickel = 1'b0;
        dime   = 1'b0;

        // Reset
        #10;
        reset = 1'b0;

        // ------------------------------------------------
        // Test 1: Nickel + Dime = 15 cents
        // ------------------------------------------------
        $display("TEST 1: Nickel + Dime");

        #10;
        nickel = 1'b1;

        #10;
        nickel = 1'b0;

        #10;
        dime = 1'b1;

        #10;
        dime = 1'b0;

        // ------------------------------------------------
        // Test 2: Dime + Nickel = 15 cents
        // ------------------------------------------------
        $display("TEST 2: Dime + Nickel");

        #10;
        dime = 1'b1;

        #10;
        dime = 1'b0;

        #10;
        nickel = 1'b1;

        #10;
        nickel = 1'b0;

        // ------------------------------------------------
        // Test 3: Nickel + Nickel + Nickel = 15 cents
        // ------------------------------------------------
        $display("TEST 3: Nickel + Nickel + Nickel");

        #10;
        nickel = 1'b1;

        #10;
        nickel = 1'b0;

        #10;
        nickel = 1'b1;

        #10;
        nickel = 1'b0;

        #10;
        nickel = 1'b1;

        #10;
        nickel = 1'b0;

        // ------------------------------------------------
        // Test 4: Dime + Dime = 20 cents
        // ------------------------------------------------
        $display("TEST 4: Dime + Dime");

        #10;
        dime = 1'b1;

        #10;
        dime = 1'b0;

        #10;
        dime = 1'b1;

        #10;
        dime = 1'b0;

        // ------------------------------------------------
        // Test 5: Invalid input - Nickel + Dime together
        // ------------------------------------------------
        $display("TEST 5: Invalid simultaneous input");

        #10;
        nickel = 1'b1;
        dime   = 1'b1;

        #10;
        nickel = 1'b0;
        dime   = 1'b0;

        // ------------------------------------------------
        // End simulation
        // ------------------------------------------------

        #20;
        $finish;

    end

    // Monitor important signals
    initial begin
        $monitor("Time=%0t | Reset=%b | Nickel=%b | Dime=%b | Amount=%0d | Release=%b",
                 $time, reset, nickel, dime, current_amount, release);
    end

endmodule
