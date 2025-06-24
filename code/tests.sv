class write_full_trans extends transaction;
    function void pre_randomize();
        wr_en.rand_mode(0);
        rd_en.rand_mode(0);
        wr_en = 1;
        rd_en = 0;
    endfunction
endclass

class test_lib;
    virtual intf vif;
    env env1;
    int count;
    
    function new (virtual intf vif, int count);
        this.vif = vif;
        this.count = count;
        env1 = new(vif, count);
    endfunction
    
    task write_full_test();
        write_full_trans tn;
        tn = new();
        // tn.display();
        //$display("Running Write Full Trans");
        env1.gen.t = tn;
        env1.run();
    endtask: run

endclass
