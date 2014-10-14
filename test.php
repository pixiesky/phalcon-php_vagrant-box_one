<?php
if ($_GET['info']) {
	phpinfo(); exit;
}

date_default_timezone_set('Europe/London');
echo "I am working @ ", time(), "<br>";
echo date('l jS \of F Y h:i:s A');