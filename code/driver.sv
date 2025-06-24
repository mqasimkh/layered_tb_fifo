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

        $display("***************************************************************************************************");
        $display("Transaction # : %0d\tRead : %b\tWrite : %b\tData_In : %0d\tReset : %b", drv_count+1, t.rd_en, t.wr_en, t.data_in, vif.rst_n);
        //$display("vif.wr_en: %b | vif.rd_en: %b | vif.data_in: %0d", vif.wr_en, vif.rd_en, vif.data_in);
        $display("***************************************************************************************************");
        
        drv_count++;
    end
    endtask: run

endclass: driver