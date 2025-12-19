module simple_cpu (
    input  wire        clk,
    input  wire        rst_n,
    output reg  [31:0] addr,
    output reg  [31:0] wdata,
    input  wire [31:0] rdata,
    output reg         we
);

    // State encoding (Verilog-safe)
    localparam IDLE        = 2'b00;
    localparam WRITE_GPIO = 2'b01;
    localparam READ_GPIO  = 2'b10;

    reg [1:0] state;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= IDLE;
            addr  <= 32'h0;
            wdata <= 32'h0;
            we    <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    addr  <= 32'h0200_0000;
                    wdata <= 32'h000000A5;
                    we    <= 1'b1;
                    state <= WRITE_GPIO;
                end

                WRITE_GPIO: begin
                    we    <= 1'b0;
                    state <= READ_GPIO;
                end

                READ_GPIO: begin
                    addr  <= 32'h0200_0000;
                    state <= IDLE;
                end

                default: begin
                    state <= IDLE;
                end
            endcase
        end
    end

endmodule

