module top;
    mailbox gen2drv, gen2scr;
    event gen_done;
    int count;

    generator gen;
    transaction t;

    initial begin
        gen2drv = new();
        gen2scr = new();
        gen = (count, gen2drv, gen2scr, gen_done);

        task run();
            g.run();
            g.t.display();
        endtask: run
        
        forever begin
            run();
            gen2drv.get(t);
            t.display();
        end
    end

endmodule: top