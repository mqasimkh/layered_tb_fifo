class transaction;
    rand bit [7:0] data_in;
    rand bit wr_en, rd_en;
    bit [7:0] data_out;
    bit full, empty;
    
    function new();
        data_in = 0;
        wr_en = 1;
        rd_en = 0;
        data_out = 0;
        full = 0;
        empty = 0;
    endfunction: new

    constraint c1 {
        wr_en != rd_en;
    }

    function void display();
        $display("Data_in  :  %0d\t|\twr_en  :  %b\t|\trd_en  :  %b\t|\tdata_out  :  %d\t|\tfull  :  %b\t|\tempty  :  %b\t", data_in, wr_en, rd_en, data_out, full, empty);
    endfunction:display
        
endclass: transaction