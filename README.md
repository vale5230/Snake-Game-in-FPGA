# 貪食蛇
一款經典的遊戲<br>
重現在FPGA上<br>

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
* 2. 做到碰撞偵測(碰到牆壁與自己的身體則遊戲結束)
* 3. 隨著吃到的食物數量越多，蛇的身體長度會增長並加快蛇的前進速度
* 4. 用七段顯示器將分數展現出來
- - -

## 功能影片:
* [~VEDIO~](https://www.youtube.com/watch?v=ixNvGhTQ70Y^^)
- - -

## Pin腳位:
`使用EP3C10E144C8`
<table>
  <tr>
    <th>參數名稱</th>
    <th>Pin腳位</th>
    <th>備註</th>
  </tr>
  <tr>
    <td>#</td>
    <td>*</td>
    <td>-</td>
  </tr>
  <tr>
    <td>#</td>
    <td>*</td>
    <td>-</td>
  </tr>
</table>

`Cyclone iii`
- - -

## 參考:
* https://github.com/8BitApple/VerilogSnake
- - -
