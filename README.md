# 貪食蛇
一款經典的遊戲<br>
呈現在FPGA上<br>

- - -

## 前言:
組別: ` 三 `<br>
組員:
```
106321072
106321073
```
- - -

## 目錄:
* 1. [/功能](/README.md#功能)
* 2. [/功能影片](/README.md#功能影片)
* 3. [/參考](/README.md#參考)
* 4. [/Pin腳位](/README.md#Pin腳位)
- - -

## 功能:
* 1. 在8x8的LED全彩點矩陣上，隨機生成蛇的食物(會避開蛇的身體位置)
* 2. ~做到碰撞偵測(碰到牆壁與自己的身體則遊戲結束)~ (2020/01/10 修改)
* 3. ~隨著吃到的食物數量越多，蛇的身體長度會增長並加快蛇的前進速度~ (2020/01/10 修改)
* 4. 用~七段顯示器~16-bits LED將分數展現出來 (2020/01/10 修改)
* 5. 暫停功能 (2020/01/10 新增)
* 6. 超過8分就將蛇的身體變色 (2020/01/10 新增)
- - -

## 功能影片:
* [~VEDIO~](https://www.youtube.com/watch?v=ixNvGhTQ70Y^^)
- - -

## Pin腳位:
`使用EP3C10E144C8`
<table>
  <tr>
    <th>操控功能</th>
    <th>控制元件</th>
    <th>備註</th>
  </tr>
  <tr>
    <td>上</td>
    <td>S1</td>
    <td>在4 BITS SW</td>
  </tr>
  <tr>
    <td>下</td>
    <td>S2</td>
    <td>在4 BITS SW</td>
  </tr>
  <tr>
    <td>左</td>
    <td>S3</td>
    <td>在4 BITS SW</td>
  </tr>
  <tr>
    <td>右</td>
    <td>S4</td>
    <td>在4 BITS SW</td>
  </tr>
  <tr>
    <td>暫停</td>
    <td>紅色第3號</td>
    <td>在8 DIPSW</td>
  </tr>
</table>

`Cyclone iii`
- - -

## 參考:
* NULL
- - -
