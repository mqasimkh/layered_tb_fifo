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
        t = new();
    endfunction: new

    task run();
        bit ok;
        repeat (count) begin
            transaction temp;
            ok = t.randomize();
            assert (ok) else $error("Randomization Failed");
            temp = t.clone();
            gen2drv.put(temp);
            gen2scr.put(temp);
            gen_count++;
            t.display();
        end
        -> complete;
    endtask: run

endclass: generator