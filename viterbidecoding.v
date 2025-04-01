module viterbidecoding (
    input wire clk,      // Clock signal
    input wire reset,    // Reset signal
    input wire in,       // Input signal
    output reg [5:4] a1recieved_out, a2recieved_out,
    output reg [3:2] a3recieved_out, a4recieved_out, b3recieved_out, b4recieved_out,
    output reg [1:0] a5recieved_out, a6recieved_out, c5recieved_out, c6recieved_out,
    output reg [1:0] d5recieved_out, d6recieved_out, b5recieved_out, b6recieved_out,
    output reg [5:0] final_output
);

    // Define expected output
    reg [5:0] expected_out = 6'b010000;

    // State parameters
    parameter a = 2'b00, b = 2'b01, c = 2'b10, d = 2'b11;

    // Registers for current and next state
    reg [1:0] cst, nst;

    // Temporary variables for calculations
    reg [3:0] x, y, z, w, p, q, r, s, t, u, v, v1, e, f;

    // Always block for state machine and computations
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset all signals
            cst <= a;
            a1recieved_out <= 2'b00;
            a2recieved_out <= 2'b00;
            a3recieved_out <= 2'b00;
            a4recieved_out <= 2'b00;
            a5recieved_out <= 2'b00;
            a6recieved_out <= 2'b00;
            b3recieved_out <= 2'b00;
            b4recieved_out <= 2'b00;
            b5recieved_out <= 2'b00;
            b6recieved_out <= 2'b00;
            c5recieved_out <= 2'b00;
            c6recieved_out <= 2'b00;
            d5recieved_out <= 2'b00;
            d6recieved_out <= 2'b00;
            final_output <= 6'b000000;
        end else begin
            case (cst)
                a: begin
                    if (in == 0) begin
                        nst = a;
                        a1recieved_out = 2'b01;
                        a3recieved_out = 2'b10;
                        a5recieved_out = 2'b11;
                    end else begin
                        nst = b;
                        a2recieved_out = 2'b11;
                        a4recieved_out = 2'b10;
                        a6recieved_out = 2'b01;
                    end
                end

                b: begin
                    if (in == 0) begin
                        nst = c;
                        b3recieved_out = 2'b10;
                        b5recieved_out = 2'b01;
                    end else begin
                        nst = d;
                        b4recieved_out = 2'b11;
                        b6recieved_out = 2'b10;
                    end
                end

                c: begin
                    if (in == 0) begin
                        nst = a;
                        c5recieved_out = 2'b01;
                    end else begin
                        nst = b;
                        c6recieved_out = 2'b11;
                    end
                end

                d: begin
                    if (in == 0) begin
                        nst = c;
                        d5recieved_out = 2'b10;
                    end else begin
                        nst = d;
                        d6recieved_out = 2'b01;
                    end
                end
            endcase

            // Update current state
            cst <= nst;

            // Hamming distance calculations
            x = (expected_out[5] ^ a1recieved_out[5]) + (expected_out[4] ^ a1recieved_out[4]);
            y = (expected_out[5] ^ a2recieved_out[5]) + (expected_out[4] ^ a2recieved_out[4]);
            z = (expected_out[3] ^ a3recieved_out[3]) + (expected_out[2] ^ a3recieved_out[2]);
            w = (expected_out[3] ^ a4recieved_out[3]) + (expected_out[2] ^ a4recieved_out[2]);
            p = (expected_out[1] ^ a5recieved_out[1]) + (expected_out[0] ^ a5recieved_out[0]);
            q = (expected_out[1] ^ a6recieved_out[1]) + (expected_out[0] ^ a6recieved_out[0]);
            r = (expected_out[3] ^ b3recieved_out[3]) + (expected_out[2] ^ b3recieved_out[2]);
            s = (expected_out[3] ^ b4recieved_out[3]) + (expected_out[2] ^ b4recieved_out[2]);
            t = (expected_out[1] ^ b5recieved_out[1]) + (expected_out[0] ^ b5recieved_out[0]);
            u = (expected_out[1] ^ b6recieved_out[1]) + (expected_out[0] ^ b6recieved_out[0]);
            v = (expected_out[1] ^ c5recieved_out[1]) + (expected_out[0] ^ c5recieved_out[0]);
            v1 = (expected_out[1] ^ c6recieved_out[1]) + (expected_out[0] ^ c6recieved_out[0]);
            e = (expected_out[1] ^ d5recieved_out[1]) + (expected_out[0] ^ d5recieved_out[0]);
            f = (expected_out[1] ^ d6recieved_out[1]) + (expected_out[0] ^ d6recieved_out[0]);

            // Combine results into final output
            final_output = {x, y, z, w, p, q};
        end
    end
endmodule
