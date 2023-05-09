<?php
    $scheme=$_SERVER['REQUEST_SCHEME'];
    if(isset($_SERVER['HTTP_X_FORWARDED_PROTO']))
    {
        $scheme=$_SERVER['HTTP_X_FORWARDED_PROTO'];
    }
    $host=$_SERVER['HTTP_HOST'];
    $url=$scheme.'://';
    $port=$_GET['port'];
    if (preg_match('/^(\d+\.\d+\.\d+\.\d+)(\:|$)+/i', $host, $matches))
    {
        $h=$_GET['host'];
        if($h==null){
            $h = $matches[1];
        }
        $url=$url.$h.':'.$port;
    }
    else
    {
        $key=$_GET['key'];
        if(stripos($key,'.') === false)
        {
            $host = str_replace('www.',$key.'.', $host);
            $url=$url.$host;
        }
        else
        {
            $i=stripos($host,':');
            if($i === false)
            {
                $url=$url.$key;
            }
            else
            {
                $url=$url.$key.substr($host,$i);
            }
        }
        
    }
    echo '$url='.$url.'<br/>';
    header('Location:'.$url);
    exit();
?>
