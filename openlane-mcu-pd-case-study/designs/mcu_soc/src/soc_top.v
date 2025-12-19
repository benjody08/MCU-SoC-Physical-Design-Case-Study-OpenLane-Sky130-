module soc_top (
    input  wire        clk,
    input  wire        rst_n,
    output wire [7:0]  gpio_out
);

    wire [31:0] addr;
    wire [31:0] wdata;
    wire [31:0] rdata;
    wire        we;

    wire [31:0] rom_rdata;
    wire [31:0] sram_rdata;
    wire [31:0] gpio_rdata;

    simple_cpu u_cpu (
        .clk   (clk),
        .rst_n (rst_n),
        .addr  (addr),
        .wdata (wdata),
        .rdata (rdata),
        .we    (we)
    );

    rom u_rom (
        .addr  (addr[7:0]),
        .rdata (rom_rdata)
    );

    sram_wrapper u_sram (
        .clk   (clk),
        .we    (we),
        .addr  (addr[7:0]),
        .wdata (wdata),
        .rdata (sram_rdata)
    );

    gpio u_gpio (
        .clk      (clk),
        .rst_n    (rst_n),
        .we       (we),
        .addr     (addr),
        .wdata    (wdata),
        .gpio_out (gpio_out),
        .rdata    (gpio_rdata)
    );

    assign rdata =
        (addr[15:8] == 8'h00) ? rom_rdata  :
        (addr[15:8] == 8'h01) ? sram_rdata :
        (addr[15:8] == 8'h02) ? gpio_rdata :
                                32'h0;
endmodule

