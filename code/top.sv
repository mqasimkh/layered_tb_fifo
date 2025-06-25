module tb;
    parameter DATA_WIDTH = 8;
    parameter DEPTH = 8;
    bit clk;
    initial clk = 0;
    always #5 clk = ~clk;


    intf bus(clk);
    env env;
    test_lib test_1;


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
    initial 
        begin
            bus.rst_n = 0;
            @(posedge bus.clk);
            bus.rst_n = 1;
            @(posedge bus.clk);
            env = new(bus, DEPTH);
            env.run();




            // /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            // /////////////////////////                        Test # 1                               /////////////////////////  
            // /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            // $display("***************************************************************************************************");
            // $display("Running Write Full Test");
            // $display("***************************************************************************************************");
            // test_1 = new (bus, DEPTH + 1);
            // test_1.write_full_test();
            // test_1.run();
            
            // // $display("***************************************************************************************************");
            // // $display("Running Read Full Test");
            // // $display("***************************************************************************************************");
            // // test_1.read_full_test();

        end

endmodule