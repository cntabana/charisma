<?php
/* @var $this ReportController */

$this->breadcrumbs=array(
	'Report by Payment',
);
?>
<div>
<a href='?r=memberReport'>Members(Type)</a>&nbsp;&nbsp;|&nbsp;&nbsp;
<a href='?r=memberReport/reportbyGender'>Members(Gender)</a>&nbsp;&nbsp;|&nbsp;&nbsp;
<a href='?r=memberReport/reportbyAges'>Members(Ages)</a>&nbsp;&nbsp;|&nbsp;&nbsp;
</div>
<hr>
<div><?php

$this->Widget('ext.highcharts.HighchartsWidget', array(
        'options'=>array(
           // 'chart'=> array('type'=>'bar'),
			'chart'=> array('type'=>'column'),
		    'tooltip'=>array ('valueSuffix'=> ' Persons'), 
			'legend'=>array('borderWidth'=> 1),
            'credits'=>array('enabled'=>false),
            'title' => array('text'=>$title),
            'legend'=> array('enabled'=>false),
            'plotOptions'=>array('bar'=>array('dataLabels'=>array('enabled'=>true))),
            'xAxis' => array('categories'=>$data),
            'yAxis' => array('title'=>array('text'=>'Number')),
            'series' => array(array('name' => 'Counts', 'data' => $num),
        ))
     ));

?></div>

