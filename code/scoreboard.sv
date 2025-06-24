class scoreboard #(parameter DATA_WIDTH = 8, parameter DEPTH = 8);
    transaction actual;
    transaction expected;
    virtual intf vif;

    mailbox gen2scr;
    mailbox mon2scr;
    logic [DATA_WIDTH-1:0] queue_t [$];
    logic [DATA_WIDTH-1:0] exp_data;
    int count;

    function new(mailbox gen2scr, mailbox mon2scr);
        this.gen2scr = gen2scr;
        this.mon2scr = mon2scr;
    endfunction

    task run();
        forever begin
            gen2scr.get(expected);
            mon2scr.get(actual);

            if(expected.wr_en && expected.rst) begin
                //$display("VIF: %b", expected.rst);
                queue_t.push_back(expected.data_in);
            end
            if(queue_t.size() == DEPTH) begin
                if (actual.full)
                    $display("WRITE FULL TEST PASSED");
                else
                    $display("WRITE FULL TEST FAILED");
            end
                
            if(actual.rd_en) begin
                exp_data = queue_t.pop_front();
                    if(exp_data != actual.data_out)
                        $display("Test Failed");
                    else
                        $display("Test Passed");
                end
                count++;
            end
            
            $display("Scoreboard count: %d", count);
            $display("\n");
    endtask: run

endclass