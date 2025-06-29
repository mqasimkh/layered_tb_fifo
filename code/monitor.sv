class monitor;
    virtual intf vif;
    mailbox mon2scr;
    transaction t;

    function new(mailbox mon2scr, virtual intf vif);
        this.mon2scr = mon2scr;
        this.vif = vif;
    endfunction:new

    task run();
            t = new();
        forever begin
            @(posedge vif.clk);
            #1ns;
            t.data_out = vif.data_out;
            t.full = vif.full;
            t.empty = vif.empty;
            t.rd_en = vif.rd_en;
            t.wr_en = vif.wr_en;
            mon2scr.put(t);
            $display("***Monitor***");
            $display("Data_out:\t%0d  |  Full_Flag:\t%0d  |  Empty_Flag:\t%0d  |   Read:\t%b  ", t.data_out, t.full, t.empty, t.rd_en);
            $display("");
        end
    endtask: run

endclass: monitor