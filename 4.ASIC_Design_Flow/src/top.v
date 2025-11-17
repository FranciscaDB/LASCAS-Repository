module top (
    input clock,
    input reset,
    input start_port,
    input [15:0] Voutref,
    input [15:0] Vout,
    input [15:0] Vfcref,
    input [15:0] Vfc,
    output done_port,
    output reg [6:0] D1,
    output reg [6:0] D2,
    output reg [6:0] ui,
    output reg [6:0] uv
);

    // ==============================
    // Internal registers
    // ==============================
    reg [21:0] pivo_x1_reg;
    reg [21:0] pivo_u1_reg;
    reg [21:0] pivf_x1_reg;
    reg [21:0] pivf_u1_reg;

    // Internal signals
    wire pivo_done;
    wire pivf_done;
    wire out_done;

    wire [21:0] pivo_u0, pivo_x0;
    wire [21:0] pivf_u0, pivf_x0;

    wire pivo_u0_vld, pivo_x0_vld;
    wire pivf_u0_vld, pivf_x0_vld;
    wire [6:0] D1_wire, D2_wire, ui_wire, uv_wire;
    wire D1_vld, D2_vld, ui_vld, uv_vld;

    // ==============================
    // Synchronization of done signals
    // ==============================
    reg pivo_done_reg;
    reg pivf_done_reg;
    reg start_out_reg;

    // Generate a one-cycle start_out pulse when BOTH modules have finished
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            pivo_done_reg <= 1'b0;
            pivf_done_reg <= 1'b0;
            start_out_reg <= 1'b0;
        end else begin
            // Latch that each module has finished
            if (pivo_done)
                pivo_done_reg <= 1'b1;
            if (pivf_done)
                pivf_done_reg <= 1'b1;

            // Generate a one-cycle pulse when both are done
            if (pivo_done_reg && pivf_done_reg && !start_out_reg)
                start_out_reg <= 1'b1;
            else
                start_out_reg <= 1'b0;

            // Clear flags once the 'out' module finishes
            if (out_done) begin
                pivo_done_reg <= 1'b0;
                pivf_done_reg <= 1'b0;
            end
        end
    end

    wire start_out = start_out_reg;
    assign done_port = out_done;

    // ==============================
    // Module instantiations
    // ==============================
    _Z8pivo_fun8ac_fixedILi16ELi16ELb0EL9ac_q_mode1EL9ac_o_mode1EES2_S_ILi22ELi8ELb1ELS0_1ELS1_1EES3_PS3_S4_ pivo (
        .clock(clock),
        .reset(reset),
        .start_port(start_port),
        .Vrk(Voutref),
        .Vk(Vout),
        .pivo_x1(pivo_x1_reg),
        .pivo_u1(pivo_u1_reg),
        .done_port(pivo_done),
        .pivo_u0(pivo_u0),
        .pivo_u0_vld(pivo_u0_vld),
        .pivo_x0(pivo_x0),
        .pivo_x0_vld(pivo_x0_vld)
    );

    _Z8pivf_fun8ac_fixedILi16ELi16ELb0EL9ac_q_mode1EL9ac_o_mode1EES2_S_ILi22ELi8ELb1ELS0_1ELS1_1EES3_PS3_S4_ pivf (
        .clock(clock),
        .reset(reset),
        .start_port(start_port),
        .Vrk(Vfcref),
        .Vk(Vfc),
        .pivf_x1(pivf_x1_reg),
        .pivf_u1(pivf_u1_reg),
        .done_port(pivf_done),
        .pivf_u0(pivf_u0),
        .pivf_u0_vld(pivf_u0_vld),
        .pivf_x0(pivf_x0),
        .pivf_x0_vld(pivf_x0_vld)
    );

    _Z3out8ac_fixedILi22ELi8ELb1EL9ac_q_mode1EL9ac_o_mode1EES2_PS_ILi7ELi7ELb0ELS0_2ELS1_1EES4_PS_ILi7ELi7ELb0ELS0_1ELS1_1EES6_ out (
        .clock(clock),
        .reset(reset),
        .start_port(start_out),
        .ui_22(pivo_u0),
        .uv_22(pivf_u0),
        .done_port(out_done),
        .D1(D1_wire),
        .D1_vld(D1_vld),
        .D2(D2_wire),
        .D2_vld(D2_vld),
        .ui(ui_wire),
        .ui_vld(ui_vld),
        .uv(uv_wire),
        .uv_vld(uv_vld)
    );

    // ==============================
    // Feedback registers
    // ==============================
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            pivo_x1_reg <= 22'd0;
            pivo_u1_reg <= 22'd0;
            pivf_x1_reg <= 22'd0;
            pivf_u1_reg <= 22'd0;
        end else if (out_done) begin
            pivo_x1_reg <= pivo_x0;
            pivo_u1_reg <= pivo_u0;
            pivf_x1_reg <= pivf_x0;
            pivf_u1_reg <= pivf_u0;
        end
    end

    // ==============================
    // Output registers for final visible outputs
    // ==============================
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            D1 <= 7'd0;
            D2 <= 7'd0;
            ui <= 7'd0;
            uv <= 7'd0;
        end else if (out_done) begin
            D1 <= D1_wire;
            D2 <= D2_wire;
            ui <= ui_wire;
            uv <= uv_wire;
        end
    end

endmodule
