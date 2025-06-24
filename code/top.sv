module tb;
    parameter DATA_WIDTH = 8;
    parameter DEPTH = 8;
    bit clk;
    initial clk = 0;
    always #5 clk = ~clk;

    intf bus(clk);
    env env;

    synchronous_fifo #(DATA_WIDTH, DEPTH) dut (
        .clk(bus.clk), 
        .rst_n(bus.rst_n),
        .w_en(bus.wr_en), 
        .r_en(bus.rd_en),
        .data_in(bus.data_in),
        .data_out(bus.data_out),
        .full(bus.full),
        .empty(bus.empty)
    );
    initial begin
        bus.rst_n = 0;
        @(posedge bus.clk);
        bus.rst_n = 1;
    end
    initial 
        begin
            env = new(bus, 7);
            env.run();
        end

endmodule