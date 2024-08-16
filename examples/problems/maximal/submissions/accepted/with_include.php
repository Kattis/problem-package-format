<?php
echo intval(fgets(STDIN)) + intval(file_get_contents('./data.txt'));
