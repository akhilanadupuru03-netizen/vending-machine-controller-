        `timescale 1ns / 1ps

module newspaper_vending_machine_tb;

    logic clk;
    logic reset;
    logic nickel;
    logic dime;
    logic dispense;
    logic [4:0] current_amount;

    // Connect to DUT
    newspaper_vending_machine dut (
        .clk(clk),
        .reset(reset),
        .nickel(nickel),
        .dime(dime),
        .dispense(dispense),
        .current_amount(current_amount)
    );

    // Clock: toggles every 5ns (10ns period)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Main test
    initial begin
        // Initialize
        reset = 1;
        nickel = 0;
        dime = 0;
        
        #20;  // Wait 2 clock cycles
        reset = 0;
        
        $display("Test Start");
        $display("==================");

        // ===== TEST 1: Nickel → Dime =====
        $display("\n--- Insert Nickel ---");
        @(posedge clk);
        nickel = 1;
        @(posedge clk);
        nickel = 0;
        @(posedge clk);
        $display("Amount: %0d, Dispense: %b", current_amount, dispense);

        $display("\n--- Insert Dime ---");
        @(posedge clk);
        dime = 1;
        @(posedge clk);
        dime = 0;
        @(posedge clk);
        $display("Amount: %0d, Dispense: %b", current_amount, dispense);

        $display("\n--- Auto Return to S0 ---");
        @(posedge clk);
        $display("Amount: %0d, Dispense: %b", current_amount, dispense);

        // ===== TEST 2: Dime → Dime =====
        $display("\n\n--- Insert Dime ---");
        @(posedge clk);
        dime = 1;
        @(posedge clk);
        dime = 0;
        @(posedge clk);
        $display("Amount: %0d, Dispense: %b", current_amount, dispense);

        $display("\n--- Insert Another Dime ---");
        @(posedge clk);
        dime = 1;
        @(posedge clk);
        dime = 0;
        @(posedge clk);
        $display("Amount: %0d, Dispense: %b", current_amount, dispense);

        $display("\n--- Auto Return to S0 ---");
        @(posedge clk);
        $display("Amount: %0d, Dispense: %b", current_amount, dispense);

        // ===== TEST 3: Both coins (should ignore) =====
        $display("\n\n--- Insert Both Coins ---");
        @(posedge clk);
        nickel = 1;
        dime = 1;
        @(posedge clk);
        nickel = 0;
        dime = 0;
        @(posedge clk);
        $display("Amount: %0d, Dispense: %b (should still be 0)", current_amount, dispense);

        #20;
        $finish;
    end

endmodule
