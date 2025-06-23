class driver;
    transaction t;
    mailbox gen2drv;
    virtual intf vif;

    function new (mailbox gen2drv, virtual intf vif);
        this.gen2drv = gen2drv;
        this.vif = vif;
    endfunction: new

    task run();
    forever begin
        gen2drv.get(t);
        @(posedge vif.clk);
        vif.wr_en <= t.wr_en;
        vif.rd_en <= t.rd_en;
        vif.data_in <= t.data_in;
        $display("");
        $display("*** Driver ***");
        $display("wr_en : %b | rd_en : %b | data_in : %0d |", t.wr_en, t.rd_en, t.data_in);
        @(posedge vif.clk);
    end
    endtask: run

endclass: driver