<!DOCTYPE html>
<head>
  <meta charset="utf-8">
  <style>
    body {
      font-family: 'Avenir Next', sans-serif;
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

    .heading td {
      background: url('file:///Users/arne/Desktop/SKBingo/SKBingo-Logo.png') center no-repeat;
      height: 85px;
      background-size: cover;
    }

    td {
      text-align: center;
      line-height: 1.6;
    }

  </style>
</head>
<body>
<?php
  for ($users = 0; $users < 8; $users++) {
    echo <<<EOL
<table>
  <tr class="heading">
    <td colspan="5"></td>
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

