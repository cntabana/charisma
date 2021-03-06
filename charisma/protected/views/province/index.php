<?php

$this->breadcrumbs = array(
	Province::label(2),
	Yii::t('app', 'Index'),
);

$this->menu = array(

	array('label'=>Yii::t('app', 'Manage') . ' ' . District::label(2), 'url' => array('admin')),
);
$this->beginWidget('zii.widgets.CPortlet', array(
	'htmlOptions'=>array(
		'class'=>''
	)
));
$this->widget('bootstrap.widgets.TbMenu', array(
	'type'=>'pills',
	'items'=>array(
		array('label'=>'Create', 'icon'=>'icon-plus', 'url'=>Yii::app()->controller->createUrl('create'), 'linkOptions'=>array()),
                array('label'=>'List', 'icon'=>'icon-th-list', 'url'=>Yii::app()->controller->createUrl('index'),'active'=>true, 'linkOptions'=>array()),
		array('label'=>'Manage', 'icon'=>'icon-search', 'url'=>Yii::app()->controller->createUrl('admin'), 'linkOptions'=>array('class'=>'search-button')),
		array('label'=>'Export to PDF', 'icon'=>'icon-download', 'url'=>Yii::app()->controller->createUrl('GeneratePdf'), 'linkOptions'=>array('target'=>'_blank'), 'visible'=>true),
		array('label'=>'Export to Excel', 'icon'=>'icon-download', 'url'=>Yii::app()->controller->createUrl('GenerateExcel'), 'linkOptions'=>array('target'=>'_blank'), 'visible'=>true),
	),
));
$this->endWidget();
?>

<h3><?php echo GxHtml::encode(Province::label(2)); ?></h3>

<?php //$this->widget('zii.widgets.CListView', array(
	//'dataProvider'=>$dataProvider,
	//'itemView'=>'_view',
//)); 

	$this->widget('bootstrap.widgets.TbGridView', array(
    'id' => 'user-grid',
    'itemsCssClass'=>'table table-striped table-bordered table-condensed',
    'dataProvider'=> $dataProvider,
    'columns'=>array(
        array(
           'class' => 'ext.editable.EditableColumn',
           'name' => 'province',
           'headerHtmlOptions' => array('style' => 'width: 110px'),
           'editable' => array(
                  'url'        => $this->createUrl('province/update'),
                  'placement'  => 'right',
                  'inputclass' => 'span3',
              )               
        ),
               
                
    ),
));