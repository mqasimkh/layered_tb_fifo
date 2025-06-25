class generator;
    transaction t;
    mailbox gen2drv;
    mailbox gen2scr;
    virtual intf vif;
    int count;
    event complete;
    int gen_count = 0;
    
    function new (int count = 0, mailbox gen2drv, mailbox gen2scr, event complete, virtual intf vif);
        this.gen2drv = gen2drv;
        this.gen2scr = gen2scr;
        this.count = count;
        this.complete = complete;
        this.vif = vif;
        t = new();
    endfunction: new

    /////////////////////////////////
    /////////    Main Run   /////////
    /////////////////////////////////


    task run();
        reset_test();
        //read_after_write();
        //write_full();
        -> complete;
    endtask: run


    /////////////////////////////////
    /////////    Tests      /////////
    /////////////////////////////////

    task write_full();
        bit ok;
        repeat (count) begin
            transaction temp;
            t.wr_en.rand_mode(0);
            t.rd_en.rand_mode(0);
            t.wr_en = 1;
            t.rd_en = 0;
            ok = t.randomize();
            temp = t.clone();
            assert (ok) else $error("Randomization Failed");
            gen2drv.put(temp);
            gen2scr.put(temp);
            t.display();
            gen_count++;
        end
    endtask: write_full


    task read_after_write();
        bit ok;
        repeat (count/2) begin
            transaction temp;
            t.wr_en.rand_mode(0);
            t.rd_en.rand_mode(0);
            t.wr_en = 1;
            t.rd_en = 0;
            t.rst = 1;
            ok = t.randomize();
            temp = t.clone();
            assert (ok) else $error("Randomization Failed");

            gen2drv.put(temp);
            gen2scr.put(temp);
            t.display();
            gen_count++;
        end

        repeat (count/2) begin
            transaction temp;
            t.wr_en.rand_mode(0);
            t.rd_en.rand_mode(0);
            t.wr_en = 0;
            t.rd_en = 1;
            ok = t.randomize();
            temp = t.clone();
            assert (ok) else $error("Randomization Failed");

            gen2drv.put(temp);
            gen2scr.put(temp);
            t.display();
            gen_count++;
        end
    endtask: read_after_write

    task reset_test();
        bit ok;
            vif.rst_n <= 0;
            @(posedge vif.clk);
            repeat (2) begin
                
            transaction temp;
            t.wr_en.rand_mode(0);
            t.rd_en.rand_mode(0);
            t.wr_en = 1;
            t.rd_en = 0;
            ok = t.randomize();
            temp = t.clone();
            assert (ok) else $error("Randomization Failed");
            gen2drv.put(temp);
            gen2scr.put(temp);
            t.display();
            gen_count++;
        end
        vif.rst_n <= 1;
    endtask


endclass: generator