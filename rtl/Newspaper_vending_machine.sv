module newspaper_vending_machine (
    input  logic       clk,
    input  logic       reset,
    input  logic       nickel,   // 5 cents
    input  logic       dime,     // 10 cents

    output logic       release,
    output logic [4:0] current_amount
);

    // FSM states
    typedef enum logic [1:0] {
        S0,         // 0 cents
        S5,         // 5 cents
        S10,        // 10 cents
        DISPENSE    // Release newspaper
    } state_t;

    state_t current_state, next_state;
    // 1. State Register
    always_ff @(posedge clk or posedge reset) begin

        if (reset)
            current_state <= S0;

        else
            current_state <= next_state;

    end


    // --------------------------------------------------
    // 2. Next-State Logic
    // --------------------------------------------------
    always_comb begin

        // By default, stay in the same state
        next_state = current_state;

        case (current_state)

            // ------------------------------------------
            // 0 cents
            // ------------------------------------------
            S0: begin

                if (nickel && !dime)
                    next_state = S5;

                else if (dime && !nickel)
                    next_state = S10;

                // Both or neither → ignore
                else
                    next_state = S0;

            end


            // ------------------------------------------
            // 5 cents
            // ------------------------------------------
            S5: begin

                if (nickel && !dime)
                    next_state = S10;

                else if (dime && !nickel)
                    next_state = DISPENSE;

                // Invalid input → ignore
                else
                    next_state = S5;

            end


            // ------------------------------------------
            // 10 cents
            // ------------------------------------------
            S10: begin

                if (nickel && !dime)
                    next_state = DISPENSE;

                else if (dime && !nickel)
                    next_state = DISPENSE;

                // Invalid input → ignore
                else
                    next_state = S10;

            end


            // ------------------------------------------
            // Dispense newspaper
            // ------------------------------------------
            DISPENSE: begin

                // After dispensing, return to 0 cents
                next_state = S0;

            end


            // Safety condition
            default: begin
                next_state = S0;
            end

        endcase

    end


    // --------------------------------------------------
    // 3. Output Logic
    // --------------------------------------------------
    always_comb begin

        // Default values
        release = 1'b0;
        current_amount = 5'd0;

        case (current_state)

            S0: begin
                current_amount = 5'd0;
                release = 1'b0;
            end

            S5: begin
                current_amount = 5'd5;
                release = 1'b0;
            end

            S10: begin
                current_amount = 5'd10;
                release = 1'b0;
            end

            DISPENSE: begin
                current_amount = 5'd0;
                release = 1'b1;
            end

            default: begin
                current_amount = 5'd0;
                release = 1'b0;
            end

        endcase

    end

endmodule
