class scoreboard #(parameter DATA_WIDTH = 8);
    transaction actual;
    transaction expected;
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
            if(expected.wr_en) begin
                queue_t.push_back(expected.data_in);
            end
            if(actual.rd_en) begin
                exp_data = queue_t.pop_front();
                if(exp_data != actual.data_out) begin
                    $display("Test failed");
                    else
                    $display("Test Passed");
                end
            end
            count++;
            $display("Scoreboard count: %d", count);
            $display("\n");
        end
    endtask: run

endclass