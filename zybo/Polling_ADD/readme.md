## 開発日記


ポーリングイネーブルレジスタの状態が1bitの1/0では0のときが未実行なのか実行終了なのか判別がつかない。したがって、ポーリングイネーブルレジスタの状態を2bitにして先頭をValidビット、後方をReadyビットとする。処理の流れとポーリングイネーブルレジスタの中身は次のようになる。
1. 初期状態00。
2. SW側からop0,op1をセットし10とする。
3. Validビットが有効になったらHW側が和を計算しrsltレジスタにノンブロッキング代入を行う。終了したらReadyビットを有効にし11とする。
4. Readyビットが有効になったらSW側が結果を受取、ポーリングイネーブルレジスタを初期状態00に戻す。
00 -S-> 10 -H-> 11 -S-> 00

#### 疑問
- 初期状態によっては01となり得る。実行前にリセットを掛けるべきだろうか。
- 

#### イメージコードHW側
```
reg0(Valid&Readyレジスタ),reg3(resultレジスタ),reg1(オペランド0),reg2(オペランド1)

wire[3:0]  result;
assign result = reg1[2:0] + reg2[2:0];

always @(posedge clk) begin
  if (~rst) begin//同期リセット推奨
      reg0 <= 0;
      reg1 <= 0;
      reg2 <= 0;
      reg3 <= 0;
  end else begin
    if (reg0[0]) begin
      reg3 <= result;
      //counter
      reg0[1] <= 1’b1;
    end
  end
```
#### イメージコードSW側
```
  void polling(base[], a, b):
      int result;
      int val = base[0];
      base[1] = a
      base[2] = b
      val = 0b01;
      while (val == 0b11){
        //loop
      }
      result = base[3];
      val = 0b00;
}
```

### 豆

#### ノンブロッキング代入とブロッキング代入
http://www.altima.jp/column/fpga_edison/13i-blocking.html
always文の中では独立の演算にノンブロッキング代入<=を用いる(なにもないならこっち)。ブロッキング代入は逐次的な演算に用いる
