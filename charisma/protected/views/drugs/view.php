<?php

$this->breadcrumbs = array(
	$model->label(2) => array('index'),
	GxHtml::valueEx($model),
);

$this->menu=array(
	array('label'=>Yii::t('app', 'List') . ' ' . $model->label(2), 'url'=>array('index')),
	array('label'=>Yii::t('app', 'Create') . ' ' . $model->label(), 'url'=>array('create')),
	array('label'=>Yii::t('app', 'Update') . ' ' . $model->label(), 'url'=>array('update', 'id' => $model->id)),
	array('label'=>Yii::t('app', 'Delete') . ' ' . $model->label(), 'url'=>'#', 'linkOptions' => array('submit' => array('delete', 'id' => $model->id), 'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>Yii::t('app', 'Manage') . ' ' . $model->label(2), 'url'=>array('admin')),
);
?>

<h1><?php echo Yii::t('app', 'View') . ' ' . GxHtml::encode($model->label()) . ' ' . GxHtml::encode(GxHtml::valueEx($model)); ?></h1>

<?php $this->widget('zii.widgets.CDetailView', array(
	'data' => $model,
	'attributes' => array(
'id',
'drug',
'generic',
'cash',
'availability',
'special',
	),
)); ?>


<h2>Price Histories</h2>

<?php
$modelPrice = new PriceHistory;

 $this->widget('zii.widgets.grid.CGridView', array(
	'id' => 'price-history-grid',
	'dataProvider' => $modelPrice->search(),
	'filter' => $modelPrice,
	'columns' => array(
		array(
				'name'=>'iddrug',
				'value'=>'GxHtml::valueEx($data->iddrug0)',
				'filter'=>GxHtml::listDataEx(Drugs::model()->findAllAttributes(null, true)),
				),
		'ancient_price',
		'new_price',
		'old_changedate',
		'changedate',
		/*
		array(
				'name'=>'userid',
				'value'=>'GxHtml::valueEx($data->user)',
				'filter'=>GxHtml::listDataEx(Users::model()->findAllAttributes(null, true)),
				),
		*/

	),
)); ?>