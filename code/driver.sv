class driver;
    transaction t;
    mailbox gen2drv;
    virtual intf vif;
    int drv_count = 0;


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
        $display("*****************************************************************");
        $display("Transaction # : %0d\tType: Write", drv_count+1);
        $display("*****************************************************************");
        $display("wr_en : %b | rd_en : %b | data_in : %0d |", t.wr_en, t.rd_en, t.data_in);
        drv_count++;
    end
    endtask: run

endclass: driver