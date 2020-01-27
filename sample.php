<?php

/**
 * クロージャ: 関数閉包
 */

function closureMethod() {
  $hello = 'takashi';
  $closure = function() use ($hello) {
      echo "${hello}! world!", PHP_EOL;
  };
  $closure();
}
closureMethod();

/** 
 * 無名関数の中でuse()で値渡しができる。
 */
function method() {
    $hello = 'hello';
    $closure = function() use (&$hello){  //参照渡し
        $hello = 'goodby';
        echo "${hello}! world!",  PHP_EOL;
    };
    $closure();  // => goodby! world!
    echo $hello; // => goodby
}
method();