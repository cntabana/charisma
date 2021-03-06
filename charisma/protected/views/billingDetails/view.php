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

<h3><?php echo Yii::t('app', 'View') . ' ' . GxHtml::encode($model->label()) . ' ' . GxHtml::encode(GxHtml::valueEx($model)); ?></h3>

<?php $this->widget('zii.widgets.CDetailView', array(
	'data' => $model,
	'attributes' => array(
'id',
array(
			'name' => 'idinvoice0',
			'type' => 'raw',
			'value' => $model->idinvoice0 !== null ? GxHtml::link(GxHtml::encode(GxHtml::valueEx($model->idinvoice0)), array('invoice/view', 'id' => GxActiveRecord::extractPkValue($model->idinvoice0, true))) : null,
			),
array(
			'name' => 'idmedical0',
			'type' => 'raw',
			'value' => $model->idmedical0 !== null ? GxHtml::link(GxHtml::encode(GxHtml::valueEx($model->idmedical0)), array('traitement/view', 'id' => GxActiveRecord::extractPkValue($model->idmedical0, true))) : null,
			),
'quantity',
'price',
	),
)); ?>

