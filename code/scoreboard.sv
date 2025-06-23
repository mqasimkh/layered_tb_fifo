class scoreboard;
    transaction actual;
    transaction expected;
    mailbox gen2scr;
    mailbox mon2scr;
   
    int count;

    function new(mailbox gen2scr, mailbox mon2scr);
        this.gen2scr = gen2scr;
        this.mon2scr = mon2scr;
    endfunction

    task run();
        forever begin
            gen2scr.get(expected);
            mon2scr.get(actual);

            count++;
            $display("Scoreboard count: %d", count);
            $display("\n");
        end
    endtask: run

endclass