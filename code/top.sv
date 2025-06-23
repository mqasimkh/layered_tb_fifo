module top;
    mailbox gen2drv, gen2scr, mon2scr;
    event gen_done;
    int count;
    
    generator gen;
    transaction t;
    driver d;
    monitor m;
    bit clk;
    
    initial clk = 0;
    always #5 clk = ~clk;

    intf intf(clk);

    initial begin
        gen2drv = new();
        gen2scr = new();
        mon2scr = new();
        count = 9;
        gen = new(count, gen2drv, gen2scr, gen_done);
        d = new(gen2drv, intf);
        m = new(mon2scr, intf);

        fork
            gen.run();
            d.run();
            m.run();
        join_any

        task post_test();
        @(gen_done);
        endtask
        
        $finish;

    end

endmodule: top