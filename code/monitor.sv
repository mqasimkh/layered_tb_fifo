class monitor;
    virtual intf vif;
    mailbox mon2scr;
    transaction t;

    function new(mailbox mon2scr, virtual intf vif);
        this.mon2scr = mon2scr;
        this.vif = vif;
    endfunction:new

    task run();
        forever begin
            @(posedge vif.clk);
            #1ns;
            t = new();
            t.data_out = vif.data_out;
            t.full = vif.full;
            t.empty = vif.empty;
            mon2scr.put(t);
            $display("***Monitor***");
            $display("Data_out:\t%0d  |  Full_Flag:\t%0d\t  |  Empty_Flag:\t%0d\t", t.data_out, t.full, t.empty);
        end
    endtask: run


endclass: monitor