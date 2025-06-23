module top;
    mailbox gen2drv, gen2scr;
    event gen_done;
    int count;

    generator gen;
    transaction t;

    initial begin
        gen2drv = new();
        gen2scr = new();
        count = 0;
        gen = new(9, gen2drv, gen2scr, gen_done);

        fork
        gen.run();
        join_none
        
        forever begin
            gen2drv.get(t);
            t.display();
        end
    
    end

endmodule: top