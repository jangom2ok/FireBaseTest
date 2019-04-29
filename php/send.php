<?php

$api_key  = "";
$base_url = "https://fcm.googleapis.com/fcm/send";

$data = array(
    "to"           => "/topics/news"
    ,"notification" => array(
                            "title" => "テスト送信タイトル2"
                            ,"body"  => "テスト送信本文2"
    )
);
$header = array(
     "Content-Type:application/json"
    ,"Authorization:key=".$api_key
);
$context = stream_context_create(array(
    "http" => array(
         'method' => 'POST'
        ,'header' => implode("\r\n",$header)
        ,'content'=> json_encode($data)
    )
));
file_get_contents($base_url,false,$context);


