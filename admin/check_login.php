<?php 
  if(!isset($_SESSION['login_id'])){
    echo "<script>document.location.href = '/admin/login.php'</script>";
    exit();
  }