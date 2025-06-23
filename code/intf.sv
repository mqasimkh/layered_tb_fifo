interface intf (input clk);
    logic rst_n;
    logic wr_en, rd_en;
    logic [7:0] data_in;
    logic [7:0] data_out;
    logic full, empty;
endinterface