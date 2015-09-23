<!DOCTYPE html>
<head>
  <meta charset="utf-8">
  <style>
    body {
      font-family: sans-serif;
      font-size: 2em;
    }

    table {
      border: 2px solid black;
      border-radius: 5px;
      border-collapse: separate;
      border-spacing: 0;
      width: 320px;
      height: 320px;
      margin: 40px;
      float: left;
    }

    .heading {
      background: #FF4136;
      color: white;
    }

    .heading td {
      line-height: 1.4;
    }

    td {
      text-align: center;
      line-height: 1.6;
    }

  </style>
</head>
<body>
<?php
  for ($users = 0; $users < 6; $users++) {
    echo <<<EOL
<table>
  <tr class="heading">
    <td colspan="5">BAHLO</td>
  </tr>
  <tr class="heading">
    <td colspan="5">BINGO</td>
  </tr>
EOL;

    $insert_between = function($min, $max, &$array) {
      while (true) {
        $number = rand($min, $max);
        if (in_array($number, $array)) {
          continue;
        } else {
          array_push($array, $number);
          break;
        }
      }
    };

    $data = [[], [], [], [], []];

    for ($i = 0; $i < 5; $i++) {
      for ($j = 0; $j < 5; $j++) {
        $insert_between($i * 15+1, $i * 15 + 15, $data[$i]);
      }
    }

    for ($i = 0; $i < 5; $i++) {
      echo '<tr>';
      for ($j = 0; $j < 5; $j++) {
        echo sprintf('<td>%s</td>', $data[$j][$i]);
      }
      echo '</tr>';
    }

    echo '</table>';
  }
?>
</body>

