class generator;
    transaction t;
    mailbox gen2drv;
    mailbox gen2scr;
    int count;
    event complete;
    int gen_count = 0;
    
    function new (int count = 0, mailbox gen2drv, mailbox gen2scr, event complete);
        this.gen2drv = gen2drv;
        this.gen2scr = gen2scr;
        this.count = count;
        this.complete = complete;
    endfunction: new

    task run();
        bit ok;
        repeat (count) begin
            t = new();
            ok = t.randomize();
            assert (ok) else $error("Randomization Failed");
            gen2drv.put(t);
            gen2scr.put(t);
            gen_count++;
        end
        -> complete;
    endtask: run


endclass: generator