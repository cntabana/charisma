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
	$.fn.yiiGridView.update('billing-drug-grid', {
		data: $(this).serialize()
	});
	return false;
});
");
?>

<h3><?php echo Yii::t('app', 'Manage') . ' ' . GxHtml::encode($model->label(2)); ?></h3>


<?php echo GxHtml::link(Yii::t('app', 'Advanced Search'), '#', array('class' => 'search-button')); ?>
<div class="search-form">
<?php $this->renderPartial('_search', array(
	'model' => $model,
)); ?>
</div><!-- search-form -->

<?php $this->widget('zii.widgets.grid.CGridView', array(
	'id' => 'billing-drug-grid',
	'dataProvider' => $model->search(),
	'filter' => $model,
	'columns' => array(
		'id',
		array(
				'name'=>'idinvoice',
				'value'=>'GxHtml::valueEx($data->idinvoice0)',
				'filter'=>GxHtml::listDataEx(Invoice::model()->findAllAttributes(null, true)),
				),
		array(
				'name'=>'iddrug',
				'value'=>'GxHtml::valueEx($data->iddrug0)',
				'filter'=>GxHtml::listDataEx(Drugs::model()->findAllAttributes(null, true)),
				),
		'quantity',
		array(
			'class' => 'CButtonColumn',
		),
	),
)); ?>