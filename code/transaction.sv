class transaction;
    rand bit [7:0] data_in;
    bit wr_en, rd_en;
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

    function void display();
        $display("Data_in : %0d | wr_en : %b | rd_en: %b | data_out : %d | full : %b | empty : %b ", data_in, wr_en, rd_en, data_out, full, empty);
    endfunction:display

endclass: transaction