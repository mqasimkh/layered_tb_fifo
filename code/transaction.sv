class transaction #(DATA_WIDTH = 8);
    rand bit [DATA_WIDTH-1:0] data_in;
    rand bit wr_en, rd_en;
    bit [DATA_WIDTH-1:0] data_out;
    bit full, empty;
    bit rst;
    
    function new();
        data_in = 0;
        wr_en = 1;
        rd_en = 0;
        data_out = 0;
        full = 0;
        empty = 0;
    endfunction: new

    // constraint c1 {
    //     wr_en != rd_en;
    // }

    function void display();
        $display("Data_in  :  %0d\t|\twr_en  :  %b\t|\trd_en  :  %b\t|\tdata_out  :  %d\t|\tfull  :  %b\t|\tempty  :  %b\t", data_in, wr_en, rd_en, data_out, full, empty);
    endfunction:display

    virtual function transaction #(DATA_WIDTH) clone();
        transaction #(DATA_WIDTH) t = new();
        t.wr_en   = this.wr_en;
        t.rd_en   = this.rd_en;
        t.data_in = this.data_in;
        t.data_out= this.data_out;
        t.full    = this.full;
        t.empty   = this.empty;
        t.rst = this.rst;
        return t;
    endfunction
        
endclass: transaction