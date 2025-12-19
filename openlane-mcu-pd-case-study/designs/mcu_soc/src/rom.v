module rom (
    input  wire [7:0]  addr,
    output reg  [31:0] rdata
);

    always @(*) begin
        case (addr)
            8'h00: rdata = 32'hDEADBEEF;
            8'h01: rdata = 32'h12345678;
            default: rdata = 32'h0;
        endcase
    end
endmodule

