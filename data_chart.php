<?php
  define("DB_HOST", "192.168.100.100:6607");
  define("DB_USER", "pqr");
  define("DB_PASSWORD", "Pensi2021");
  define("DB_NAME", "db_polling");
  $connect=mysqli_connect(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);

if(isset($_REQUEST["auth"]))
  {
    $authkey = $_REQUEST["auth"];
    if($authkey == "kjgdkhdfldfguttedfgr")
    {

  if($connect) {
	$sql='
	SELECT polling AS name, COUNT(polling) AS count
		FROM t_polling
		GROUP BY polling
	';

  $query=mysqli_query($connect, $sql);
  $results=array();

  while($row=mysqli_fetch_assoc($query)) {
		$results[]=$row;
  }
  echo json_encode($results);
}
  }
  }
?>
