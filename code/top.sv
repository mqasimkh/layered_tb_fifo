module top;
    mailbox gen2drv, gen2scr;
    event gen_done;
    int count;

    generator gen;
    
    initial begin
        function new();
            gen2drv = new();
            gen2scr = new();
            gen = (count, gen2drv, gen2scr);
        endfunction: new


        task run();
            g.run();
            g.t.display();
        endtask: run

        transaction t;

        forever begin
            gen2drv.get(t);
            t.display();
        end
    end

endmodule: top