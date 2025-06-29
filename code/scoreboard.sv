class scoreboard #(parameter DATA_WIDTH = 8, parameter DEPTH = 8);
    transaction actual;
    transaction expected;
    virtual intf vif;

    mailbox gen2scr;
    mailbox mon2scr;
    logic [DATA_WIDTH-1:0] queue_t [$];
    logic [DATA_WIDTH-1:0] exp_data;
    int count;
    bit full_checked = 0;

    function new(mailbox gen2scr, mailbox mon2scr);
        this.gen2scr = gen2scr;
        this.mon2scr = mon2scr;
    endfunction

    task run();
        forever begin
            gen2scr.get(expected);
            mon2scr.get(actual);

            if (!expected.rst) begin
                if (actual.empty)
                    $display("RESET TEST PASSED");
            end
            
            if (!expected.rst) begin
                queue_t.delete();
            end
            if(expected.wr_en && expected.rst) begin
                //$display("VIF: %b", expected.rst);w
                queue_t.push_back(expected.data_in);
            end

            if (queue_t.size() == DEPTH && !full_checked) begin
                #1ns;
                full_checked = 1;
                $display("Queue Size: %0d | Full Flag: %b", queue_t.size(), actual.full);
            if (actual.full)
                $display("WRITE FULL TEST PASSED");
            else
                $display("WRITE FULL TEST FAILED");
            end

            if (queue_t.size() == 0 && actual.empty) begin
                $display("READ FULL TEST PASSED — FIFO is empty");
            end


            //$display("Test before block"); 

            if(actual.rd_en) begin
                exp_data = queue_t.pop_front();
                    if(exp_data != actual.data_out)
                        $display("TEST FAILED");
                    else
                        $display("*** DATA MATCHED. TEST PASSED ***");
                end
                count++;
            end
            
            $display("Scoreboard count: %d", count);
            $display("\n");
    endtask: run

endclass