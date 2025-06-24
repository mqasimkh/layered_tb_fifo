class env;
    virtual intf vif;
    mailbox gen2drv, gen2scr, mon2scr;
    event gen_done;
    int count;

    generator gen;
    driver drv;
    monitor mon;
    scoreboard sb;

    function new(virtual intf vif, int count);
        this.vif = vif;
        this.count = count;
        gen2drv = new();
        gen2scr = new();
        mon2scr = new();
        gen = new(count, gen2drv, gen2scr, gen_done);
        drv = new (gen2drv, vif);
        mon = new (mon2scr, vif);
        sb = new(gen2scr, mon2scr, vif);
    endfunction

    task test();
        fork
            gen.run();
            drv.run();
            mon.run();
            sb.run();
        join_none
    endtask
    
    task post_test();
        @(gen_done);
        wait(drv.drv_count >= count);
        wait(sb.count >= count);
        $display("\n");

        $display("*************************************************************************************************************");
        $display("\t\t -- TEST COMPLETED -- RESULTS\t\t");
        $display("*************************************************************************************************************");
        $display("\n");

        $display("***Generator Status***");
        $display("Total Transactions Generated : %0d\t", gen.gen_count);
        $display("\n");

        $display("***Driver Status***");
        $display("Total Packets Sent\t:   %0d", drv.drv_count);
        $display("\n");

        $display("***Scoreboard Status***");
        $display("Scoreboard Count : %0d\t", sb.count);
        $display("\n");
    endtask

    task run();
        test();
        post_test();
        $finish;
    endtask

endclass