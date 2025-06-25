# FIFO Verification Using SystemVerilog Layered Testbench

Created a layered testbench to verify the FIFO design and test the verification plan. Created golden model using a SV queue data structure to check the correctness of the FIFO.

First created a separate test library and added individual testcases there. For each test, used a transaction class was used, with signal configurations specific to that test. The environment was instantiated from there, but this setup didn’t work as expected.

To simplify, I added tasks for each test inside the generator class.

All classes were parameterized, so setting the FIFO depth in the top module automatically updated the design and the entire testbench accordingly.

---

## Reset Test

Started with a reset test. Since the reset is active low, I de-asserted it and checked the empty flag and other related signals. As expected, the reset test passed.

![Reset Test](screenshots/1.jpeg)

---

## read After Write Test

In this test, randomization was disabled for `wr_en` and `rd_en`. First half of the transactions were writes, and the second half were reads. The test passed and data was read correctly.

![Read After Write](screenshots/2.jpeg)

---

## Write Full Test

Passed the FIFO depth as the count from top. All transactions were writes. If working correctly, the FIFO should set the full flag once it reaches maximum capacity. The full flag was asserted correctly, and the test passed.

![Write Full Test](screenshots/3.jpeg)

---

## Read Full Test

After the write full test, the read full test was performed. All signals were set to read-only. The test ran for depth times. If working properly, the empty flag should be asserted after all reads.

As depth was set 8 and was passed as count, 8 transactions ran for write full test and 8 for read full test. So on 16th transaction, as expected the read test passed (see 2nd screenshot).

This test also passed successfully.

![Read Full Test](screenshots/4.jpeg)
