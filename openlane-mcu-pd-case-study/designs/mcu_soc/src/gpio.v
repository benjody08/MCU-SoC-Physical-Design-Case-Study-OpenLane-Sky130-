module gpio (
    input  wire        clk,
    input  wire        rst_n,
    input  wire        we,
    input  wire [31:0] addr,
    input  wire [31:0] wdata,
    output reg  [7:0]  gpio_out,
    output reg  [31:0] rdata
);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            gpio_out <= 8'h00;
        else if (we && addr[7:0] == 8'h00)
            gpio_out <= wdata[7:0];
    end

    always @(*) begin
        rdata = {24'h0, gpio_out};
    end
endmodule

