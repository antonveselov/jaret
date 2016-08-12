function code = EncodeRunLevelWithHuffman(p, run, bc)

code = p.huff_table_fw(run+1, bc+1);
code = code{:};