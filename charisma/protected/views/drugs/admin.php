<?php

$this->breadcrumbs = array(
	$model->label(2) => array('index'),
	Yii::t('app', 'Manage'),
);

$this->menu = array(
		array('label'=>Yii::t('app', 'List') . ' ' . $model->label(2), 'url'=>array('index')),
		array('label'=>Yii::t('app', 'Create') . ' ' . $model->label(), 'url'=>array('create')),
	);

Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
	$('.search-form').toggle();
	return false;
});
$('.search-form form').submit(function(){
	$.fn.yiiGridView.update('drugs-grid', {
		data: $(this).serialize()
	});
	return false;
});
");
$this->beginWidget('zii.widgets.CPortlet', array(
	'htmlOptions'=>array(
		'class'=>''
	)
));
$this->widget('bootstrap.widgets.TbMenu', array(
	'type'=>'pills',
	'items'=>array(
		array('label'=>'Create', 'icon'=>'icon-plus', 'url'=>Yii::app()->controller->createUrl('create'),'visible'=>Yii::app()->user->groupe!=2, 'linkOptions'=>array()),
        array('label'=>'Manage', 'icon'=>'icon-th-list', 'url'=>Yii::app()->controller->createUrl('index'), 'visible'=>Yii::app()->user->groupe!=2,'linkOptions'=>array()),
		array('label'=>'List', 'icon'=>'icon-search', 'url'=>Yii::app()->controller->createUrl('admin'),'active'=>true, 'linkOptions'=>array('class'=>'search-button')),
		array('label'=>'Export to PDF', 'icon'=>'icon-download', 'url'=>Yii::app()->controller->createUrl('GeneratePdf'), 'linkOptions'=>array('target'=>'_blank'), 'visible'=>true),
		array('label'=>'Export to Excel', 'icon'=>'icon-download', 'url'=>Yii::app()->controller->createUrl('GenerateExcel'), 'linkOptions'=>array('target'=>'_blank'), 'visible'=>true),
	),
));
$this->endWidget();
?>

<h3><?php echo Yii::t('app', 'Manage') . ' ' . GxHtml::encode($model->label(2)); ?></h3>

<?php echo GxHtml::link(Yii::t('app', 'Advanced Search'), '#', array('class' => 'search-button')); ?>
<div class="search-form" style='display:none'>
<?php $this->renderPartial('_search', array(
	'model' => $model,
)); ?>
</div><!-- search-form -->

<?php $this->widget('zii.widgets.grid.CGridView', array(
	'id' => 'drugs-grid',
	'dataProvider' => $model->search(),
	'filter' => $model,
	'columns' => array(
		'id',
		'drug',
		'cash',
		array(
        'name'=>'availability',
        'value'=>'Drugs::getAvailability($data->availability)',
        'filter'=>CHtml::listData(Drugs::getAvailabilities(), 'id', 'availability'),
        ),
        array(
        'name'=>'special',
        'value'=>'Drugs::getSpecial($data->special)',
        'filter'=>CHtml::listData(Drugs::getSpecials(), 'id', 'special'),
        ),
        array(
        'name'=>'generic',
        'value'=>'Drugs::getGeneric($data->generic)',
        'filter'=>CHtml::listData(Drugs::getGenerics(), 'id', 'generic'),
        ),
	),
)); ?>