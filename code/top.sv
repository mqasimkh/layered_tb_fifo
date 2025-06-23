module tb;
    bit clk;
    initial clk = 0;
    always #5 clk = ~clk;

    intf bus(clk);
    env env;

    synchronous_fifo dut (
        .clk(bus.clk), 
        .rst_n(bus.rst_n),
        .w_en(bus.wr_en), 
        .r_en(bus.rd_en),
        .data_in(bus.data_in),
        .data_out(bus.data_out),
        .full(bus.full),
        .empty(bus.empty)
    );

    initial 
        begin
            env = new(bus, 7);
            env.run();
        end

endmodule